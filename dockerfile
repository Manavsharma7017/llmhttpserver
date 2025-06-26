    # Use a stable Python version
    FROM python:3.11-slim

    # Set working directory
    WORKDIR /app

    # Install system dependencies (e.g. for grpcio compilation)
    RUN apt-get update && apt-get install -y \
        build-essential \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

    # Copy requirements first to leverage Docker layer caching
    COPY requirements.txt .

    # Install Python dependencies
    RUN pip install --no-cache-dir --upgrade pip \
        && pip install --no-cache-dir -r requirements.txt

    # Copy the rest of the application
    COPY . .

    # Expose http port // worharound for free deployment
   EXPOSE 50051

    # Start the server
    CMD ["python", "server.py"]
