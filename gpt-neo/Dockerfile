FROM python:3.9

# Set the working directory to /code
WORKDIR /code

# Update and upgrade package managers
RUN apt-get -y update && apt-get upgrade -y
RUN pip install --upgrade pip

# Install python requirement packages
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu118
RUN pip install --upgrade git+https://github.com/huggingface/transformers@main accelerate uvicorn fastapi google google-api-python-client sentencepiece requests scipy;
# Copy all source files to workdir
COPY . /code

# Start Uvicorn web server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
