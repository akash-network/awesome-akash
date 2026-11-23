FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        python3 \
        python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN python -m pip install --no-cache-dir \
    --index-url https://download.pytorch.org/whl/cu126 \
    "torch==2.14.1+cu126"

RUN python -m pip install --no-cache-dir \
    transformers \
    accelerate \
    falcon

WORKDIR /usr/app/src
COPY falcon7b.py index.html ./

EXPOSE 8000
CMD ["python", "falcon7b.py"]
