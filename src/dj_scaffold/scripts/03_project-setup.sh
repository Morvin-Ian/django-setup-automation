#!/bin/bash

# Prompt the user for input of project name
read -p "Project name: " projectName
read -p "First app name: " appName

# Validate that inputs are not empty
if [ -z "$projectName" ] || [ -z "$appName" ]; then
    echo "Project name and app name cannot be empty."
    exit 1
fi

# Validate that names contain no spaces and are valid Python identifiers
if [[ ! "$projectName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] || [[ ! "$appName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    echo "Input must start with a letter or underscore and contain only letters, digits, or underscores (no spaces, hyphens, or special characters)."
    exit 1
fi

# Check if `django-admin` is available
if ! command -v django-admin &> /dev/null; then
    echo "django-admin command not found. Is Django installed correctly in the virtual environment?"
    exit 1
fi

# Check if the project directory already exists
if [ -d "$projectName" ]; then
    echo "Project directory '$projectName' already exists."
    exit 1
fi

# Create the Django project
django-admin startproject "$projectName" .

# Check if the app directory already exists
if [ -d "$appName" ]; then
    echo "App directory '$appName' already exists."
    exit 1
fi

# Create the Django app
django-admin startapp "$appName"
