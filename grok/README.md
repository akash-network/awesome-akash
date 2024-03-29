# Grok on Akash Network

<img src="grok-app.png">

Grok repository: https://github.com/xai-org/grok-1

This deployment requires 8x H100 80GB or equivalent GPUs. Downloading grok model can take up to 40 minutes, while loading checkpoints can take up to 10 minutes.

## Steps

1. Deploy on [Cloudmos](https://deploy.cloudmos.io) using this [SDL.](deploy.yaml)
2. After deployed, look at the "Logs" tab and wait until the grok model downloaded and checkpoints loaded.
3. Go to "Leases" tab and click the deployment link.
4. Test your grok by entering your prompt and click "Submit".
