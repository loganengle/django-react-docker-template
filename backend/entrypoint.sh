#!/bin/sh

# Verify environment variables for PostgreSQL
if [ -z "$POSTGRES_HOST" ] || [ -z "$POSTGRES_PORT" ] || [ -z "$POSTGRES_DB" ] || [ -z "$POSTGRES_USER" ] || [ -z "$POSTGRES_PASSWORD" ]; then
  echo "ERROR: One or more PostgreSQL environment variables are not set."
  echo "POSTGRES_HOST=$POSTGRES_HOST"
  echo "POSTGRES_PORT=$POSTGRES_PORT"
  echo "POSTGRES_DB=$POSTGRES_DB"
  echo "POSTGRES_USER=$POSTGRES_USER"
  echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD:+(hidden)}" # Hide password from logs
  exit 1
fi

# Wait for PostgreSQL to be available
while ! nc -z postgres 5432; do
  echo "Waiting for PostgreSQL to be available..."
  sleep 1
done
echo "PostgreSQL is available."

# Apply migrations
echo "Applying migrations..."
python manage.py migrate

# Verify environment variables for superuser
if [ -z "$DJANGO_SUPERUSER_USERNAME" ] || [ -z "$DJANGO_SUPERUSER_EMAIL" ] || [ -z "$DJANGO_SUPERUSER_PASSWORD" ]; then
  echo "ERROR: One or more superuser environment variables are not set."
  echo "DJANGO_SUPERUSER_USERNAME=$DJANGO_SUPERUSER_USERNAME"
  echo "DJANGO_SUPERUSER_EMAIL=$DJANGO_SUPERUSER_EMAIL"
  echo "DJANGO_SUPERUSER_PASSWORD=${DJANGO_SUPERUSER_PASSWORD:+(hidden)}" # Hide password from logs
  exit 1
fi

# Create a superuser if it doesn't already exist
echo "Creating superuser..."
python manage.py shell -c "
from django.contrib.auth import get_user_model;
User = get_user_model();
if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists():
    User.objects.create_superuser(
        username='$DJANGO_SUPERUSER_USERNAME',
        email='$DJANGO_SUPERUSER_EMAIL',
        password='$DJANGO_SUPERUSER_PASSWORD'
    )
    print('Superuser created: $DJANGO_SUPERUSER_USERNAME')
else:
    print('Superuser $DJANGO_SUPERUSER_USERNAME already exists.')
"
if [ $? -eq 0 ]; then
  echo "Superuser creation script executed successfully."
else
  echo "Error during superuser creation script execution."
fi

# Start the server
echo "Starting Django server..."
python manage.py runserver 0.0.0.0:8000