# GPT-Neo (multiple models)

GPT-Neo is an open-source project that aims to replicate the architecture and functionality of OpenAI's GPT models, such as GPT-3, using a smaller number of parameters. It was developed by EleutherAI, a community-driven research organization focused on democratizing access to large-scale language models. It provides a valuable alternative for those who may not have access to or require the immense scale and resources of the original GPT models.

GPT-Neo was trained as an autoregressive language model. This means that its core functionality is taking a string of text and predicting the next token. The models utilize a transformer architecture, which consists of multiple layers of self-attention mechanisms to capture relationships between words and generate high-quality text. GPT-Neo architecture intentionally resembles that of GPT-3, and is almost identical to that of GPT-J- 6B. Its training dataset contains a multitude of English-language texts, reflecting the general-purpose nature of this model.


## Models

It is possible to use GPT-Neo with 4 pre-trained models, where the number at the end of the name represents the number of parameters of this particular pre-trained model and accordingly, the more parameters, the more "smarter" the model, but it also requires more computing resources.
Models with their minimum requirements:
- [EleutherAI/gpt-neo-125m](https://huggingface.co/EleutherAI/gpt-neo-125m) - requires 6 GB of VRAM, 4 GB of RAM, 1 GB HDD;
- [EleutherAI/gpt-neo-1.3B](https://huggingface.co/EleutherAI/gpt-neo-1.3B) - requires 12 GB of VRAM, 10 GB of RAM, 10 GB HDD;
- [EleutherAI/gpt-neo-2.7B](https://huggingface.co/EleutherAI/gpt-neo-2.7B) - requires 16 GB of VRAM, 20 GB of RAM, 15 GB HDD;
- [EleutherAI/gpt-neox-20b](https://huggingface.co/EleutherAI/gpt-neox-20b) - recommended to use with Nvidia H100 GPU, but it can also work with Nvidia A100 with small values of `MAX_INPUT_TOKEN_LENGTH=13` and `MAX_NEW_TOKENS=11`,  requires more than 40GB VRAM, 50GB RAM, 50 GB HDD.


## Deploying

Use [this SDL](deploy.yaml) to deploy the application on Akash. There are three environment variables in SDL:
- `MODEL_NAME` - specify which model to upload, available options: `gpt-neo-125M`, `gpt-neo-1.3B`, `gpt-neo-2.7B`, `gpt-neox-20b`;
- `MAX_INPUT_TOKEN_LENGTH` - this value specifies the maximum number of incoming text tokens that will be directly processed by the model. Text is truncated at the left end, as the model works to write a continuation of the entered text. The larger this value, the better the model will understand the context of the entered text (if it is relatively large text), but it will also require more computing resources;
- `MAX_NEW_TOKENS` - this value specifies how many new tokens the model will generate. The larger this value, the more computing resources are required. It is possible that if the value is too large, the model will also probably start to produce worse results, but these are just my speculations and you need to test everything depending on your requests.

By default, the parameters for the `gpt-neo-2.7B` model are set in the SDL.
When the deployment starts, the model files will be downloaded and loaded into memory, and this may take some time if the model is large. You can watch the loading process in the logs.

## Logs
The logs on the screenshot below show that the loading of the models has completed and the Uvicorn web server has started and the application is ready to work.
Note: I noticed that sometimes the logs may not be displayed, what is the reason for this is not clear, but the application starts and runs successfully.
![Screenshot_20230708_232701](https://github.com/yuravorobei/awesome-akash/assets/19820490/f59895e0-12d8-4cce-a19f-ed0471e1675f)


## Demo Video
For the demo video, I deployed the app with the following settings: `MODEL_NAME=gpt-neo-2.7B`, `MAX_INPUT_TOKEN_LENGTH=30`, `MAX_NEW_TOKENS=50`:


https://github.com/yuravorobei/awesome-akash/assets/19820490/11b25cb9-801e-423a-b304-de67acdfbbac



