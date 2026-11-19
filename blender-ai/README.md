# Blender AI (AkashML)

[Blender](https://www.blender.org/) in your browser on an Akash GPU, with an AI assistant built in. Type what you want in a panel inside Blender, and an LLM served by [AkashML](https://akashml.com) writes the Blender Python and runs it in your scene.

## How it works

1. A startup script installs the [Blender MCP add-on](https://github.com/ahujasid/blender-mcp) and turns it on. It opens a socket on `localhost:9876` inside the container.
2. A small helper script sends your prompt to the AkashML API, gets back Blender Python code, and runs it through that socket.
3. An **Akash AI** panel in the 3D viewport sidebar gives you a prompt box and a **Generate** button.

The socket never leaves the container. The SDL only exposes the web desktop on port 3000.

## What you need

An AkashML API key. Create an account at [akashml.com](https://akashml.com) and generate a key.

## Deploy

1. Open `deploy.yaml` and set:
   - `CUSTOM_USER` and `PASSWORD`: your web desktop login
   - `AKASHML_API_KEY`: your AkashML key
   - `AKASHML_MODEL`: any model ID from the [AkashML model list](https://akashml.com/docs/platform/models)
2. Deploy with [Akash Air](https://air.akash.network), [Akash Console](https://console.akash.network), the CLI, or the API. In Console you can mask the API key after pasting the SDL.
3. Pick a provider and create the lease.
4. Open the lease URL and log in.

## Use it

1. Hover over the 3D viewport (the big grid area) and press **N** to open the sidebar.
2. Open the **Akash AI** tab.
3. Type a prompt, for example `build a small red house with a door at x=4`, and click **Generate**.
4. When the status says **Done**, press **Home** with the mouse over the viewport to frame the scene.

Prompting tips: be specific about positions, sizes and colours. Results vary by model, so try a few from the AkashML list. If a generation fails, the status line shows the error, and you can try again.

You can also use the helper from the **Shell** tab: `ai "add a blue sphere above the cube"`.

## Security

- The AI writes and runs Python inside your Blender session with no sandbox. Don't paste prompts from sources you don't trust, and treat the deployment as disposable.
- Your API key is an environment variable inside the container. Anyone with Shell access to your deployment can read it. Use a key with a spending limit.
- AkashML usage is billed to your AkashML account, not to your Akash lease.
- Change the default `CUSTOM_USER` and `PASSWORD`. Anyone with the lease URL can reach the login page.

## Files, rendering and persistence

Everything from the standard Blender template applies: drag-and-drop uploads land in `/config/Desktop` (use **File → Open**), files over 100 MB need `wget` in the Shell tab, and the 20 GB volume at `/config` is deleted when the deployment closes. To render on the GPU, enable CUDA or OptiX under **Edit → Preferences → System** and set the render device to **GPU Compute**.

## Troubleshooting

- **No Akash AI tab:** press **N** with the mouse over the viewport. Check the add-on: **Edit → Preferences → Add-ons**, and look for "MCP for Blender" ticked.
- **Status says `AKASHML_API_KEY and AKASHML_MODEL must be set`:** one of the two env vars is missing from the SDL.
- **HTTP error in the status line:** check that the key is valid and the model ID matches the AkashML list exactly.
- **Web UI won't load, or HTTPS isn't supported:** this depends on the provider. Close the deployment and pick a different provider.

## Credits

Built on the [LinuxServer Blender image](https://docs.linuxserver.io/images/docker-blender/), the [Blender MCP add-on](https://github.com/ahujasid/blender-mcp), and [AkashML](https://akashml.com).
