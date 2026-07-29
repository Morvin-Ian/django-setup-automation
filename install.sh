#!/bin/bash
set -euo pipefail

# Check that we are not running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root. Use a regular user with a virtual environment."
    exit 1
fi

# Create and activate a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi
source venv/bin/activate

source 01_intro.sh
source 02_django-installation.sh
source 03_project-setup.sh
source 04_settings.sh
source 05_frontend.sh






