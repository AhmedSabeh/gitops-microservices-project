
FROM python:3.11-slim

WORKDIR /app

# Upgrade pip
RUN pip install --upgrade pip

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]

