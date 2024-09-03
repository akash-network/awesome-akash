# ChatGLM-6B on Akash Network

the original code repo is [here](https://github.com/THUDM/ChatGLM-6B)

## Introduction

ChatGLM-6B is an open bilingual language model based on [General Language Model (GLM)](https://github.com/THUDM/GLM) framework, with 6.2 billion parameters. With the quantization technique, users can deploy locally on consumer-grade graphics cards (only 6GB of GPU memory is required at the INT4 quantization level).

ChatGLM-6B uses technology similar to ChatGPT, optimized for Chinese QA and dialogue. The model is trained for about 1T tokens of Chinese and English corpus, supplemented by supervised fine-tuning, feedback bootstrap, and reinforcement learning with human feedback. With only about 6.2 billion parameters, the model is able to generate answers that are in line with human preference.

In order to facilitate downstream developers to customize the model for their own application scenarios, we also implements an parameter-efficient tuning method based on [P-Tuning v2](https://github.com/THUDM/P-tuning-v2)[(Guidelines)](ptuning/README_en.md). Tuning requires at least 7GB of GPU memory at INT4 quantization level.

Try the [online demo](https://huggingface.co/spaces/ysharma/ChatGLM-6b_Gradio_Streaming) on Huggingface Spaces.

## Web UI
![image](https://github.com/Normalnoise/awesome-akash/assets/102578774/149d62bd-39ec-4a5b-9a28-30a3b84ef9ee)


## Demo Video
https://github.com/Normalnoise/awesome-akash/assets/102578774/f4079b2d-a813-4ca6-b8ce-2a4523510fc4

