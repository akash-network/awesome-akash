# Use an official PyTorch image with CUDA and Python 3.11 as a base
FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime
 
# Install system dependencies & uv via pip
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && pip install uv
 
# Set the working directory
WORKDIR /app
 
# Clone the repository
RUN git clone https://github.com/ACE-Step/ACE-Step-1.5.git .
 
# Pin known-working versions to avoid recent breaking changes
RUN echo "diffusers==0.24.0" >> requirements.txt
RUN echo "torchao==0.1.0" >> requirements.txt
RUN echo "transformers" >> requirements.txt
RUN echo "accelerate" >> requirements.txt
 
# Use uv to sync dependencies
RUN uv sync
 
# Set Hugging Face cache to persistent storage
ENV TRANSFORMERS_CACHE=/app/models
ENV HF_HOME=/app/models
 
# Expose the Gradio port
EXPOSE 7860
 
# Set the startup command
CMD ["uv", "run", "acestep", "--server-name", "0.0.0.0"]
