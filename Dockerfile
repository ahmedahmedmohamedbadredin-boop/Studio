# Use official lightweight Python image
FROM python:3.11-slim

# Prevent Python from buffering stdout/stderr
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Cloud Run injects the PORT environment variable (default 8080)
ENV PORT=8080

# Run with Gunicorn production server
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app