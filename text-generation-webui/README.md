
# text-generation-webui by oobabooga on akash network

A gradio web UI for running Large Language Models like LLaMA, llama.cpp, GPT-J, Pythia, OPT, and GALACTICA.

Its goal is to become the AUTOMATIC1111/stable-diffusion-webui of text generation.

The Tags of the Docker Image is the same as the release on the official repository. I.e. "v1.3.1" or "v1.4"

|![Image1](https://github.com/oobabooga/screenshots/raw/main/qa.png) | ![Image2](https://github.com/oobabooga/screenshots/raw/main/cai3.png) |
|:---:|:---:|
|![Image3](https://github.com/oobabooga/screenshots/raw/main/gpt4chan.png) | ![Image4](https://github.com/oobabooga/screenshots/raw/main/galactica.png) |

## Features

* 3 interface modes: default (two columns), notebook, and chat
* Multiple model backends: [transformers](https://github.com/huggingface/transformers), [llama.cpp](https://github.com/ggerganov/llama.cpp), [ExLlama](https://github.com/turboderp/exllama), [ExLlamaV2](https://github.com/turboderp/exllamav2), [AutoGPTQ](https://github.com/PanQiWei/AutoGPTQ), [GPTQ-for-LLaMa](https://github.com/qwopqwop200/GPTQ-for-LLaMa), [CTransformers](https://github.com/marella/ctransformers), [AutoAWQ](https://github.com/casper-hansen/AutoAWQ)
* Dropdown menu for quickly switching between different models
* LoRA: load and unload LoRAs on the fly, train a new LoRA using QLoRA
* Precise instruction templates for chat mode, including Llama-2-chat, Alpaca, Vicuna, WizardLM, StableLM, and many others
* 4-bit, 8-bit, and CPU inference through the transformers library
* Use llama.cpp models with transformers samplers (`llamacpp_HF` loader)
* [Multimodal pipelines, including LLaVA and MiniGPT-4](https://github.com/oobabooga/text-generation-webui/tree/main/extensions/multimodal)
* [Extensions framework](https://github.com/oobabooga/text-generation-webui/wiki/07-%E2%80%90-Extensions)
* [Custom chat characters](https://github.com/oobabooga/text-generation-webui/wiki/03-%E2%80%90-Parameters-Tab#character)
* Very efficient text streaming
* Markdown output with LaTeX rendering, to use for instance with [GALACTICA](https://github.com/paperswithcode/galai)
* OpenAI-compatible API server

To learn how to use the various features, check out the Documentation: https://github.com/oobabooga/text-generation-webui/wiki

## Acknowledgements

 - [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui/tree/main)
 - [Prebuild Docker Images by zjuuu](hhttps://hub.docker.com/r/zjuuu/text-generation-webui)

## How to build the Docker image

Clone the original repository: [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui/tree/main). Copy & paste the [Dockerfile](/text-generation-webui/Dockerfile). Run `docker build -t yourimagename .`