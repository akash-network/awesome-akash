# LLaMA-Factory on Akash Network

LLaMA-Factory is the #1 most requested open-source AI training/fine-tuning platform with 54k GitHub stars. It supports WebUI for no-code fine-tuning (just click and train), over 100 foundation models (Llama, Mistral, Qwen), built-in datasets, and one-click deployment.

## Access the WebUI

After deployment, access the LLaMA-Factory WebUI at the provided endpoint on port 7860.

## GPU Setup Suggestions

This deployment requires GPU resources for efficient fine-tuning. The configuration includes 4 GPUs. For larger models or datasets, consider increasing GPU units and memory in the deploy.yaml.

## Supported Environments

- Models: LLaMA, LLaVA, Mistral, Mixtral-MoE, Qwen, Qwen2-VL, DeepSeek, Yi, Gemma, ChatGLM, Phi, etc.
- Training approaches: Pre-training, supervised fine-tuning, reward modeling, PPO, DPO, KTO, ORPO, etc.
- Quantization: 16-bit full-tuning, LoRA, QLoRA, etc.

## Resources

- [GitHub Repository](https://github.com/hiyouga/LLaMA-Factory)
- [Docker Image](https://hub.docker.com/r/ljxha471758/llama-factory)
- [Documentation](https://llama-factory.readthedocs.io/en/latest/)