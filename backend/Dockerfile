FROM python:3.12-slim-bullseye

# Set the working directory
WORKDIR /srv/app

# Set environment variables to avoid writing .pyc files and ensure output is sent straight to the terminal
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install netcat as this is used in entrypoint.sh
RUN apt-get update && apt-get install -y \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# Copy only the necessary files to install dependencies
COPY pyproject.toml poetry.lock ./ 

# Configure Poetry to not use a virtual environment
ENV POETRY_VIRTUALENVS_CREATE=false

# Install Python dependencies
RUN poetry install --no-root --no-interaction --no-ansi

# Copy project files (excluding what’s ignored in .dockerignore)
COPY . .

# Make sure the entrypoint script is executable
RUN chmod +x /srv/app/entrypoint.sh

# Set the entrypoint for the container
ENTRYPOINT ["/srv/app/entrypoint.sh"]