#!/bin/bash

# Upgrade pip
python -m pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --noinput

# Print Python version for debugging
python --version

# Print installed packages for debugging
pip list
