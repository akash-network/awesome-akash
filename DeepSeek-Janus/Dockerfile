# Use the PyTorch base image
FROM pytorch/pytorch:latest

# Set the working directory inside the container
WORKDIR /app

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV HF_HOME=/root/.cache/huggingface

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory into the container
RUN git clone https://github.com/deepseek-ai/Janus.git .

# Install necessary Python packages
RUN pip install -e .
RUN pip install gradio diffusers

# Expose the port that Gradio typically uses
EXPOSE 7860

# Run the Gradio demo
CMD ["python", "demo/app_januspro.py"]
