# Use NVIDIA CUDA base image with Python
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Clone the Janus repository
RUN git clone https://github.com/deepseek-ai/Janus.git .

# Install Python requirements
RUN pip3 install --no-cache-dir .[gradio]

# Expose the port that Gradio typically uses
EXPOSE 7860

# Run the Gradio demo
CMD ["python3", "demo/app_januspro.py"]
