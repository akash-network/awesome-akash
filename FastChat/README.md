# FastChat On the Akash Network

The oringinal repo is here: https://github.com/lm-sys/FastChat

FastChat is an open platform for training, serving, and evaluating large language model based chatbots. The core features include:
- The weights, training code, and evaluation code for state-of-the-art models (e.g., Vicuna, FastChat-T5).
- A distributed multi-model serving system with web UI and OpenAI-compatible RESTful APIs.

# Web UI
![image](https://github.com/satoshi-kevin/awesome-akash/assets/127167037/57f85eb6-bd3a-4991-8b78-b84e3ff3f25a)



# Demo Video


https://github.com/satoshi-kevin/awesome-akash/assets/127167037/9387ab2c-d4a2-45db-ae1f-a79320b55fc4


## News
- [2023/06] 🔥 We introduced **LongChat**, our long-context chatbots and evaluation tools. Check out the blog [post](https://lmsys.org/blog/2023-06-29-longchat/) and [code](https://github.com/DachengLi1/LongChat/).
- [2023/05] We introduced **Chatbot Arena** for battles among LLMs. Check out the blog [post](https://lmsys.org/blog/2023-05-03-arena) and [demo](https://arena.lmsys.org).
- [2023/04] We released **FastChat-T5** compatible with commercial usage. Check out the [weights](#fastchat-t5) and [demo](https://chat.lmsys.org).
- [2023/03] We released **Vicuna: An Open-Source Chatbot Impressing GPT-4 with 90% ChatGPT Quality**. Check out the blog [post](https://vicuna.lmsys.org) and [demo](https://chat.lmsys.org).

<a href="https://chat.lmsys.org"><img src="assets/demo_narrow.gif" width="70%"></a>

## Contents
- [Install](#install)
- [Model Weights](#model-weights)
- [Inference with Command Line Interface](#inference-with-command-line-interface)
- [Serving with Web GUI](#serving-with-web-gui)
- [API](#api)
- [Evaluation](#evaluation)
- [Fine-tuning](#fine-tuning)
- [Citation](#citation)

## Install

### Method 1: With pip

```bash
pip3 install fschat
```

### Method 2: From source

1. Clone this repository and navigate to the FastChat folder
```bash
git clone https://github.com/lm-sys/FastChat.git
cd FastChat
```

If you are running on Mac:
```bash
brew install rust cmake
```

2. Install Package
```bash
pip3 install --upgrade pip  # enable PEP 660 support
pip3 install -e .
```
