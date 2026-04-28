# Piper TTS for Akash Network
# Lightweight, fast, MIT-licensed TTS
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    espeak-ng \
    && rm -rf /var/lib/apt/lists/*

# Install Piper binary, libraries, and espeak-ng data
RUN wget -q https://github.com/rhasspy/piper/releases/download/v1.2.0/piper_amd64.tar.gz \
    && tar -xzf piper_amd64.tar.gz \
    && cp piper/piper /usr/local/bin/ \
    && cp piper/libpiper_phonemize.so* /usr/local/lib/ \
    && cp piper/libonnxruntime.so* /usr/local/lib/ \
    && cp piper/libespeak-ng.so* /usr/local/lib/ \
    && mkdir -p /usr/share/espeak-ng-data \
    && cp -r piper/espeak-ng-data/* /usr/share/espeak-ng-data/ \
    && ldconfig \
    && rm -rf piper piper_amd64.tar.gz

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy server code
COPY server.py .
COPY download_models.sh .

# Create models directory
RUN mkdir -p /app/models

# Download voice models (uncomment the ones you want)
# Run this during build to have models ready
RUN chmod +x download_models.sh && ./download_models.sh

# Create non-root user
RUN useradd -m -u 1001 app && chown -R app:app /app
USER app

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Run server
CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "2"]
