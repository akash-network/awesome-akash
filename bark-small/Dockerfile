FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

ENV GRADIO_SERVER_PORT=7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

# Create mount point and set permissions for persistent storage
RUN mkdir -p /mnt && \
    chown -R 1000:1000 /mnt && \
    chmod 755 /mnt
VOLUME /mnt

WORKDIR /opt/app

# Copy requirements first for better caching
COPY requirements.txt requirements.txt

RUN apt-get update && apt-get install -y git && \
    pip install -r requirements.txt

# Copy application files
COPY app.py .
COPY public/ /opt/app/public/

# Run the Gradio app
CMD ["python", "app.py"]