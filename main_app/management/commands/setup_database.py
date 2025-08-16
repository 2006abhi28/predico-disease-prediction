from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from django.core.management import call_command
import os

class Command(BaseCommand):
    help = 'Setup database with all necessary tables and initial data'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Starting database setup...'))
        
        # Make migrations for all apps
        self.stdout.write('Making migrations...')
        call_command('makemigrations', verbosity=1)
        call_command('makemigrations', 'main_app', verbosity=1)
        call_command('makemigrations', 'accounts', verbosity=1)
        call_command('makemigrations', 'chats', verbosity=1)
        
        # Run migrations
        self.stdout.write('Running migrations...')
        call_command('migrate', verbosity=1)
        
        # Create superuser if it doesn't exist
        self.stdout.write('Creating superuser...')
        if not User.objects.filter(username='admin').exists():
            User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
            self.stdout.write(self.style.SUCCESS('Superuser created successfully'))
        else:
            self.stdout.write(self.style.WARNING('Superuser already exists'))
        
        # Collect static files
        self.stdout.write('Collecting static files...')
        call_command('collectstatic', '--noinput', verbosity=1)
        
        self.stdout.write(self.style.SUCCESS('Database setup completed successfully!'))
