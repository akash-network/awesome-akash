# BERT Model Deployment on Akash GPU Testnet

This repository contains the necessary files to deploy the BERT model from Hugging Face on the Akash GPU Testnet. The BERT model is a powerful language model that can be used for a variety of natural language processing tasks.

## What's Been Done

- A Dockerfile has been created to build a Docker image for the BERT model. The Dockerfile specifies the necessary dependencies for running the BERT model and sets up a basic application that loads the BERT model when the Docker container is started.

- A `deploy.yaml` file has been created for deploying the Docker image on the Akash GPU Testnet. The `deploy.yaml` file specifies the resources required for the deployment, including CPU, memory, storage, and GPU.

- The Docker image has been built and pushed to Docker Hub, making it ready for deployment on the Akash GPU Testnet.

## Next Steps

- Deploy the Docker image on the Akash GPU Testnet using the Akash CLI and the `deploy.yaml` file.

- Test the deployment to ensure that the BERT model is loaded successfully and that the application is functioning as expected.

- Develop a more interactive application that uses the BERT model to provide a service, such as text classification or sentiment analysis. This could be a web application with a user interface for inputting text and displaying the output from the BERT model.

## Detailed Instructions

1. **Building the Docker Image**: You can build the Docker image using the provided Dockerfile with the command `docker build -t your-dockerhub-username/bert-base-uncased:0.0.1 .`. Don't forget to replace `your-dockerhub-username` with your actual Docker Hub username.

2. **Pushing the Docker Image to Docker Hub**: After building the Docker image, you can push it to Docker Hub using the command `docker push your-dockerhub-username/bert-base-uncased:0.0.1`.

3. **Deploying on Akash**: With the Docker image pushed to Docker Hub, you can now deploy the application on Akash. Make sure to replace `image: your-dockerhub-username/bert-base-uncased:0.0.1` in the `deploy.yaml` file with the correct Docker image name. Then, use the Akash CLI to create the deployment with the command `akash deploy create deploy.yaml --from $AKASH_KEY_NAME`.

4. **Testing the Deployment**: After the deployment is successful, you can test it by sending a GET request to the deployed application's URL. The application currently doesn't have any endpoints defined, so you should expect a 404 response. This indicates that the application is running successfully.

## Audience

This project is intended for participants in the Akash GPU Testnet who are interested in deploying AI language models. The provided files and instructions can serve as a starting point for deploying other models on the Akash GPU Testnet.

## Contributing

Contributions are welcome! If you have any improvements or additions to suggest, please feel free to create a pull request or open an issue.
