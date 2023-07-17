#!/bin/bash

# Prompt the user for input of project name
read -p "Project name: " projectName
read -p "First app name: " appName

if [[ $projectName == *" "* ]]; then
    echo "Input should not contain any spaces."
    exit 1

fi

# Check if the project or app name already exists
if [ -d "$projectName" ]; then
    echo "Project $projectName already exists."
    exit 1

else
    # Create the Django project
    django-admin startproject "$projectName" .

fi


# Check if the app name already exists
if [ -d "$appName" ]; then
    echo "App $appName already exists."
    exit 1

else
    # Create the Django app
    django-admin startapp "$appName"
fi


#rename the folder to project name
cd ..

old_folder="django-setup-automation"
new_folder="$projectName"

mv "$old_folder" "$new_folder"


cd "$new_folder"
