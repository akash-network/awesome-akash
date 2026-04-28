# Piper TTS & Frontend on Akash Deployment

Welcome to the repository for our deployment of Piper Text-to-Speech (TTS) and a frontend. This setup allows you to leverage the capabilities of Piper TTS through an API endpoint, which is then consumed by the provided frontend. Below are the details about how to deploy and use this system.

## About Piper TTS
Piper TTS is a text-to-speech software that uses artificial intelligence to convert written text into spoken words. It supports multiple languages and voices, catering to various linguistic needs. The service can be easily integrated via API endpoints for developers looking to incorporate speech synthesis functionalities in their applications.

## Akash Deployment
The Piper TTS and frontend are deployed on the Akash cloud platform. After deployment, you will receive a unique URL from your provider. This URL should be used as the API endpoint in the frontend setup. Remember to omit the trailing slash when entering this URL into the configuration settings.

**Example:** If your deployed URL is `http://yourpiper-tts-link.provider.com`, you will use `http://yourpiper-tts-link.provider.com` as the API endpoint in the frontend setup.

## Customizing with SDL
For enhanced security and access control, you can define an API key in the SDL before deploying to Akash. 

This allows you to manage who has access by setting specific API keys, ensuring that only authorized users can interact with your TTS service.

## Features
- **Six Voices**: The system supports multiple voices which can be selected based on the user's preference or language requirements.
- **Four Languages**: Piper TTS is capable of converting text into speech for four languages, expanding its utility in global applications.
- **Customization and Expansion**: Additional models are easily integrated via API endpoints, allowing for future expansions and linguistic enhancements.

## Usage
To deploy and use this setup:
1. Deploy the Piper TTS and frontend services on Akash as instructed by your provider.
2. Retrieve the deployed URL from your Akash deployment.
3. Configure the frontend to connect with the provided API endpoint URL, omitting the trailing slash.
4. If needed for authentication or customization, use SDL files to set specific API keys or parameters that limit access only to authorized users.

## Conclusion
This setup provides a robust and flexible text-to-speech solution that can be customized according to your needs. Whether you are integrating it into an existing application or developing a new one, the flexibility of our deployment allows for easy scaling and customization with additional models.
