# Agent Zero

Agent Zero is a next-generation autonomous AI assistant framework that runs in its own virtual computer environment. It features dynamic tool creation, persistent memory, and multi-agent cooperation capabilities.

## Features

- Autonomous AI agent with code execution capabilities
- Runs in isolated Docker container with full Linux environment
- Web-based UI for interaction
- Multi-agent cooperation system
- Persistent memory across sessions
- Dynamic tool creation and adaptation
- No predefined limitations

## Deployment Instructions

1. Deploy the SDL file using Akash Console or CLI
2. Wait for deployment to complete
3. Access the web UI through the provided URI on port 80
4. Configure your AI model provider in Settings
   - OpenAI (recommended for best results)
   - Anthropic Claude
   - Local models via Ollama
5. Set authentication credentials in Settings for security

## Configuration

### Required Configuration

You must configure an AI model provider before Agent Zero will function:

- Go to Settings → Agent Settings
- Select your provider (OpenAI, Anthropic, or Ollama)
- Enter your API key or model configuration
- Save settings

### Recommended Configuration

- Enable authentication: Settings → Authentication
- Set UI login username and password
- Set root password for SSH access if needed

## Resource Requirements

- CPU: 1.0 units
- Memory: 2Gi
- Storage: 10Gi
- Port: 80 (HTTP web interface)

## Important Notes

- Initial container startup takes approximately 30-60 seconds
- Configure AI provider immediately after deployment
- Enable authentication if exposing to internet
- Data persists within container storage allocation
- Uses approximately 2GB for Docker image

## Links

- Official Website: https://agent-zero.ai
- GitHub Repository: https://github.com/agent0ai/agent-zero
- Docker Hub: https://hub.docker.com/r/agent0ai/agent-zero
- Documentation: https://agent-zero.ai/p/docs/get-started/

## Version

Current deployment version: v0.9.8

## Support

For Agent Zero specific issues, visit the GitHub repository or official Discord.
For Akash deployment issues, visit Akash Network Discord.
