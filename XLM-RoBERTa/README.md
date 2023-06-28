# XLM-RoBERTa on Akash

This repository contains the necessary files to deploy a Flask application that uses the XLM-RoBERTa language model on the Akash network.

## Files

- `Dockerfile`: This file is used to build the Docker image for the application.
- `requirements.txt`: This file lists the Python packages that need to be installed in the Docker image.
- `app.py`: This is the main application file. It creates a Flask web application that uses the XLM-RoBERTa model to fill in masked words in a sentence.
- `deploy.yaml`: This file defines the Akash deployment configuration for the application.

## Deployment

To deploy the application on the Akash network, you need to build and push the Docker image, and then deploy the application using the `deploy.yaml` file.

1. Build the Docker image: `docker build -t clydedevv/xlm-roberta-base:latest .`
2. Push the Docker image: `docker push clydedevv/xlm-roberta-base:latest`
3. Deploy the application on Akash: `akash deploy create deploy.yaml --from $AKASH_KEY_NAME`

Replace `$AKASH_KEY_NAME` with the name of your Akash key.

## Usage

The application listens on port 80 and accepts POST requests to the `/predict` endpoint. The POST request should contain a JSON object with a single attribute 'input' that contains the sentence with a masked word.
