# Llama-2 70B

Meta developed and publicly released the Llama 2 family of large language models (LLMs), a collection of pretrained and fine-tuned generative text models ranging in scale from 7 billion to 70 billion parameters. Llama 2 is an auto-regressive language model that uses an optimized transformer architecture.

In this deployment, the [meta-llama/Llama-2-70b-hf](https://huggingface.co/meta-llama/Llama-2-70b-hf) pretrained model is used, which generates a continuation of the incoming text. But to access this model you must have access granted by the Meta. Nothing complicated, but it's a bit inconvenient, so I created my own Hugging Face repository [cryptoman/converted-llama-2-70b](https://huggingface.co/cryptoman/converted-llama-2-70b) with this model weights with open access, since the license allows it. 

There is also a [meta-llama/Llama-2-70b-chat-hf](https://huggingface.co/meta-llama/Llama-2-70b-chat-hf) model that are optimized for dialogue use cases and can answer questions.
The "converted" and "hf" in the model names means that the model is converted to the Hugging Face Transformers format.


In this deployment, the model is loaded using QLoRa. It reduces the memory usage of LLM finetuning without performance tradeoffs compared to standard 16-bit model finetuning. This method enables 33B model finetuning on a single 24GB GPU and 65B model finetuning on a single 46GB GPU. QLoRA uses 4-bit quantization to compress a pretrained language model.
Model loads in 4bit using NF4 quantization with double quantization with the compute dtype bfloat16
More details can be found here [Link](https://huggingface.co/blog/4bit-transformers-bitsandbytes).


## Deploying

This model **require >40Gb of GPU VRAM**. Tested on NVIDIA A6000 and H100 GPUs.
![a6000_smi](https://github.com/yuravorobei/awesome-akash/assets/19820490/5ad4c8a7-8d58-4a68-8d92-7f8be088b437)
![h100_smi](https://github.com/yuravorobei/awesome-akash/assets/19820490/80dad510-af3f-44f2-b634-6eccfda1b961)


Only 300 MB of VRAM is not enough to work on NVIDIA A100, maybe there is a solution with some settings, I did not succeed. The application starts, but when the generation function is called, the error "CUDA error: out of memory" appears.
![a100_smi](https://github.com/yuravorobei/awesome-akash/assets/19820490/cc3ae93e-f478-4aa5-a7c3-94d4db8c1f31)


When the deployment begins, 15 model weights files will be downloaded with a total of **130 GB** and loaded into memory, and this may take some time. You can watch the loading process in the logs.

Use [this SDL](deploy.yaml) to deploy the application on Akash. There are two environment variables in SDL:
- `MAX_INPUT_TOKEN_LENGTH` - this value specifies the maximum number of incoming text tokens that will be directly processed by the model. Text is truncated at the left end, as the model works to write a continuation of the entered text. The larger this value, the better the model will understand the context of the entered text (if it is relatively large text), but it will also require more computing resources;
- `MAX_NEW_TOKENS` - this value specifies how many new tokens the model will generate. The larger this value, the more computing resources are required.

These parameters must be selected depending on the tasks that have been applied to the model and the power of the GPUs.


## Logs
The logs on the screenshot below show that the loading of the model weights files has completed and the Uvicorn web server has started and the application is ready to work.
![logs](https://github.com/yuravorobei/awesome-akash/assets/19820490/bfc6606d-63bf-4e48-82be-e533d24d493b)


## Demo Video
https://github.com/yuravorobei/awesome-akash/assets/19820490/7b18b65c-9d51-4c3d-8099-fa6aa954a47a

