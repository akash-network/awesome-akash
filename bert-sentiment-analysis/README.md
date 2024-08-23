# BERT Sentiment Analysis on Akash Network

This repository contains the necessary files to deploy a sentiment analysis model based on the BERT architecture on the Akash Network. The model is capable of classifying text into five sentiment categories: very negative, negative, neutral, positive, and very positive.

## Model

The model used is the `nlptown/bert-base-multilingual-uncased-sentiment` model from Hugging Face. This model is capable of understanding and generating text in multiple languages, making it versatile for various use cases.

## Files

- `app.py`: This is the main application file. It uses Flask to create a web application that takes user input, passes it to the model, and returns the sentiment prediction.
- `Dockerfile`: This file contains the instructions to build the Docker image for the application.
- `requirements.txt`: This file lists the Python libraries required by the application.
- `deploy.yaml`: This is the SDL (Stack Definition Language) file used for deploying the application on the Akash Network.
- `index.html`: This file contains the HTML code for the application's user interface.

## Deployment on Akash Network

To deploy the application on the Akash Network, you need to have an Akash account with sufficient AKT balance. Follow the steps below:

1. Clone this repository.
2. Build the Docker image and push it to a Docker registry.
3. Update the `deploy.yaml` file with the correct Docker image path.
4. Use the Akash CLI or Akash Console to deploy the `deploy.yaml` file.

Please refer to the [Akash Documentation](https://akash.network/docs) for detailed instructions on deploying applications.

## Testing the Application

Once the application is deployed, you can test it by sending a POST request to the `/predict` endpoint with a JSON payload containing the text to be analyzed. For example:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"text":"I love this product!"}' http://<your-akash-deployment-url>/predict
```

The application will return a JSON response with the sentiment prediction:

{"sentiment": "positive"}

## UI Interactivity
https://youtu.be/aXOdjNLQarw?t=456
