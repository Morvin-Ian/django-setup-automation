#!/bin/bash

new_app="'${appName}',"
template_url_setup="BASE_DIR/'frontend/templates'"

# Settings to append
settings_to_append=$(cat << EOL
import os

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'frontend/static')
]

STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
EOL
)

# Url Settings to append
url_settings_to_append=$(cat << EOL
from django.conf import settings
from django.conf.urls.static import static

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
EOL

)

# Example: Insert after the line containing "Insertion point"
pattern="django.contrib.staticfiles"  

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


run_sed_command "${projectName}/settings.py" "/${pattern}/a ${new_app}"
run_sed_command "${projectName}/settings.py" "s|'DIRS': \[\]|'DIRS': \[${template_url_setup}\]|"
echo "$settings_to_append" >> "${projectName}/settings.py"


run_sed_command "${projectName}/urls.py" "s/from django.urls import path/from django.urls import path, include/"
run_sed_command "${projectName}/urls.py" "s|path('admin/', admin.site.urls),|path('admin/', admin.site.urls),\n\tpath('', include('${appName}.urls'))|"
echo "$url_settings_to_append" >> "${projectName}/urls.py"


#Make urls.py in the app
cd $appName
touch urls.py

view_code="\n\ndef index(request):\n    return render(request, '${appName}/index.html')"

url_code="from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path('', views.index, name='index')\n]"

echo -e "\n$view_code" >> views.py

echo -e "\n$url_code" >> urls.py

cd ..