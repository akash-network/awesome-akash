Insanely Fast Whisper CLI + API
----
A CLI for blazingly fast on-device transcription with OpenAI's Whisper Large v3 and Distil models

⚡️ Transcribe 150 minutes of audio in under 2 minutes—no cloud, no latency, just raw speed.

🚀 Key Features
Ultra-fast transcription via optimized Whisper models (Large v3, Distil-large v2)
Flash Attention 2 support for reduced inference time
Batched processing to maximize throughput
Speaker diarization with PyAnnote integration
Language auto-detection or manual override
Word/chunk-level timestamps for precise output
🤖 CLI Usage
The CLI is designed to work seamlessly with NVIDIA GPUs or Macs (with MPS support). Here’s how to use it:

Basic Command

bash
insanely-fast-whisper --file-name <filename_or_url>  
Replace <filename_or_url> with your audio file path or URL.

Advanced Options
Enable Flash Attention 2:

bash
insanely-fast-whisper --file-name <filename_or_url> --flash True  
Use Distil-Whisper:

bash
insanely-fast-whisper --model-name distil-whisper/large-v2 --file-name <filename_or_url>  
Specify device (Mac only):

bash
insanely-fast-whisper --file-name <filename_or_url> --device-id mps  
🌐 Akash Network Integration
This project is deployed via the Akash Network for scalable, decentralized inference.

CLI Access: Use the provided shell in the Akash console to run transcription commands directly.
API Access: Interact with the service through a dedicated URL endpoint (no need to install anything locally).
📌 Notes
The CLI is opinionated and requires compatible hardware (NVIDIA GPU or Apple Silicon with MPS).
Default settings are optimized for performance, but you can tweak parameters like --batch-size, --device-id, and --flash for custom workflows.
Speaker diarization options (--num-speakers, --min-speakers, --max-speakers) are available for multi-voice analysis.
🧠 Community-Driven
Originally built to showcase model optimizations, this CLI now evolves based on user demand. Contributions and feature requests are welcome!

📚 CLI Help
Run insanely-fast-whisper --help to see all available options and defaults.

No installation required? Just use the Akash-deployed CLI or API!
