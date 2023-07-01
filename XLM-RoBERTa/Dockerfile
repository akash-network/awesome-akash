# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install SentencePiece 
RUN pip install --no-cache-dir sentencepiece

# Install Flask and transformers  
RUN pip install flask transformers

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV MODEL_NAME=xlm-roberta-base

# Run app.py when the container launches
CMD ["python", "app.py"]
