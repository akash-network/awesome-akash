[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-openai-gpt-oss-120b)

<p align="center">
  <img alt="gpt-oss-120b" src="https://raw.githubusercontent.com/openai/gpt-oss/main/docs/gpt-oss-120b.svg">
</p>

<p align="center">
  <a href="https://gpt-oss.com"><strong>Try gpt-oss</strong></a> ·
  <a href="https://cookbook.openai.com/topic/gpt-oss"><strong>Guides</strong></a> ·
  <a href="https://openai.com/index/gpt-oss-model-card"><strong>System card</strong></a> ·
  <a href="https://openai.com/index/introducing-gpt-oss/"><strong>OpenAI blog</strong></a>
</p>

<br>

Welcome to the gpt-oss series, [OpenAI’s open-weight models](https://openai.com/open-models) designed for powerful reasoning, agentic tasks, and versatile developer use cases.

We’re releasing two flavors of the open models:
- `gpt-oss-120b` — for production, general purpose, high reasoning use cases that fits into a single H100 GPU (117B parameters with 5.1B active parameters)
- `gpt-oss-20b` — for lower latency, and local or specialized use cases (21B parameters with 3.6B active parameters)

Both models were trained on our [harmony response format](https://github.com/openai/harmony) and should only be used with the harmony format as it will not work correctly otherwise.


> [!NOTE]
> This model card is dedicated to the larger `gpt-oss-120b` model. Check out [`gpt-oss-20b`](https://huggingface.co/openai/gpt-oss-20b) for the smaller model.

# Highlights

* **Permissive Apache 2.0 license:** Build freely without copyleft restrictions or patent risk—ideal for experimentation, customization, and commercial deployment.  
* **Configurable reasoning effort:** Easily adjust the reasoning effort (low, medium, high) based on your specific use case and latency needs.  
* **Full chain-of-thought:** Gain complete access to the model’s reasoning process, facilitating easier debugging and increased trust in outputs. It’s not intended to be shown to end users.  
* **Fine-tunable:** Fully customize models to your specific use case through parameter fine-tuning.
* **Agentic capabilities:** Use the models’ native capabilities for function calling, [web browsing](https://github.com/openai/gpt-oss/tree/main?tab=readme-ov-file#browser), [Python code execution](https://github.com/openai/gpt-oss/tree/main?tab=readme-ov-file#python), and Structured Outputs.
* **Native MXFP4 quantization:** The models are trained with native MXFP4 precision for the MoE layer, making `gpt-oss-120b` run on a single H100 GPU and the `gpt-oss-20b` model run within 16GB of memory.

---

# Inference examples

## Transformers

You can use `gpt-oss-120b` and `gpt-oss-20b` with Transformers. If you use the Transformers chat template, it will automatically apply the [harmony response format](https://github.com/openai/harmony). If you use `model.generate` directly, you need to apply the harmony format manually using the chat template or use our [openai-harmony](https://github.com/openai/harmony) package.

To get started, install the necessary dependencies to setup your environment:

```
pip install -U transformers kernels torch 
```

Once, setup you can proceed to run the model by running the snippet below:

```py
from transformers import pipeline
import torch

model_id = "openai/gpt-oss-120b"

pipe = pipeline(
    "text-generation",
    model=model_id,
    torch_dtype="auto",
    device_map="auto",
)

messages = [
    {"role": "user", "content": "Explain quantum mechanics clearly and concisely."},
]

outputs = pipe(
    messages,
    max_new_tokens=256,
)
print(outputs[0]["generated_text"][-1])
```

Alternatively, you can run the model via [`Transformers Serve`](https://huggingface.co/docs/transformers/main/serving) to spin up a OpenAI-compatible webserver:

```
transformers serve
transformers chat localhost:8000 --model-name-or-path openai/gpt-oss-120b
```

[Learn more about how to use gpt-oss with Transformers.](https://cookbook.openai.com/articles/gpt-oss/run-transformers)

## vLLM

vLLM recommends using [uv](https://docs.astral.sh/uv/) for Python dependency management. You can use vLLM to spin up an OpenAI-compatible webserver. The following command will automatically download the model and start the server.

```bash
uv pip install --pre vllm==0.10.1+gptoss \
    --extra-index-url https://wheels.vllm.ai/gpt-oss/ \
    --extra-index-url https://download.pytorch.org/whl/nightly/cu128 \
    --index-strategy unsafe-best-match

vllm serve openai/gpt-oss-120b
```

[Learn more about how to use gpt-oss with vLLM.](https://cookbook.openai.com/articles/gpt-oss/run-vllm)

## PyTorch / Triton

To learn about how to use this model with PyTorch and Triton, check out our [reference implementations in the gpt-oss repository](https://github.com/openai/gpt-oss?tab=readme-ov-file#reference-pytorch-implementation).

## Ollama

If you are trying to run gpt-oss on consumer hardware, you can use Ollama by running the following commands after [installing Ollama](https://ollama.com/download).

```bash
# gpt-oss-120b
ollama pull gpt-oss:120b
ollama run gpt-oss:120b
```

[Learn more about how to use gpt-oss with Ollama.](https://cookbook.openai.com/articles/gpt-oss/run-locally-ollama)

#### LM Studio

If you are using [LM Studio](https://lmstudio.ai/) you can use the following commands to download.

```bash
# gpt-oss-120b
lms get openai/gpt-oss-120b
```

Check out our [awesome list](https://github.com/openai/gpt-oss/blob/main/awesome-gpt-oss.md) for a broader collection of gpt-oss resources and inference partners.

---

# Download the model

You can download the model weights from the [Hugging Face Hub](https://huggingface.co/collections/openai/gpt-oss-68911959590a1634ba11c7a4) directly from Hugging Face CLI:

```shell
# gpt-oss-120b
huggingface-cli download openai/gpt-oss-120b --include "original/*" --local-dir gpt-oss-120b/
pip install gpt-oss
python -m gpt_oss.chat model/
```

# Reasoning levels

You can adjust the reasoning level that suits your task across three levels:

* **Low:** Fast responses for general dialogue.  
* **Medium:** Balanced speed and detail.  
* **High:** Deep and detailed analysis.

The reasoning level can be set in the system prompts, e.g., "Reasoning: high".

# Tool use

The gpt-oss models are excellent for:
* Web browsing (using built-in browsing tools)
* Function calling with defined schemas
* Agentic operations like browser tasks

# Fine-tuning

Both gpt-oss models can be fine-tuned for a variety of specialized use cases.

This larger model `gpt-oss-120b` can be fine-tuned on a single H100 node, whereas the smaller [`gpt-oss-20b`](https://huggingface.co/openai/gpt-oss-20b) can even be fine-tuned on consumer hardware.
