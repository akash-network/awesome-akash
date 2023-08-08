FROM python:3.9

# Set the working directory to /code
WORKDIR /code

# Update and upgrade package managers
RUN apt-get -y update && apt-get upgrade -y
RUN pip install --upgrade pip

# Install pytorch nightly latest version
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu118

# Copy all source files to workdir
COPY . /code

# Install python requirement packages
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Start Uvicorn web server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7575"]
