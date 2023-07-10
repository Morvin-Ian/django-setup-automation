#!/bin/bash

echo "Morvin Ian - Software Developer"

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