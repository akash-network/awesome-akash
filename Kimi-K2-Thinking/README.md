<div align="center">
  <picture>
      <img src="https://huggingface.co/moonshotai/Kimi-K2-Thinking/resolve/main/figures/kimi-logo.png" width="30%" alt="Kimi K2: Open Agentic Intellignece">
  </picture>
</div>
<hr>
<div align="center" style="line-height:1">
  <a href="https://www.kimi.com" target="_blank"><img alt="Chat" src="https://img.shields.io/badge/🤖%20Chat-Kimi%20K2-ff6b6b?color=1783ff&logoColor=white"/></a>
  <a href="https://www.moonshot.ai" target="_blank"><img alt="Homepage" src="https://img.shields.io/badge/Homepage-Moonshot%20AI-white?logo=Kimi&logoColor=white"/></a>
</div>

<div align="center" style="line-height: 1;">
  <a href="https://huggingface.co/moonshotai" target="_blank"><img alt="Hugging Face" src="https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Moonshot%20AI-ffc107?color=ffc107&logoColor=white"/></a>
  <a href="https://twitter.com/kimi_moonshot" target="_blank"><img alt="Twitter Follow" src="https://img.shields.io/badge/Twitter-Kimi.ai-white?logo=x&logoColor=white"/></a>
    <a href="https://discord.gg/TYU2fdJykW" target="_blank"><img alt="Discord" src="https://img.shields.io/badge/Discord-Kimi.ai-white?logo=discord&logoColor=white"/></a>
</div>
<div align="center" style="line-height: 1;">
  <a href="https://huggingface.co/moonshotai/Kimi-K2-Thinking/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/badge/License-Modified_MIT-f5de53?&color=f5de53"/></a>
</div>
<p align="center">
<b>📰&nbsp;&nbsp;<a href="https://moonshotai.github.io/Kimi-K2/thinking.html">Tech Blog</a></b>
</p>


## 1. Model Introduction

Kimi K2 Thinking is the latest, most capable version of open-source thinking model. Starting with Kimi K2, we built it as a thinking agent that reasons step-by-step while dynamically invoking tools. It sets a new state-of-the-art on Humanity's Last Exam (HLE), BrowseComp, and other benchmarks by dramatically scaling multi-step reasoning depth and maintaining stable tool-use across 200–300 sequential calls. At the same time, K2 Thinking is a native INT4 quantization model with 256k context window, achieving lossless reductions in inference latency and GPU memory usage.

### Key Features
- **Deep Thinking & Tool Orchestration**: End-to-end trained to interleave chain-of-thought reasoning with function calls, enabling autonomous research, coding, and writing workflows that last hundreds of steps without drift.
- **Native INT4 Quantization**: Quantization-Aware Training (QAT) is employed in post-training stage to achieve lossless 2x speed-up in low-latency mode.
- **Stable Long-Horizon Agency**: Maintains coherent goal-directed behavior across up to 200–300 consecutive tool invocations, surpassing prior models that degrade after 30–50 steps.


## 2. Model Summary

<div align="center">


| | |
|:---:|:---:|
| **Architecture** | Mixture-of-Experts (MoE) |
| **Total Parameters** | 1T |
| **Activated Parameters** | 32B |
| **Number of Layers** (Dense layer included) | 61 |
| **Number of Dense Layers** | 1 |
| **Attention Hidden Dimension** | 7168 |
| **MoE Hidden Dimension** (per Expert) | 2048 |
| **Number of Attention Heads** | 64 |
| **Number of Experts** | 384 |
| **Selected Experts per Token** | 8 |
| **Number of Shared Experts** | 1 |
| **Vocabulary Size** | 160K |
| **Context Length** | 256K |
| **Attention Mechanism** | MLA |
| **Activation Function** | SwiGLU |
</div>

## 3. Evaluation Results

**Reasoning Tasks**
| Benchmark | Setting | K2 Thinking | GPT-5 | Claude Sonnet 4.5<br> (Thinking) | K2 0905 | DeepSeek-V3.2 | Grok-4 |
|:----------:|:--------:|:------------:|:------:|:----------------------------:|:--------:|:--------------:|:-------:|
| **HLE (Text-only)** | no tools | 23.9 | 26.3 | 19.8* | 7.9 | 19.8 | 25.4 |
| | w/ tools | 44.9 | 41.7* | 32.0* | 21.7 | 20.3* | 41.0 |
| | heavy | 51.0 | 42.0 | - | - | - | 50.7 |
| **AIME25** | no tools | 94.5 | 94.6 | 87.0 | 51.0 | 89.3 | 91.7 |
| | w/ python | 99.1 | 99.6 | 100.0 | 75.2 | 58.1* | 98.8 |
| | heavy | 100.0 | 100.0 | - | - | - | 100.0 |
| **HMMT25** | no tools | 89.4 | 93.3 | 74.6* | 38.8 | 83.6 | 90.0 |
| | w/ python | 95.1 | 96.7 | 88.8* | 70.4 | 49.5* | 93.9 |
| | heavy | 97.5 | 100.0 | - | - | - | 96.7 |
| **IMO-AnswerBench** | no tools | 78.6 | 76.0* | 65.9* | 45.8 | 76.0* | 73.1 |
| **GPQA** | no tools | 84.5 | 85.7 | 83.4 | 74.2 | 79.9 | 87.5 |

**General Tasks**
| Benchmark | Setting | K2 Thinking | GPT-5 | Claude Sonnet 4.5<br> (Thinking) | K2 0905 | DeepSeek-V3.2 |
|:----------:|:--------:|:------------:|:------:|:----------------------------:|:--------:|:--------------:|
| **MMLU-Pro** | no tools | 84.6 | 87.1 | 87.5 | 81.9 | 85.0 |
| **MMLU-Redux** | no tools | 94.4 | 95.3 | 95.6 | 92.7 | 93.7 |
| **Longform Writing** | no tools | 73.8 | 71.4 | 79.8 | 62.8 | 72.5 |
| **HealthBench** | no tools | 58.0 | 67.2 | 44.2 | 43.8 | 46.9 |

**Agentic Search Tasks**
| Benchmark | Setting | K2 Thinking | GPT-5 | Claude Sonnet 4.5<br> (Thinking) | K2 0905 | DeepSeek-V3.2 |
|:----------:|:--------:|:------------:|:------:|:----------------------------:|:--------:|:--------------:|
| **BrowseComp** | w/ tools | 60.2 | 54.9 | 24.1 | 7.4 | 40.1 |
| **BrowseComp-ZH** | w/ tools | 62.3 | 63.0* | 42.4* | 22.2 | 47.9 |
| **Seal-0** | w/ tools | 56.3 | 51.4* | 53.4* | 25.2 | 38.5* |
| **FinSearchComp-T3** | w/ tools | 47.4 | 48.5* | 44.0* | 10.4 | 27.0* |
| **Frames** | w/ tools | 87.0 | 86.0* | 85.0* | 58.1 | 80.2* |

**Coding Tasks**
| Benchmark | Setting | K2 Thinking | GPT-5 | Claude Sonnet 4.5<br> (Thinking) | K2 0905 | DeepSeek-V3.2 |
|:----------:|:--------:|:------------:|:------:|:----------------------------:|:--------:|:--------------:|
| **SWE-bench Verified** | w/ tools | 71.3 | 74.9 | 77.2 | 69.2 | 67.8 |
| **SWE-bench Multilingual** | w/ tools | 61.1 | 55.3* | 68.0 | 55.9 | 57.9 |
| **Multi-SWE-bench** | w/ tools | 41.9 | 39.3* | 44.3 | 33.5 | 30.6 |
| **SciCode** | no tools | 44.8 | 42.9 | 44.7 | 30.7 | 37.7 |
| **LiveCodeBenchV6** | no tools | 83.1 | 87.0* | 64.0* | 56.1* | 74.1 |
| **OJ-Bench (cpp)** | no tools | 48.7 | 56.2* | 30.4* | 25.5* | 38.2* |
| **Terminal-Bench** | w/ simulated tools (JSON) | 47.1 | 43.8 | 51.0 | 44.5 | 37.7 |
<details>
<summary><b>Footnotes</b></summary>

1. To ensure a fast, lightweight experience, we selectively employ a subset of tools and reduce the number of tool call steps under the chat mode on kimi.com. As a result, chatting on kimi.com may not reproduce our benchmark scores. Our agentic mode will be updated soon to reflect the full capabilities of K2 Thinking.

2. **Testing Details**:  
 2.1. All benchmarks were evaluated at temperature = 1.0 and 256 k context length for K2 Thinking, except for SciCode, for which we followed the official temperature setting of 0.0.  
 2.2. HLE (no tools), AIME25, HMMT25, and GPQA were capped at a 96k thinking-token budget, while IMO-Answer Bench, LiveCodeBench and OJ-Bench were capped at a 128k thinking-token budget. Longform Writing was capped at a 32k completion-token budget.  
 2.3. For AIME and HMMT (no tools), we report the average of 32 runs (avg@32). For AIME and HMMT (with Python), we report the average of 16 runs (avg@16). For IMO-AnswerBench, we report the average of 8 runs (avg@8).

3. **Baselines**:  
 3.1 GPT-5, Claude-4.5-sonnet, Grok-4 results and DeepSeek-V3.2 results are quoted from the [GPT-5 post](https://openai.com/index/introducing-gpt-5/), [GPT-5 for Developers post](https://openai.com/index/introducing-gpt-5-for-developers/), [GPT-5 system card](https://openai.com/index/gpt-5-system-card/), [claude-sonnet-4-5 post](https://www.anthropic.com/news/claude-sonnet-4-5), [grok-4 post](https://x.ai/news/grok-4), [deepseek-v3.2 post](https://api-docs.deepseek.com/news/news250929), the [public Terminal-Bench leaderboard](https://www.tbench.ai/leaderboard) (Terminus-2), the [public Vals AI leaderboard](https://vals.ai/) and [artificialanalysis](https://artificialanalysis.ai/). Benchmarks for which no available public scores were re-tested under the same conditions used for k2 thinking and are marked with an asterisk(*).  
 3.2 The GPT-5 and Grok-4 on the HLE full set with tools are 35.2 and 38.6 from the official posts. In our internal evaluation on the HLE text-only subset, GPT-5 scores 41.7 and Grok-4 scores 38.6 (Grok-4’s launch cited 41.0 on the text-only subset). For GPT-5's HLE text-only w/o tool, we use score from <a href="https://scale.com/leaderboard/humanitys_last_exam_text_only" target="_blank">Scale.ai</a>. The official GPT5 HLE full set w/o tool is 24.8.  
 3.3 For <a href="https://aclanthology.org/2025.emnlp-main.1794.pdf" target="_blank">IMO-AnswerBench</a>: GPT-5 scored 65.6 in the benchmark paper. We re-evaluated GPT-5 with official API and obtained a score of 76.
4. **For HLE (w/ tools) and the agentic-search benchmarks**:  
 4.1. K2 Thinking was equipped with search, code-interpreter, and web-browsing tools.  
 4.2. BrowseComp-ZH, Seal-0 and FinSearchComp-T3 were run 4 times independently and the average is reported (avg@4).  
 4.3. The evaluation used o3-mini as judge, configured identically to the official HLE setting; judge prompts were taken verbatim from the official repository.  
 4.4. On HLE, the maximum step limit was 120, with a 48 k-token reasoning budget per step; on agentic-search tasks, the limit was 300 steps with a 24 k-token reasoning budget per step.  
 4.5. When tool execution results cause the accumulated input to exceed the model's context limit (256k), we employ a simple context management strategy that hides all previous tool outputs.  
 4.6. The web access to Hugging Face may lead to data leakage in certain benchmark tests, such as HLE. K2 Thinking can achieve a score of 51.3 on HLE without blocking Hugging Face. To ensure a fair and rigorous comparison, we blocked access to Hugging Face during testing.
5. **For Coding Tasks**:  
 5.1. Terminal-Bench scores were obtained with the default agent framework (Terminus-2) and the provided JSON parser.  
 5.2. For other coding tasks, the result was produced with our in-house evaluation harness. The harness is derived from SWE-agent, but we clamp the context windows of the Bash and Edit tools and rewrite the system prompt to match the task semantics.  
 5.3. All reported scores of coding tasks are averaged over 5 independent runs.
6. **Heavy Mode**: K2 Thinking Heavy Mode employs an efficient parallel strategy: it first rolls out eight trajectories simultaneously, then reflectively aggregates all outputs to generate the final result. Heavy mode for GPT-5 denotes the official GPT-5 Pro score.
</details>
## 4. Native INT4 Quantization
Low-bit quantization is an effective way to reduce inference latency and GPU memory usage on large-scale inference servers. However, thinking models use excessive decoding lengths, and thus quantization often results in substantial performance drops. 
To overcome this challenge, we adopt Quantization-Aware Training (QAT) during the post-training phase, applying INT4 weight-only quantization to the MoE components. It allows K2 Thinking to support native INT4 inference with a roughly 2x generation speed improvement while achieving state-of-the-art performance. All benchmark results are reported under INT4 precision.
The checkpoints are saved in compressed-tensors format, supported by most of mainstream inference engine. If you need the checkpoints in higher precision such as FP8 or BF16, you can refer to [official repo of compressed-tensors](https://github.com/vllm-project/compressed-tensors) to unpack the int4 weights and convert to any higher precision. 
## 5. Deployment
> [!Note]
> You can access K2 Thinking's API on https://platform.moonshot.ai , we provide OpenAI/Anthropic-compatible API for you.
Currently, Kimi-K2-Thinking is recommended to run on the following inference engines:
* vLLM
* SGLang
* KTransformers