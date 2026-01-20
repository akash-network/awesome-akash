# Axolotl AI - LLM Fine-tuning on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-axolotlai)


<p align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/axolotl-ai-cloud/axolotl/887513285d98132142bf5db2a74eb5e0928787f1/image/axolotl_logo_digital_white.svg">
        <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/axolotl-ai-cloud/axolotl/887513285d98132142bf5db2a74eb5e0928787f1/image/axolotl_logo_digital_black.svg">
        <img alt="Axolotl" src="https://raw.githubusercontent.com/axolotl-ai-cloud/axolotl/887513285d98132142bf5db2a74eb5e0928787f1/image/axolotl_logo_digital_black.svg" width="400" height="104" style="max-width: 100%;">
    </picture>
</p>

## ✨ Overview

Axolotl is a free and open-source tool designed to streamline post-training and fine-tuning for the latest large language models (LLMs).

Features:

- **Multiple Model Support**: Train various models like GPT-OSS, LLaMA, Mistral, Mixtral, Pythia, and many more models available on the Hugging Face Hub.
- **Multimodal Training**: Fine-tune vision-language models (VLMs) including LLaMA-Vision, Qwen2-VL, Pixtral, LLaVA, SmolVLM2, and audio models like Voxtral with image, video, and audio support.
- **Training Methods**: Full fine-tuning, LoRA, QLoRA, GPTQ, QAT, Preference Tuning (DPO, IPO, KTO, ORPO), RL (GRPO), and Reward Modelling (RM) / Process Reward Modelling (PRM).
- **Easy Configuration**: Re-use a single YAML configuration file across the full fine-tuning pipeline: dataset preprocessing, training, evaluation, quantization, and inference.
- **Performance Optimizations**: [Multipacking](https://docs.axolotl.ai/docs/multipack.html), [Flash Attention](https://github.com/Dao-AILab/flash-attention), [Xformers](https://github.com/facebookresearch/xformers), [Flex Attention](https://pytorch.org/blog/flexattention/), [Liger Kernel](https://github.com/linkedin/Liger-Kernel), [Cut Cross Entropy](https://github.com/apple/ml-cross-entropy/tree/main), [Sequence Parallelism (SP)](https://docs.axolotl.ai/docs/sequence_parallelism.html), [LoRA optimizations](https://docs.axolotl.ai/docs/lora_optims.html), [Multi-GPU training (FSDP1, FSDP2, DeepSpeed)](https://docs.axolotl.ai/docs/multi-gpu.html), [Multi-node training (Torchrun, Ray)](https://docs.axolotl.ai/docs/multi-node.html), and many more!
- **Flexible Dataset Handling**: Load from local, HuggingFace, and cloud (S3, Azure, GCP, OCI) datasets.
- **Cloud Ready**: We ship [Docker images](https://hub.docker.com/u/axolotlai) and also [PyPI packages](https://pypi.org/project/axolotl/) for use on cloud platforms and local hardware.

- **Extensive Documentation**: Comprehensive [docs](https://docs.axolotl.ai/) and [examples](https://github.com/axolotl-ai-cloud/axolotl/tree/main/examples) are available to help you get started.

## Run on Akash Network

Akash provides first-class support to deploy Axolotl on the Akash decentralized GPU network.

### Other Configuration Files

- **[.env.example](.env.example)**: Template for environment variables needed for deployment
- **[llama-3.2-1b-lora-4bit.yaml](llama-3.2-1b-lora-4bit.yaml)**: Example training configuration for fine-tuning Llama-3.2-1B with LoRA and 4-bit quantization
- **[Tranning_confid.md](Tranning_confid.md)**: Comprehensive training configuration reference guide

- **[deploy.yaml](deploy.yaml)**: Basic deployment configuration with ephemeral data storage and persistent configs. Use for quick starts, testing, or when dataset re-download is acceptable.
- **[deploy-persistent.yaml](deploy-persistent.yaml)**: Persistent deployment configuration with both data and configs stored persistently. Use for long-running training jobs where dataset persistence is required.

### Environment Variables

**Required**:
- `JUPYTER_TOKEN`: Strong password to log into JupyterLab

**Optional (commonly used)**:
- `HF_TOKEN`: Hugging Face token (for private models/datasets)
- `WANDB_API_KEY`: Weights & Biases API key (for experiment tracking)
- `WANDB_PROJECT`: W&B project name (default: wandb auto)
- `WANDB_ENTITY`: W&B entity (org/user)
- `WANDB_MODE`: Set to "offline" to disable network (optional)

### Directory Structure

- `BASE_VOLUME`: Base path for data (default: `/workspace/data`)
- `AXOLOTL_CONFIG_DIR`: Path to Axolotl YAML configs (default: `/src/config`)
- `HF_DATASETS_CACHE`: Hugging Face datasets cache (default: `/workspace/data/huggingface-cache/datasets`)
- `HUGGINGFACE_HUB_CACHE`: HF model/hub cache (default: `/workspace/data/huggingface-cache/hub`)
- `TRANSFORMERS_CACHE`: Transformers cache (default: `/workspace/data/huggingface-cache/hub`)
- `HF_HOME`: Alternate HF home directory (optional, usually not needed)

### Jupyter Configuration

- `JUPYTER_ENABLE_LAB`: yes/no (default: yes)
- `JUPYTER_TOKEN`: Strong password for JupyterLab auth (required)

### Performance Tuning

- `HF_HUB_ENABLE_HF_TRANSFER`: "1" to enable hf_transfer for faster downloads
- `HF_HUB_ENABLE_SAFETENSORS_FAST`: "1" to enable faster safetensors
- `TORCH_CUDA_ALLOC_CONF`: e.g., "expandable_segments:True" (optional tuning)

## Resource Configuration

Both deployment configurations provide substantial computational resources:

- **CPU**: 24 units
- **Memory**: 251Gi
- **GPU**: 1x NVIDIA GPU
- **Storage**: Ample storage (550Gi in basic, 500Gi + 50Gi in persistent)

You can modify these resources based on your requirements. For detailed information about Akash network capabilities and resource specifications, refer to the [official Akash documentation](https://akash.network/docs/).
