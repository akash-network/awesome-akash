To quote the creator:

Falcon-7B-Instruct is a 7B parameters causal decoder-only model built by TII based on Falcon-7B and finetuned on a mixture of chat/instruct datasets. It is made available under the Apache 2.0 license.

Why use Falcon-7B-Instruct?

You are looking for a ready-to-use chat/instruct model based on Falcon-7B.
Falcon-7B is a strong base model, outperforming comparable open-source models (e.g., MPT-7B, StableLM, RedPajama etc.), thanks to being trained on 1,500B tokens of RefinedWeb enhanced with curated corpora. See the OpenLLM Leaderboard.
It features an architecture optimized for inference, with FlashAttention (Dao et al., 2022) and multiquery (Shazeer et al., 2019).

Originally found on huggingface.co: https://huggingface.co/tiiuae/falcon-7b-instruct

Typically for GPUs with more than 16GB of VRAM. A demonstration of the working model on Akash network running on an nVidia A100 and an nVidia RTX 3090 can be found here: https://www.youtube.com/watch?v=1wL0cIbQ2x4&t=1s&pp=ygUJZXVyb3Bsb3Rz

The model has some 10GB to download so please give it time to start.

TODO: make it possible to continue the conversation
