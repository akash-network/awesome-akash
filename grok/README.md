# Grok on Akash Network

Grok repository: https://github.com/xai-org/grok-1

This deployment uses 4 CPU and 8 GPU (using H100 each). If you are trying to use 1 GPU would result to an error. Currently, this deployment requires `/dev/shm` to be enabled by the provider or this error will occur:

`OSError: [Errno 28] No space left on device: './checkpoints/ckpt-0/tensor00000_000' -> '/dev/shm/tmp238nenvh'`

Some modifications:
- Uses jax[cuda12_pip]==0.4.23 instead of jax[cuda12_pip]==0.4.25
- Models downloaded from huggingface instead of torrent for faster download