#!/bin/bash

# Upgrade pip
python -m pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Setup database using custom management command
echo "Setting up database..."
python manage.py setup_database

# Print Python version for debugging
python --version

# Print installed packages for debugging
pip list

echo "Build completed successfully!"
