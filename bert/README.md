# BERT on Akash

This repository contains the necessary files to deploy a Flask application that uses the BERT language model on the Akash network. BERT is a powerful language model that can understand and generate text in English.

## Files

- `Dockerfile`: This file is used to build the Docker image for the application. It sets up an environment with Python and all the necessary libraries to run the application.
- `requirements.txt`: This file lists the Python packages that need to be installed in the Docker image. This includes Flask for the web application and the Transformers library for the BERT model.
- `app.py`: This is the main application file. It creates a Flask web application that uses the BERT model to predict the masked words in a sentence.
- `deploy.yaml`: This file defines the Akash deployment configuration for the application. It specifies the resources needed to run the application and the Docker image to use.

## Deployment

To deploy the application on the Akash network, you need to build and push the Docker image, and then deploy the application using the `deploy.yaml` file.

1. Build the Docker image: `docker build -t your-dockerhub-username/bert-base-uncased:0.0.1 .`
2. Push the Docker image: `docker push your-dockerhub-username/bert-base-uncased:0.0.1`
3. Deploy the application on Akash: `akash deploy create deploy.yaml --from $AKASH_KEY_NAME`

Replace `your-dockerhub-username` with your Docker Hub username and `$AKASH_KEY_NAME` with the name of your Akash key.

## Usage

The application listens on port 80 and accepts POST requests to the `/predict` endpoint. The POST request should contain a JSON object with a single attribute 'text' that contains the sentence with a word replaced by '[MASK]'. The application will return the sentence with the '[MASK]' replaced by the predicted word.

For example, you can use curl to send a POST request:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"text":"This [MASK] model can understand and generate text in multiple languages."}' http://your-akash-deployment-url/predict
```

Replace your-akash-deployment-url with the URL of your Akash deployment.
