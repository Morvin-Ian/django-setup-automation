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

#Settings.py setup
sed -i "/${pattern}/a ${new_app}" "${projectName}/settings.py" 
sed -i "s|'DIRS': \[\]|'DIRS': \[${template_url_setup}\]|" "${projectName}/settings.py"
echo "$settings_to_append" >> "${projectName}/settings.py"

#Main urls.py
sed -i "s/from django.urls import path/from django.urls import path, include/" "${projectName}/urls.py"
sed -i "s|path('admin/', admin.site.urls),|path('admin/', admin.site.urls),\n\tpath('', include('${appName}.urls'))|" "${projectName}/urls.py"
echo "$url_settings_to_append" >> "${projectName}/urls.py"

#Make urls.py in the app
cd $appName
touch urls.py

view_code="\n\ndef index(request):\n    return render(request, '${appName}/index.html')"

url_code="from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path('', views.index, name='index')\n]"

echo -e "\n$view_code" >> views.py

echo -e "\n$url_code" >> urls.py

cd ..