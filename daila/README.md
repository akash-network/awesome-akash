# Dalai

Run LLaMA and Alpaca on your computer.

1. Powered by [llama.cpp](https://github.com/ggerganov/llama.cpp), [llama-dl CDN](https://github.com/shawwn/llama-dl), and [alpaca.cpp](https://github.com/antimatter15/alpaca.cpp)
2. Hackable web app included
3. Ships with JavaScript API
4. Ships with [Socket.io](https://socket.io/) API

# Intro

## 1. Cross platform

Dalai runs on all of the following operating systems:

1. Linux
2. Mac
3. Windows

## 2. Memory Requirements

Runs on most modern computers. Unless your computer is very very old, it should work.

According to [a llama.cpp discussion thread](https://github.com/ggerganov/llama.cpp/issues/13), here are the memory requirements:

- 7B => ~4 GB
- 13B => ~8 GB
- 30B => ~16 GB
- 65B => ~32 GB

## 3. Disk Space Requirements

### Alpaca

Currently 7B and 13B models are available via [alpaca.cpp](https://github.com/antimatter15/alpaca.cpp)

#### 7B

Alpaca comes fully quantized (compressed), and the only space you need for the 7B model is 4.21GB:


#### 13B

Alpaca comes fully quantized (compressed), and the only space you need for the 13B model is 8.14GB:


### LLaMA

You need a lot of space for storing the models. **The model name must be one of: 7B, 13B, 30B, and 65B.**

You do NOT have to install all models, you can install one by one. Let's take a look at how much space each model takes up:

> NOTE
>
> The following numbers assume that you DO NOT touch the original model files and keep BOTH the original model files AND the quantized versions.
>
> You can optimize this if you delete the original models (which are much larger) after installation and keep only the quantized versions.

#### 7B

- Full: The model takes up 31.17GB
- Quantized: 4.21GB


#### 13B

- Full: The model takes up 60.21GB
- Quantized: 4.07GB * 2 = 8.14GB


#### 30B

- Full: The model takes up 150.48GB
- Quantized: 5.09GB * 4 = 20.36GB


#### 65B

- Full: The model takes up 432.64GB
- Quantized: 5.11GB * 8 = 40.88GB
