#!/bin/bash

echo "------------ENSURE YOU HAVE PYTHON & PIP INSTALLED--------------------"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Exiting..."
    exit 1
fi

# Check if pip is available (inside the virtual environment)
if ! command -v pip &> /dev/null; then
    echo "pip is not available inside the virtual environment. Exiting..."
    exit 1
fi

# Install Django inside the virtual environment
echo "Installing Django..."
pip install django

# Verify installation
python3 -c "import django; print(f'Django {django.get_version()} installed successfully.')"
