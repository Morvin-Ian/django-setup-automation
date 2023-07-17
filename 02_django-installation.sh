#!/bin/bash

# Virtual Environment Setup
#     #pass

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

# Check if Django is already installed
if pip show django >/dev/null 2>&1; then
    echo "Django is already installed."
else
    echo "Django is not installed. Installing..."
    pip install django
fi