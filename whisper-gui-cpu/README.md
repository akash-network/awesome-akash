# whisper-gui

**whisper-gui - A simple GUI made with gradio to use Whisper from https://github.com/Pikurrot/whisper-gui**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/whisper-gui)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/whisper-gui)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/whisper-gui)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/whisper-gui.yml?branch=main)

## Index

1. [Usage](#usage)  
   1.1 [docker run](#dockerrun)  
   1.2 [docker-compose.yaml](#docker-compose)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

```shell
docker run -d \
    --name whisper-gui \
    -v /path/of/some/files:/whisper-gui/outputs \
    -p 7860:7860/tcp \
    3x3cut0r/whisper-gui:latest
```

### 1.2 docker-compose.yml <a name="docker-compose"></a>

```shell
version: '3.9'

# https://github.com/Pikurrot/whisper-gui
services:
  # https://hub.docker.com/r/3x3cut0r/whisper-gui
  whisper-gui:
    container_name: whisper-gui
    image: 3x3cut0r/whisper-gui:latest
    restart: unless-stopped
    ports:
      - '7860:7860'
    volumes:
      - whisper-gui-data:/whisper-gui/outputs

volumes:
  whisper-gui-data:
    name: whisper-gui-data

```

### 2 Environment Variables <a name="environment-variables"></a>

- `TZ` - Specifies the server timezone - **Default: UTC**
- `LANGUAGE` - Specifies the language of the UI. See [lang.json](https://github.com/Pikurrot/whisper-gui/blob/master/configs/lang.json) for supported languages- **Default: en**

### 3 Volumes <a name="volumes"></a>

- `/whisper-gui/outputs` - output directory

### 4 Ports <a name="ports"></a>

- `7860` - Gradio Port for the Webinterface

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/mit) - This project is licensed under the MIT License - see the [MIT License](https://opensource.org/license/mit) for details.
``
