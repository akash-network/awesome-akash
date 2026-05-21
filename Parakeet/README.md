[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment)

# Parakeet Speech-to-Text on Akash

Deploy NVIDIA's Parakeet CTC 1.1B speech-to-text model on Akash Network's decentralized cloud. Fast, accurate transcription with GPU acceleration.

**Model**: [nvidia/parakeet-ctc-1.1b](https://huggingface.co/nvidia/parakeet-ctc-1.1b)

## Features

- Real-time audio transcription
- Batch processing support (configurable batch size)
- Optional API key authentication
- Flexible GPU options
- REST API on port 80

## Configuration

Key environment variables:
- `MODEL_NAME`: Model identifier (default: nvidia/parakeet-ctc-1.1b)
- `BATCH_SIZE`: Parallel processing batch size (default: 16)
- `API_KEY`: Optional authentication (leave unset for open access)

## Resources

- **CPU**: 6 units
- **Memory**: 16GB
- **Storage**: 50GB
- **GPU**: 1x NVIDIA

## Deployment

1. Click "Deploy on Akash" button
2. Copy the SDL configuration
3. Adjust GPU model if needed (uncomment preferred option)
4. Set `API_KEY` for production use
5. Deploy and access via provided endpoint
