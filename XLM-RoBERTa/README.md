# XLM-RoBERTa on Akash

This repository contains the necessary files to deploy a Flask application that uses the XLM-RoBERTa language model on the Akash network. XLM-RoBERTa is a powerful language model that can understand and generate text in multiple languages.

## Files

- `Dockerfile`: This file is used to build the Docker image for the application. It sets up an environment with Python and all the necessary libraries to run the XLM-RoBERTa model.
- `requirements.txt`: This file lists the Python packages that need to be installed in the Docker image. This includes Flask for the web application and the Transformers library for the XLM-RoBERTa model.
- `app.py`: This is the main application file. It creates a Flask web application that uses the XLM-RoBERTa model to predict masked tokens in a given text.
- `deploy.yaml`: This file defines the Akash deployment configuration for the application. It specifies the resources needed to run the application and the Docker image to use.

## Deployment

To deploy the application on the Akash network, you can use the deploy.yaml in this repository on Akash's new GPU marketplace using Cloudmos, Akash Console, or Akash CLI

## Usage

The application listens on port 80 and accepts POST requests to the `/predict` endpoint. The POST request should contain a JSON object with a single attribute 'text' that contains the text to be processed.

For example, you can use curl to send a POST request:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"text":"This <mask> model can understand and generate text in multiple languages."}' http://your-akash-deployment-url/predict
```
