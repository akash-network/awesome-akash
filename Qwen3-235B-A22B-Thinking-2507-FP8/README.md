# Qwen3-235B-A22B-Thinking-2507-FP8

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-Qwen3-235B-A22B-Thinking-2507-FP8)

<a href="https://chat.qwen.ai/" target="_blank" style="margin: 2px;">
    <img alt="Chat" src="https://img.shields.io/badge/%F0%9F%92%9C%EF%B8%8F%20Qwen%20Chat%20-536af5" style="display: inline-block; vertical-align: middle;"/>
</a>

## Highlights

Over the past three months, we have continued to scale the **thinking capability** of Qwen3-235B-A22B, improving both the **quality and depth** of reasoning. We are pleased to introduce **Qwen3-235B-A22B-Thinking-2507-FP8**, featuring the following key enhancements:
- **Significantly improved performance** on reasoning tasks, including logical reasoning, mathematics, science, coding, and academic benchmarks that typically require human expertise — achieving **state-of-the-art results among open-source thinking models**.
- **Markedly better general capabilities**, such as instruction following, tool usage, text generation, and alignment with human preferences.
- **Enhanced 256K long-context understanding** capabilities.

**NOTE**: This version has an increased thinking length. We strongly recommend its use in highly complex reasoning tasks.

![image/jpeg](https://qianwen-res.oss-cn-beijing.aliyuncs.com/Qwen3-2507/Qwen3-235B-A22B-Thinking-2507.jpeg)

## Model Overview

This repo contains the FP8 version of **Qwen3-235B-A22B-Thinking-2507**, which has the following features:
- Type: Causal Language Models
- Training Stage: Pretraining & Post-training
- Number of Parameters: 235B in total and 22B activated
- Number of Parameters (Non-Embedding): 234B
- Number of Layers: 94
- Number of Attention Heads (GQA): 64 for Q and 4 for KV
- Number of Experts: 128
- Number of Activated Experts: 8
- Context Length: **262,144 natively**. 

**NOTE: This model supports only thinking mode. Meanwhile, specifying `enable_thinking=True` is no longer required.**

Additionally, to enforce model thinking, the default chat template automatically includes `<think>`. Therefore, it is normal for the model's output to contain only `</think>` without an explicit opening `<think>` tag.
  
For more details, including benchmark evaluation, hardware requirements, and inference performance, please refer to our [blog](https://qwenlm.github.io/blog/qwen3/), [GitHub](https://github.com/QwenLM/Qwen3), and [Documentation](https://qwen.readthedocs.io/en/latest/).

## Performance


|  | Deepseek-R1-0528 | OpenAI O4-mini | OpenAI O3 | Gemini-2.5 Pro | Claude4 Opus Thinking | Qwen3-235B-A22B Thinking | Qwen3-235B-A22B-Thinking-2507 |
|--- | --- | --- | --- | --- | --- | --- | --- |
| **Knowledge** | | | | | | | |
| MMLU-Pro | 85.0 | 81.9 | **85.9** | 85.6 | - | 82.8 | 84.4 |
| MMLU-Redux | 93.4 | 92.8 | **94.9** | 94.4 | 94.6 | 92.7 | 93.8 |
| GPQA | 81.0 | 81.4* | 83.3* | **86.4** | 79.6 | 71.1 | 81.1 |
| SuperGPQA | 61.7 | 56.4 | - | 62.3 | - | 60.7 | **64.9** |
| **Reasoning** | | | | | | |
| AIME25 | 87.5 | **92.7*** | 88.9* | 88.0 | 75.5 | 81.5 | 92.3 |
| HMMT25 | 79.4 | 66.7 | 77.5 | 82.5 | 58.3 | 62.5 | **83.9** |
| LiveBench 20241125 | 74.7 | 75.8 | 78.3 | **82.4** | 78.2 | 77.1 | 78.4 |
| HLE | 17.7# | 18.1* | 20.3 | **21.6** | 10.7 | 11.8# | 18.2# |
| **Coding** | | | | | | | |
| LiveCodeBench v6 (25.02-25.05) | 68.7 | 71.8 | 58.6 | 72.5 | 48.9 | 55.7 | **74.1** |
| CFEval | 2099 | 1929 | 2043 | 2001 | - | 2056 | **2134** |
| OJBench | 33.6 | 33.3 | 25.4 | **38.9** | - | 25.6 | 32.5 |
| **Alignment** | | | | | | | |
| IFEval | 79.1 | **92.4** | 92.1 | 90.8 | 89.7 | 83.4 | 87.8 |
| Arena-Hard v2$ | 72.2 | 59.3 | **80.8** | 72.5 | 59.1 | 61.5 | 79.7 |
| Creative Writing v3 | 86.3 | 78.8 | **87.7** | 85.9 | 83.8 | 84.6 | 86.1 |
| WritingBench | 83.2 | 78.4 | 85.3 | 83.1 | 79.1 | 80.3 | **88.3** |
| **Agent** | | | | | | | |
| BFCL-v3 | 63.8 | 67.2 | **72.4** | 67.2 | 61.8 | 70.8 | 71.9 |
| TAU2-Retail | 64.9 | 71.0 | **76.3** | 71.3 | - | 40.4 | 71.9 |
| TAU2-Airline | 60.0 | 59.0 | **70.0** | 60.0 | - | 30.0 | 58.0 |
| TAU2-Telecom | 33.3 | 42.0 | **60.5** | 37.4 | - | 21.9 | 45.6 |
| **Multilingualism** | | | | | | | |
| MultiIF | 63.5 | 78.0 | 80.3 | 77.8 | - | 71.9 | **80.6** |
| MMLU-ProX | 80.6 | 79.0 | 83.3 | **84.7** | - | 80.0 | 81.0 |
| INCLUDE | 79.4 | 80.8 | **86.6** | 85.1 | - | 78.7 | 81.0 |
| PolyMATH | 46.9 | 48.7 | 49.7 | 52.2 | - | 54.7 | **60.1** |

\* For OpenAI O4-mini and O3, we use a medium reasoning effort, except for scores marked with *, which are generated using high reasoning effort.

\# According to the official evaluation criteria of HLE, scores marked with \# refer to models that are not multi-modal and were evaluated only on the text-only subset.

$ For reproducibility, we report the win rates evaluated by GPT-4.1.

\& For highly challenging tasks (including PolyMATH and all reasoning and coding tasks), we use an output length of 81,920 tokens. For all other tasks, we set the output length to 32,768.


## Quickstart

The code of Qwen3-MoE has been in the latest Hugging Face `transformers` and we advise you to use the latest version of `transformers`.

With `transformers<4.51.0`, you will encounter the following error:
```
KeyError: 'qwen3_moe'
```

The following contains a code snippet illustrating how to use the model generate content based on given inputs. 
```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model_name = "Qwen/Qwen3-235B-A22B-Thinking-2507-FP8"

# load the tokenizer and the model
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    torch_dtype="auto",
    device_map="auto"
)

# prepare the model input
prompt = "Give me a short introduction to large language model."
messages = [
    {"role": "user", "content": prompt}
]
text = tokenizer.apply_chat_template(
    messages,
    tokenize=False,
    add_generation_prompt=True,
)
model_inputs = tokenizer([text], return_tensors="pt").to(model.device)

# conduct text completion
generated_ids = model.generate(
    **model_inputs,
    max_new_tokens=32768
)
output_ids = generated_ids[0][len(model_inputs.input_ids[0]):].tolist() 

# parsing thinking content
try:
    # rindex finding 151668 (</think>)
    index = len(output_ids) - output_ids[::-1].index(151668)
except ValueError:
    index = 0

thinking_content = tokenizer.decode(output_ids[:index], skip_special_tokens=True).strip("\n")
content = tokenizer.decode(output_ids[index:], skip_special_tokens=True).strip("\n")

print("thinking content:", thinking_content)  # no opening <think> tag
print("content:", content)

```

For deployment, you can use `sglang>=0.4.6.post1` or `vllm>=0.8.5` or to create an OpenAI-compatible API endpoint:
- SGLang:
    ```shell
    python -m sglang.launch_server --model-path Qwen/Qwen3-235B-A22B-Thinking-2507-FP8 --tp 4 --context-length 262144  --reasoning-parser deepseek-r1
    ```
- vLLM:
    ```shell
    vllm serve Qwen/Qwen3-235B-A22B-Thinking-2507-FP8 --tensor-parallel-size 4 --max-model-len 262144 --enable-reasoning --reasoning-parser deepseek_r1
    ```

**Note: If you encounter out-of-memory (OOM) issues, you may consider reducing the context length to a smaller value. However, since the model may require longer token sequences for reasoning, we strongly recommend using a context length greater than 131,072 when possible.**

For local use, applications such as Ollama, LMStudio, MLX-LM, llama.cpp, and KTransformers have also supported Qwen3.

## Note on FP8

For convenience and performance, we have provided `fp8`-quantized model checkpoint for Qwen3, whose name ends with `-FP8`. The quantization method is fine-grained `fp8` quantization with block size of 128. You can find more details in the `quantization_config` field in `config.json`.

You can use the Qwen3-235B-A22B-Thinking-2507-FP8 model with serveral inference frameworks, including `transformers`, `sglang`, and `vllm`, as the original bfloat16 model.

## Agentic Use

Qwen3 excels in tool calling capabilities. We recommend using [Qwen-Agent](https://github.com/QwenLM/Qwen-Agent) to make the best use of agentic ability of Qwen3. Qwen-Agent encapsulates tool-calling templates and tool-calling parsers internally, greatly reducing coding complexity.

To define the available tools, you can use the MCP configuration file, use the integrated tool of Qwen-Agent, or integrate other tools by yourself.
```python
from qwen_agent.agents import Assistant

# Define LLM
# Using Alibaba Cloud Model Studio
llm_cfg = {
    'model': 'qwen3-235b-a22b-thinking-2507',
    'model_type': 'qwen_dashscope',
}

# Using OpenAI-compatible API endpoint. It is recommended to disable the reasoning and the tool call parsing
# functionality of the deployment frameworks and let Qwen-Agent automate the related operations. For example, 
# `VLLM_USE_MODELSCOPE=true vllm serve Qwen/Qwen3-235B-A22B-Thinking-2507-FP8 --served-model-name Qwen3-235B-A22B-Thinking-2507 --tensor-parallel-size 4 --max-model-len 262144`.
#
# llm_cfg = {
#     'model': 'Qwen3-235B-A22B-Thinking-2507',
# 
#     # Use a custom endpoint compatible with OpenAI API:
#     'model_server': 'http://localhost:8000/v1',  # api_base without reasoning and tool call parsing
#     'api_key': 'EMPTY',
#     'generate_cfg': {
#         'thought_in_content': True,
#     },
# }

# Define Tools
tools = [
    {'mcpServers': {  # You can specify the MCP configuration file
            'time': {
                'command': 'uvx',
                'args': ['mcp-server-time', '--local-timezone=Asia/Shanghai']
            },
            "fetch": {
                "command": "uvx",
                "args": ["mcp-server-fetch"]
            }
        }
    },
  'code_interpreter',  # Built-in tools
]

# Define Agent
bot = Assistant(llm=llm_cfg, function_list=tools)

# Streaming generation
messages = [{'role': 'user', 'content': 'https://qwenlm.github.io/blog/ Introduce the latest developments of Qwen'}]
for responses in bot.run(messages=messages):
    pass
print(responses)
```

## Best Practices

To achieve optimal performance, we recommend the following settings:

1. **Sampling Parameters**:
   - We suggest using `Temperature=0.6`, `TopP=0.95`, `TopK=20`, and `MinP=0`.
   - For supported frameworks, you can adjust the `presence_penalty` parameter between 0 and 2 to reduce endless repetitions. However, using a higher value may occasionally result in language mixing and a slight decrease in model performance.

2. **Adequate Output Length**: We recommend using an output length of 32,768 tokens for most queries. For benchmarking on highly complex problems, such as those found in math and programming competitions, we suggest setting the max output length to 81,920 tokens. This provides the model with sufficient space to generate detailed and comprehensive responses, thereby enhancing its overall performance.

3. **Standardize Output Format**: We recommend using prompts to standardize model outputs when benchmarking.
   - **Math Problems**: Include "Please reason step by step, and put your final answer within \boxed{}." in the prompt.
   - **Multiple-Choice Questions**: Add the following JSON structure to the prompt to standardize responses: "Please show your choice in the `answer` field with only the choice letter, e.g., `"answer": "C"`."

4. **No Thinking Content in History**: In multi-turn conversations, the historical model output should only include the final output part and does not need to include the thinking content. It is implemented in the provided chat template in Jinja2. However, for frameworks that do not directly use the Jinja2 chat template, it is up to the developers to ensure that the best practice is followed.


### Citation

If you find our work helpful, feel free to give us a cite.

```
@misc{qwen3technicalreport,
      title={Qwen3 Technical Report}, 
      author={Qwen Team},
      year={2025},
      eprint={2505.09388},
      archivePrefix={arXiv},
      primaryClass={cs.CL},
      url={https://arxiv.org/abs/2505.09388}, 
}
```
