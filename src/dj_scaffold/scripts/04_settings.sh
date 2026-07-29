#!/bin/bash

new_app="'${appName}',"
template_url_setup="os.path.join(BASE_DIR, 'frontend/templates')"

# Static & media settings to insert before the last line of settings.py
static_media_settings=$(cat << 'EOL'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'frontend/static')
]

STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
EOL
)

# URL settings to append to urls.py
url_settings_to_append=$(cat << 'EOL'
from django.conf import settings
from django.conf.urls.static import static

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
EOL
)

# Function to check if the OS is macOS
is_mac() {
  [[ $(uname) == "Darwin" ]]
}

# Function to run sed command with appropriate flags
run_sed_command() {
  local file="$1"
  local command="$2"

  if is_mac; then
    sed -i '' "$command" "$file"
  else
    sed -i "$command" "$file"
  fi
}

settings_file="${projectName}/settings.py"

# Register the new app in INSTALLED_APPS (add after 'django.contrib.staticfiles')
run_sed_command "$settings_file" "/^    'django\.contrib\.staticfiles',/a \\    ${new_app}"

# Update TEMPLATES DIRS to include the frontend/templates directory
run_sed_command "$settings_file" "s|'DIRS': \[\]|'DIRS': [${template_url_setup}]|"

# Append static/media settings before the last line of settings.py
# (avoids putting them outside any block and keeps them before the closing)
last_line=$(tail -1 "$settings_file")
head -n -1 "$settings_file" > "${settings_file}.tmp" && mv "${settings_file}.tmp" "$settings_file"
echo "$static_media_settings" >> "$settings_file"
echo "" >> "$settings_file"
echo "$last_line" >> "$settings_file"

urls_file="${projectName}/urls.py"

# Add `include` to the path import
run_sed_command "$urls_file" "s/from django.urls import path/from django.urls import path, include/"

# Add a path to the new app's urls
if grep -q "path('', include('${appName}.urls'))" "$urls_file" 2>/dev/null; then
    :
else
    sed_escaped_app=$(printf '%s\n' "$appName" | sed 's/[\/&]/\\&/g')
    run_sed_command "$urls_file" "s|path('admin/', admin.site.urls),|path('admin/', admin.site.urls),\n    path('', include('${sed_escaped_app}.urls')),|"
fi

# Append media/static URL configuration
echo "$url_settings_to_append" >> "$urls_file"

# Make urls.py in the app directory
cd "$appName"
touch urls.py

view_code="\n\ndef index(request):\n    return render(request, '${appName}/index.html')"

url_code="from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path('', views.index, name='index')\n]"

echo -e "$view_code" >> views.py

echo -e "$url_code" >> urls.py

cd ..
