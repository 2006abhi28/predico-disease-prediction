#!/bin/bash

# Upgrade pip
python -m pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Make migrations for all apps
echo "Making migrations..."
python manage.py makemigrations
python manage.py makemigrations main_app
python manage.py makemigrations accounts
python manage.py makemigrations chats

# Run database migrations
echo "Running migrations..."
python manage.py migrate

# Create superuser if it doesn't exist
echo "Creating superuser..."
python manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('Superuser created successfully')
else:
    print('Superuser already exists')
"

# Collect static files
python manage.py collectstatic --noinput

# Print Python version for debugging
python --version

# Print installed packages for debugging
pip list
