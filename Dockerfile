FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . /app/backend

# Expose the port for the application
EXPOSE 8000

# Run database migrations and start the Django application
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
