FROM ubuntu:24.04

# Install necessary packages
RUN apt update && apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    cmake \
    libopenblas-dev \
    libomp-dev

# Create and activate a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages in the virtual environment
RUN pip install --upgrade pip
RUN pip install torch
RUN pip install wheel setuptools
RUN pip install transformers einops xformers accelerate

# Set the working directory
WORKDIR /usr/app/src

# Copy the script to the working directory
COPY falcon7b.py ./

# Command to run the script
CMD ["python3", "falcon7b.py"]
