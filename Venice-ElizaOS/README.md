# Launching an Eliza Agent using Venice API on Akash

This is a template for launching an Eliza Agent with direct interaction and Twitter/X integration on Akash. This enables users to input their Venice API Key, Twitter Credentials, and Character information to get the Eliza agent up and running. You will need a Venice API key for this to work properly. 

# About Venice
Venice is a privacy focused generative AI platform, allowing users to interact with open-source LLMs without storing any private user data. To get started with Venice's API, either purchase a pro account, stake $VVV to obtain daily inference allotments or fund your account with USD and head over to https://venice.ai/settings/api. Venice hosts state of the art open-source AI models and supports the OpenAI API  standard, allowing users to easily interact with the platform. Learn more about the Venice API at https://venice.ai/api.

## Obtaining a Venice API Key
Users can access the Venice API in 3 different ways: 

1. Pro Account: Users with a PRO account will gain access to the Venice API within the “Explorer Tier”. This tier has lower rate-limits, and is intended for simple interaction with the API. 

2. VCUs: With Venice’s launch of the $VVV token, users who stake tokens within the Venice protocol gain access to a daily AI inference allocation (as well as ongoing staking yield). When staking, users receive VCUs, which represent a portion of the overall Venice compute capacity. You can stake $VVV tokens and see your VCU allotment here (https://venice.ai/token). Users with positive VCU balance are entitled to “Paid Tier” rate limits. 

3. USD: User’s can also opt to deposit USD into their account to pay for API inference the same way that they would on other platforms, like OpenAI or Anthropic. Users with positive USD balance are entitled to “Paid Tier” rate limits.

## Usage
To launch an Eliza Agent using Venice API through Akash, you need to follow the following instructions:

* Create new deployment on Akash
* Launch Using Template (this template)
* Edit the SDL file with the following
    1. Venice API Key
    2. Venice Model selection - Go to https://docs.venice.ai/api-reference/endpoint/models/list?playground=open for Model IDs
    3. Twitter credentials and configurations. If you decide to not use the twitter integration, delete "twitter" within "CHAR_CLIENTS="
    4. Character Card information, used to define the personality of the character. View samples of characters from the Eliza github https://github.com/elizaOS/eliza/tree/main/characters
* Create the deployment and select a provider
* View the "Events" to ensure the docker container properly scales up
* View the "Logs" to ensure the Eliza agent properly connects to twitter and starts up
* Identify the port that is being forwarded to "3000" and click on it. You should see "Welcome, this is the REST API!"
* Interact with your character through the API. 
    Identify the agent id:
    ```
    curl --location 'http://<provider>:<port>/agents'
    ```
  
    Chat with the agent:
    ```
    curl --location 'http://<provider>:<port>/<agentid>/message' \
    --header 'Content-Type: application/json' \
    --data '{
        "text": "what is your name"
        }'
    ```
  
* Go to the twitter account that was configured and see what your agent is posting!

## Documentation

Venice API Spec https://docs.venice.ai/api-reference/api-spec 
Venice Integrations (including in-depth how-to guide) https://docs.venice.ai/welcome/guides/integrations

## Support
To learn more and get support:

* Check the Venice API documentation (https://docs.venice.ai/welcome/about-venice)
* Review detailed model specifications in our model endpoints list (https://docs.venice.ai/api-reference/endpoint/models/list?_gl=1*1ij5ulr*_gcl_au*MzMxODkxODc3LjE3MzgwNDc3NTU._gl=1*1ij5ulr*_gcl_au*MzMxODkxODc3LjE3MzgwNDc3NTU.)
* Join the Venice Discord for developer discussions and support in the #api channel (https://discord.gg/venice)

