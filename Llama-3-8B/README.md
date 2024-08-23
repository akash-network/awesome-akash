# Llama-3 8B

Meta developed and publicly released the Llama 3 family of large language models (LLMs), a collection of pretrained and fine-tuned generative text models ranging in scale from 8 billion to 70 billion parameters. Llama 3 is an auto-regressive language model that uses an optimized transformer architecture.

In this deployment, the [meta-llama/Llama-3-8B-Instruct](https://huggingface.co/meta-llama/Meta-Llama-3-8B-Instruct) pretrained model is used, which generates a continuation of the incoming text. But to access this model you must have access granted by the Meta that you can request from https://huggingface.co/meta-llama/Meta-Llama-3-8B-Instruct.

## Deploying

Use [this SDL](deploy.yaml) to deploy the application on Akash. You will need to enter your Huggingface Access Key in "HF_TOKEN=" ENV variable and you can adjust the parameters passed into the "vllm serve" argument according to your hardware cluster configuration (refer to vLLM documentation for the various parameters). Lastly you can add additional debug flags through the ENV variables (consult the vLLM and Pytorch documentation for this as well)