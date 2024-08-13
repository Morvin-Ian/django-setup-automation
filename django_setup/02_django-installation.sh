#!/bin/bash


echo "------------ENSURE YOU HAVE PYTHON & PIP INSTALLED--------------------"

# Check if Python is installed (python, python2, or python3)
if ! command -v python &> /dev/null && ! command -v python2 &> /dev/null && ! command -v python3 &> /dev/null; then
    echo "Python is not installed. Exiting..."
    exit 1
fi

if ! command -v pip &> /dev/null; then
    echo "pip is not installed. Please install pip to continue."
    exit 1
fi

# Create a virtual environment
echo "Creating a virtual environment..."
python3 -m venv venv

# Activate the virtual environment
echo "Activating the virtual environment..."
source venv/bin/activate

# Check if Django is already installed in the virtual environment
if pip show django >/dev/null 2>&1; then
    echo "Django is already installed in the virtual environment."
else
    echo "Django is not installed. Installing in the virtual environment..."
    pip install django
fi

echo "Setup completed successfully."
