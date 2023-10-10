## ComfyUI on Akash Network

The most powerful and modular stable diffusion GUI and backend.
-----------

This ui will let you design and execute advanced stable diffusion pipelines using a graph/nodes/flowchart based interface. For some workflow examples and see what ComfyUI can do you can check out:
### [ComfyUI Examples](https://comfyanonymous.github.io/ComfyUI_examples/)

Env variables MODELURLS, VAEURLS and UPSCALEURLS can be set to automatically download models on deployment start. Just add a string with download urls separated by ","

COMMANDLINE_ARGS can be found [here](https://github.com/comfyanonymous/ComfyUI/blob/9bfec2bdbf0b0d778087a9b32f79e57e2d15b913/comfy/cli_args.py#L36)

Loading Checkpoints, VAEs and Upscalers

Before you can run inference, you'll need to load checkpoint files, VAEs and any upscalers. You can use wget to copy them into specific folders (examples below):

Load Checkpoints:
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors

Load VAE
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors

Load Upscalers
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors
wget https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth

