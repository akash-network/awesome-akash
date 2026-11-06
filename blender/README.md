# Blender

Run [Blender](https://www.blender.org/) in your browser on an Akash GPU. This template uses the [LinuxServer Blender image](https://docs.linuxserver.io/images/docker-blender/), a full Blender desktop streamed over the web, with a persistent volume for your projects.

## What you get

- Blender 5.x (LTS) with the full desktop UI in any modern browser
- 1 NVIDIA GPU for Cycles and EEVEE rendering
- 4 CPU cores, 16 GB RAM
- 20 GB persistent storage mounted at `/config`, so your files survive restarts and updates

## Deploy

1. Open `deploy.yaml` and change `CUSTOM_USER` and `PASSWORD`. They protect your web desktop, so don't leave the defaults.
2. Deploy it with [Akash Air](https://air.akash.network), [Akash Console](https://console.akash.network), the CLI, or the API.
3. Pick a provider from the bids and create the lease.
4. Open the lease URL and log in with the username and password you set.

## Using Blender

**Upload a `.blend` file:** drag it from your computer into the Blender browser tab. It lands in `/config/Desktop`. Then use **File → Open** in Blender and pick it from the Desktop folder. Dragging a file only uploads it. It doesn't open it.

**Large files:** uploads through the browser are limited to 100 MB. For bigger files, open the **Shell** tab of your deployment and download them with `wget` or `curl -L -O <public-url>` into `/config/Desktop`.

**Download your work:** save in Blender, then use the **Shell** tab's download option to fetch the file from `/config/Desktop`.

**Render with the GPU:** go to **Edit → Preferences → System → Cycles Render Devices**, choose **CUDA** (or OptiX), and tick your GPU. Then in the **Render** properties set **Device** to **GPU Compute**.

## Notes

- **Persistence:** everything under `/config` is kept while the deployment is open. When you close the deployment, the volume is deleted. Download anything you want to keep first.
- **Providers differ:** hardware video encoding (NVENC) and the Shell tab depend on the provider. If the stream feels slow, try another provider.
- **Change the GPU, CPU or memory** in the `profiles` section of `deploy.yaml`. No GPU model is pinned, so more providers can bid.
- **Storage class:** persistent storage uses `beta3`. If you get no bids, check that your region's providers offer it.
