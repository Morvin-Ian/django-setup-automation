#!/bin/bash

echo "Django Setup (Morvin-Ian)"

# Check if pip is installed
if which pip >/dev/null 2>&1; then
    echo "pip is already installed."
else
    echo "Installing pip..."
    # Install pip
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    rm get-pip.py
    echo "pip installed successfully."
fi


# Name of the virtual environment
venv_name="venv"

# Check if virtualenv is installed
if which virtualenv >/dev/null 2>&1; then
    echo "Creating a virtual environment..."
    # Create the virtual environment
    virtualenv "$venv_name"
    echo "Virtual environment created successfully."
else
    echo "Error: virtualenv is not installed. Please install virtualenv."
    exit 1
fi

source "${venv_name}/local/bin/activate"

# Check if Django is already installed
if pip show django >/dev/null 2>&1; then
    echo "Django is already installed."
else
    echo "Django is not installed. Installing..."
    pip install django
fi

# # Prompt the user for input of project name
read -p "Project name: " projectName
read -p "First app name: " appName

# # Check if the project or app name already exists
if [ -d "$projectName" ]; then
    echo "Project $projectName already exists."
else
    # Create the Django project
    django-admin startproject "$projectName" .

fi

# Check if the app name already exists
if [ -d "$appName" ]; then
    echo "App $appName already exists."
else
    # Create the Django app
    python manage.py startapp "$appName"
fi


new_app="  '${appName}',"
template_setup=
templates_dir="BASE_DIR/templates"

pattern="django.contrib.staticfiles"   # Example: Insert after the line containing "Insertion point"
template_pattern=
# Append the text to the file at the specified location using sed
sed -i "/${pattern}/a ${new_app}" "${projectName}/settings.py" 

#Make urls.py in the app
cd $appName
touch urls.py

view_code="\n\ndef index(request):\n    return render(request, 'index.html')"

url_code="from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path('index/', views.index, name='index')\n]"

echo -e "\n$view_code" >> views.py

echo -e "\n$url_code" >> urls.py

mkdir frontend && cd frontend && mkdir templates && mkdir static




