# Axolotl Training Configuration Reference (Akash)

This document lists the configuration options supported by Axolotl for LLM post-training (full fine-tune, LoRA, QLoRA, etc.) across providers. It is provider-neutral and works on Akash.

Use YAML for native Axolotl runs and optionally JSON if you have an orchestration API that posts jobs.

- On Akash:
  - Place YAML configs in `AXOLOTL_CONFIG_DIR` (default: `/src/config`) and run from JupyterLab or a shell inside the container.
  - Keep datasets/models/caches under `BASE_VOLUME` (default: `/workspace/data`). Use the persistent-data SDL to persist between redeploys.
- Secrets:
  - Do not hardcode secrets in YAML/JSON. Use environment variables (e.g., `HF_TOKEN`, `WANDB_API_KEY`).

## Quick usage

YAML (recommended for Akash )

```yaml
# examples/akash/quickstart.yaml
base_model: "NousResearch/Llama-3.2-1B"
load_in_4bit: true
adapter: "lora"
sequence_len: 2048

datasets:
  - path: "teknium/GPT4-LLM-Cleaned"
    type: "alpaca"
    split: "train[:1000]"

lora_r: 16
lora_alpha: 32
lora_dropout: 0.05
lora_target_modules:
  - q_proj
  - v_proj
  - k_proj
  - o_proj
  - gate_proj
  - up_proj
  - down_proj

gradient_checkpointing: true
micro_batch_size: 2
gradient_accumulation_steps: 8
epochs: 1
optimizer: "adamw_torch"
learning_rate: 2e-4
lr_scheduler: "cosine"
warmup_ratio: 0.03
bf16: true

output_dir: "/workspace/data/outputs/quickstart"
hub_model_id: "your-hf-username/llama-3.2-1b-quickstart"
```

JSON (only if your orchestration expects a request body)

```json
{
  "input": {
    "user_id": "user",
    "model_id": "model-name",
    "run_id": "run-id",
    "credentials": {
      "wandb_api_key": "",
      "hf_token": ""
    },
    "args": {
      "base_model": "NousResearch/Llama-3.2-1B"
      // other supported options below
    }
  }
}
```

Notes:
- Prefer env vars (`HF_TOKEN`, `WANDB_API_KEY`) over `credentials` fields.
- On Akash, dataset local paths live under `/workspace/data/...` if using the persistent volume.

---

## Model Configuration

| Option | Description | Default |
| --- | --- | --- |
| `base_model` | Path or HF ID of the base model | Required |
| `base_model_config` | Separate config path for the base model | Same as model |
| `revision_of_model` | Specific model revision on HF | Latest |
| `tokenizer_config` | Path to custom tokenizer config | Optional |
| `model_type` | Model class to load | AutoModelForCausalLM |
| `tokenizer_type` | Tokenizer class | AutoTokenizer |
| `hub_model_id` | HF Hub repo to push (username/repo) | Optional |

### Model Family Identification (auto-detected in most cases)

| Option | Default | Description |
| --- | --- | --- |
| `is_falcon_derived_model` | false | Falcon-based |
| `is_llama_derived_model` | false | LLaMA-based |
| `is_qwen_derived_model` | false | Qwen-based |
| `is_mistral_derived_model` | false | Mistral-based |

### Model Config Overrides

| Option | Default | Description |
| --- | --- | --- |
| `overrides_of_model_config.rope_scaling.type` | "linear" | linear/dynamic |
| `overrides_of_model_config.rope_scaling.factor` | 1.0 | Scaling factor |

## Model Loading Options

| Option | Description | Default |
| --- | --- | --- |
| `load_in_8bit` | 8-bit quantized load | false |
| `load_in_4bit` | 4-bit quantized load | false |
| `bf16` | Use bfloat16 | false |
| `fp16` | Use float16 | false |
| `tf32` | Use TF32 | false |

## Memory and Device

| Option | Default | Description |
| --- | --- | --- |
| `gpu_memory_limit` | "20GiB" | Cap per-GPU memory |
| `lora_on_cpu` | false | Place LoRA on CPU |
| `device_map` | "auto" | Device strategy |
| `max_memory` | null | Per-device max memory map |

## Training Hyperparameters

| Option | Default | Description |
| --- | --- | --- |
| `gradient_accumulation_steps` | 1 | Accumulation steps |
| `micro_batch_size` | 2 | Per-GPU batch size |
| `eval_batch_size` | null | Eval batch size |
| `num_epochs` | 4 | Training epochs |
| `warmup_steps` | 100 | Warmup steps |
| `warmup_ratio` | 0.05 | Warmup ratio |
| `learning_rate` | 0.00003 | LR |
| `lr_quadratic_warmup` | false | Quadratic warmup |
| `logging_steps` | null | Log freq |
| `eval_steps` | null | Eval freq |
| `evals_per_epoch` | null | Evals per epoch |
| `save_strategy` | "epoch" | Save strategy |
| `save_steps` | null | Save freq |
| `saves_per_epoch` | null | Saves per epoch |
| `save_total_limit` | null | Max checkpoints |
| `max_steps` | null | Max steps |

## Dataset Configuration

YAML example:
```yaml
datasets:
  - path: vicgalle/alpaca-gpt4
    type: alpaca
    ds_type: json
    data_files: path/to/data
    split: train
```

Notes for Akash:
- For local data on a persistent volume, place it under `/workspace/data/...` and reference with an absolute path.

## Chat Template

| Option | Default | Description |
| --- | --- | --- |
| `chat_template` | "tokenizer_default" | Template type |
| `chat_template_jinja` | null | Custom Jinja template |
| `default_system_message` | "You are a helpful assistant." | System message |

## Dataset Processing

| Option | Default | Description |
| --- | --- | --- |
| `dataset_prepared_path` | "data/last_run_prepared" | Prepared output |
| `push_dataset_to_hub` | "" | Push to HF Hub |
| `dataset_processes` | 4 | Preprocess workers |
| `dataset_keep_in_memory` | false | Keep in RAM |
| `shuffle_merged_datasets` | true | Shuffle merged |
| `shuffle_before_merging_datasets` | false | Shuffle per-dataset |
| `dataset_exact_deduplication` | true | Deduplicate |

## LoRA/QLoRA

| Option | Default | Description |
| --- | --- | --- |
| `adapter` | "lora" | lora/qlora |
| `lora_model_dir` | "" | Pretrained LoRA dir |
| `lora_r` | 8 | Rank |
| `lora_alpha` | 16 | Alpha |
| `lora_dropout` | 0.05 | Dropout |
| `lora_target_modules` | ["q_proj","v_proj"] | Target modules |
| `lora_target_linear` | false | All linear |
| `peft_layers_to_transform` | [] | Layers |
| `lora_modules_to_save` | [] | Extra modules |
| `lora_fan_in_fan_out` | false | Fan in/out |

## Optimization

| Option | Default | Description |
| --- | --- | --- |
| `train_on_inputs` | false | Train on prompts |
| `group_by_length` | false | Bucket by length |
| `gradient_checkpointing` | false | Save VRAM |
| `early_stopping_patience` | 3 | Early stop |

## LR Scheduling

| Option | Default | Description |
| --- | --- | --- |
| `lr_scheduler` | "cosine" | Scheduler |
| `lr_scheduler_kwargs` | {} | Params |
| `cosine_min_lr_ratio` | null | Min LR ratio |
| `cosine_constant_lr_ratio` | null | Const LR |
| `lr_div_factor` | null | Div factor |

## Optimizer

| Option | Default | Description |
| --- | --- | --- |
| `optimizer` | "adamw_hf" | Choice |
| `optim_args` | {} | Args |
| `optim_target_modules` | [] | Targets |
| `weight_decay` | null | Weight decay |
| `adam_beta1` | null | Beta1 |
| `adam_beta2` | null | Beta2 |
| `adam_epsilon` | null | Epsilon |
| `max_grad_norm` | null | Clip |

Supported optimizers include:
- adamw_hf, adamw_torch, adamw_torch_fused, adamw_torch_xla, adamw_apex_fused
- adafactor, adamw_anyprecision, adamw_bnb_8bit
- lion_8bit, lion_32bit, sgd, adagrad

## Attention Implementations

| Option | Default | Description |
| --- | --- | --- |
| `flash_optimum` | false | Better TFMs |
| `xformers_attention` | false | xFormers |
| `flash_attention` | false | Flash-Attn |
| `flash_attn_cross_entropy` | false | Cross-entropy |
| `flash_attn_rms_norm` | false | RMS norm |
| `flash_attn_fuse_mlp` | false | Fuse MLP |
| `sdp_attention` | false | Scaled dot product |
| `s2_attention` | false | Shifted sparse |

## Tokenizer Modifications

| Option | Default | Description |
| --- | --- | --- |
| `special_tokens` | - | Token additions |
| `tokens` | [] | Extra tokens |

## Distributed Training

| Option | Default | Description |
| --- | --- | --- |
| `fsdp` | null | FSDP config |
| `fsdp_config` | null | FSDP opts |
| `deepspeed` | null | Deepspeed path |
| `ddp_timeout` | null | DDP timeout |
| `ddp_bucket_cap_mb` | null | Bucket cap |
| `ddp_broadcast_buffers` | null | Broadcast buffers |

## Advanced Features

### Weights & Biases

- `wandb_project`, `wandb_entity`, `wandb_watch`, `wandb_name`, `wandb_run_id`
- Prefer env vars: `WANDB_API_KEY`, `WANDB_PROJECT`, `WANDB_ENTITY`, `WANDB_MODE`

### Performance

- `sample_packing`, `eval_sample_packing`
- `torch_compile`
- `flash_attention`, `xformers_attention`

## Environment variables (cross-provider)

Required:
- `JUPYTER_TOKEN` (for JupyterLab on Akash/RunPod images)

Optional:
- Hugging Face: `HF_TOKEN`, `HF_HOME`
- W&B: `WANDB_API_KEY`, `WANDB_PROJECT`, `WANDB_ENTITY`, `WANDB_MODE`
- Paths: `BASE_VOLUME` (default `/workspace/data`), `AXOLOTL_CONFIG_DIR` (default `/src/config`)
- Caches: `HF_DATASETS_CACHE`, `HUGGINGFACE_HUB_CACHE`, `TRANSFORMERS_CACHE`
- Jupyter: `JUPYTER_ENABLE_LAB`
- Performance: `HF_HUB_ENABLE_HF_TRANSFER`, `HF_HUB_ENABLE_SAFETENSORS_FAST`, `TORCH_CUDA_ALLOC_CONF`

## Notes

- Use `load_in_8bit` or `load_in_4bit` to reduce memory.
- `flash_attention: true` can accelerate training on supported GPUs; otherwise keep it false.
- Use `gradient_checkpointing: true` to reduce VRAM usage.
- Tune `micro_batch_size` and `gradient_accumulation_steps` based on GPU memory.
- If Flash-Attn issues occur on Akash, restart or redeploy your lease (or disable flash attention). Ensure your image and drivers support it.

For more details, see the Axolotl docs.