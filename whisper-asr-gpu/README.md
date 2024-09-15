# Whisper ASR Webservice

Whisper is a general-purpose speech recognition model. It is trained on a large dataset of diverse audio and is also a multitask model that can perform multilingual speech recognition as well as speech translation and language identification. For more details: [github.com/openai/whisper](https://github.com/openai/whisper/)

## Use Cases

- Transcription services for podcasts, videos, or audio files
- Voice command systems for applications
- Accessibility features in software products
- Research projects in natural language processing
- Real-time speech-to-text for live events or streaming


## Configuration Options

The template comes pre-configured, but you can adjust the following parameters:

- `ASR_MODEL`: Change the Whisper model size (e.g., "tiny", "base", "small", "medium", "large")
- `ASR_ENGINE`: Set to "openai_whisper" by default
- Compute resources: Adjust CPU, memory, and storage as needed

## Using the Deployed Service

Once deployed, you can interact with the ASR service using HTTP requests. Here's a basic example using curl:

```bash
curl -X POST "http://{AKASH_URI}/asr" \
     -H "Content-Type: multipart/form-data" \
     -F "audio_file=@path/to/your/audio/file.mp3"
```
## Features

Current release (v1.5.0) supports following whisper models:

- [openai/whisper](https://github.com/openai/whisper)@[v20231117](https://github.com/openai/whisper/releases/tag/v20231117)
- [SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper)@[v1.0.3](https://github.com/SYSTRAN/faster-whisper/releases/tag/1.0.3)

for more information:

- [Documentation/Run](https://ahmetoner.github.io/whisper-asr-webservice/run)
- [Docker Hub](https://hub.docker.com/r/onerahmet/openai-whisper-asr-webservice)

## Documentation

Explore the documentation by clicking [here](https://ahmetoner.github.io/whisper-asr-webservice).

## Credits

- This software uses libraries from the [FFmpeg](http://ffmpeg.org) project under the [LGPLv2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
