# Easy Diffusion (Stable Diffusion UI) for Akash
#
# Easy Diffusion, its Python environment and CUDA PyTorch are installed at build time, so a
# deployment only has to download models before the UI starts. Models are not part of the image;
# the entrypoint downloads the ones listed in the MODELS environment variable into /data/models.
#
# Build:  docker build -t <user>/easy-diffusion:<tag> .
# Run:    docker run --gpus all -p 9000:9000 <user>/easy-diffusion:<tag>

FROM nvidia/cuda:12.8.1-base-ubuntu24.04

# Easy Diffusion commit to install (the "main" branch is what its own installer uses).
# Update this and rebuild to ship a newer Easy Diffusion.
ARG ED_COMMIT=7caaf64acd47b6bc40ba2379571d48ea4cc29a6a
# PyTorch build to install. There is no GPU during "docker build", so Easy Diffusion's installer
# would pick CPU-only PyTorch; cu128 is what it picks on a real RTX 30xx/40xx/50xx, A100, H100 etc.
ARG TORCH_INDEX_URL=https://download.pytorch.org/whl/cu128

ENV DEBIAN_FRONTEND=noninteractive \
    ED_DIR=/opt/easy-diffusion \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

# pciutils (lspci) is used by Easy Diffusion at runtime to detect the GPU.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl unzip bzip2 tar git aria2 pciutils libgl1 libglib2.0-0 \
 && rm -rf /var/lib/apt/lists/*

# Easy Diffusion runs as a regular user: its optional v3.5 engine (Forge) refuses to run as root.
RUN useradd -m -s /bin/bash ed \
 && mkdir -p "$ED_DIR" /data \
 && chown ed:ed "$ED_DIR" /data

USER ed
WORKDIR /opt/easy-diffusion

# These steps mirror Easy Diffusion's own Linux installer (start.sh -> bootstrap.sh ->
# on_env_start.sh -> on_sd_start.sh), minus starting the server, all in one layer to keep
# the image small.
RUN set -eux \
 # 1. The launcher scripts from the official Linux release
 && curl -fsSL -o /tmp/ed.zip https://github.com/easydiffusion/easydiffusion/releases/latest/download/Easy-Diffusion-Linux.zip \
 && unzip -q /tmp/ed.zip -d /tmp/ed \
 && cp -a /tmp/ed/easy-diffusion/. "$ED_DIR"/ \
 && rm -rf /tmp/ed /tmp/ed.zip \
 && chmod +x scripts/*.sh \
 # 2. Private conda environment with Python and git (bootstrap.sh)
 && bash scripts/bootstrap.sh \
 # 3. The Easy Diffusion source code at the pinned commit (on_env_start.sh)
 && git clone -q https://github.com/easydiffusion/easydiffusion.git sd-ui-files \
 && git -C sd-ui-files -c advice.detachedHead=false checkout -q "$ED_COMMIT" \
 && echo sd_ui_git_cloned >> scripts/install_status.txt \
 && rm -rf ui && cp -Rf sd-ui-files/ui . \
 && for f in on_sd_start.sh on_env_start.sh bootstrap.sh check_modules.py get_config.py \
             config.yaml.sample webui_console.py ensure_torchruntime.py functions.sh; do \
      cp "sd-ui-files/scripts/$f" scripts/; \
    done \
 && cp sd-ui-files/scripts/start.sh sd-ui-files/scripts/developer_console.sh . \
 && mkdir -p stable-diffusion \
 # 4. CUDA PyTorch, then Easy Diffusion's Python packages (on_sd_start.sh)
 && export PATH="$ED_DIR/installer_files/env/bin:$PATH" PYTHONNOUSERSITE=y \
           INSTALL_ENV_DIR="$ED_DIR/installer_files/env" PIP_NO_CACHE_DIR=1 \
 && python -m pip install torch torchvision --index-url "$TORCH_INDEX_URL" \
 && python scripts/ensure_torchruntime.py \
 # Easy Diffusion's package check can need more than one pass before every pinned version
 # sticks; repeat it until a pass installs nothing, so startup doesn't reinstall packages.
 && for pass in 1 2 3 4; do \
      python scripts/check_modules.py > /tmp/check_modules.log 2>&1 || { cat /tmp/check_modules.log; exit 1; }; \
      grep -E '^> ' /tmp/check_modules.log || break; \
      echo "package check pass $pass installed packages, running again"; \
    done \
 && tail -8 /tmp/check_modules.log && rm -f /tmp/check_modules.log \
 # Fail the build if the CPU-only PyTorch build ended up installed
 && python -c "import torch, sys; print('torch', torch.__version__, 'cuda', torch.version.cuda); sys.exit(0 if torch.version.cuda else 1)" \
 # 5. Clean up caches
 && rm -rf installer_files/mamba/pkgs "$HOME/.cache" sd-ui-files/.git \
 && conda clean -afy > /dev/null

COPY --chown=ed:ed --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

# The entrypoint starts as root only to fix permissions on /data (e.g. a mounted persistent
# volume), then drops to the "ed" user.
USER root
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
