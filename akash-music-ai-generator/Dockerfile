FROM nvidia/cuda:12.6.0-runtime-ubuntu22.04

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    git curl wget build-essential python3.11 python3.11-venv python3.11-dev \
    pkg-config ffmpeg libsndfile1 ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/ACE-Step/ACE-Step-1.5.git . && \
    git checkout main

RUN python3.11 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 && \
    pip install --no-deps -e . && \
    pip install accelerate diffusers diskcache einops fastapi gradio lightning loguru lycoris-lora matplotlib modelscope huggingface-hub librosa omegaconf hydra-core pydantic peft scipy soundfile transformers uvicorn vllm vector-quantize-pytorch

RUN mkdir -p /app/outputs /app/checkpoints /app/logs /usr/share/nginx/html

COPY studio-akash-final.html /usr/share/nginx/html/index.html

RUN cat > /etc/nginx/conf.d/acestep.conf << 'NGINX'
server {
    listen 80 default_server;
    server_name _;
    client_max_body_size 100M;

    location / {
        root /usr/share/nginx/html;
        try_files $uri /index.html;
    }

    location ~ ^/(release_task|query_result|format_input|create_random_sample|health|v1) {
        proxy_pass http://127.0.0.1:8001;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_buffering off;
    }
}
NGINX

RUN rm /etc/nginx/sites-enabled/default 2>/dev/null || true

RUN cat > /app/start.sh << 'SCRIPT'
#!/bin/bash
set -e

echo "Starting nginx..."
nginx -g 'daemon off;' &
NGINX_PID=$!

sleep 1

echo "Starting ACE-Step API server..."
. /opt/venv/bin/activate
cd /app

# Clear Akash env pollution
unset ACESTEP_API_PORT ACESTEP_API_HOST ACESTEP_API_KEY

# Enable CPU offloading for low VRAM GPUs
export ACESTEP_OFFLOAD_TO_CPU=true
export ACESTEP_OFFLOAD_DIT_TO_CPU=true

python acestep/api_server.py --host 127.0.0.1 --port 8001 &
API_PID=$!

wait $NGINX_PID $API_PID
SCRIPT

RUN chmod +x /app/start.sh

EXPOSE 80

HEALTHCHECK --interval=60s --timeout=10s --start-period=180s --retries=5 \
    CMD curl -f http://127.0.0.1/health || exit 1

CMD ["/app/start.sh"]
