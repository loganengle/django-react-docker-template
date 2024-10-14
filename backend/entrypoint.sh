#!/bin/sh

# Wait for PostgreSQL to be available
while ! nc -z db 5432; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

# Apply migrations
python manage.py migrate

# Create a superuser if it doesn't already exist
if ! python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists()"; then
  echo "Creating superuser..."
  python manage.py createsuperuser --noinput --username admin --email admin@example.com
  echo "Superuser created."
else
  echo "Superuser already exists."
fi

# Start the server
exec "$@"