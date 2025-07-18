FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install git (jika dibutuhkan)
RUN apt-get update && apt-get install -y git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy all project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Railway injects PORT via env
ENV PORT=8000
EXPOSE ${PORT}

# Run the app with dynamic PORT from env
CMD ["sh", "-c", "uvicorn run:main_app --host 0.0.0.0 --port ${PORT} --workers 4"]
