# Stage 1: Base image for installing dependencies
FROM python:3.12-slim-bullseye AS base

# Set environment variables to avoid writing .pyc files and ensure output is sent straight to the terminal
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /srv/app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    netcat \
    libpq-dev \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# Copy only the necessary files to install dependencies
COPY pyproject.toml poetry.lock ./ 

# Configure Poetry to not use a virtual environment
ENV POETRY_VIRTUALENVS_CREATE=false

# Install Python dependencies
RUN poetry install --no-root --no-interaction --no-ansi

# Copy the entire project
COPY . .
