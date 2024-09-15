# Serge - LLaMA made easy 🦙

![License](https://img.shields.io/github/license/serge-chat/serge)
[![Discord](https://img.shields.io/discord/1088427963801948201?label=Discord)](https://discord.gg/62Hc6FEYQH)

Serge is a chat interface crafted with [llama.cpp](https://github.com/ggerganov/llama.cpp) for running GGUF models. No API keys, entirely self-hosted!

- 🌐 **SvelteKit** frontend
- 💾 **[Redis](https://github.com/redis/redis)** for storing chat history & parameters
- ⚙️ **FastAPI + LangChain** for the API, wrapping calls to [llama.cpp](https://github.com/ggerganov/llama.cpp) using the [python bindings](https://github.com/abetlen/llama-cpp-python)

### 🌍 Environment Variables

The following Environment Variables are available:

| Variable Name         | Description                                             | Default Value                        |
|-----------------------|---------------------------------------------------------|--------------------------------------|
| `SERGE_DATABASE_URL`  | Database connection string                              | `sqlite:////data/db/sql_app.db`      |
| `SERGE_JWT_SECRET`    | Key for auth token encryption. Use a random string      | `uF7FGN5uzfGdFiPzR`                   |
| `SERGE_SESSION_EXPIRY`| Duration in minutes before a user must reauthenticate   | `60`                                 |
| `NODE_ENV`            | Node.js running environment                   | `production`                        |

## 🖥️ Windows

Ensure you have Docker Desktop installed, WSL2 configured, and enough free RAM to run models.

## ☁️ Kubernetes

Instructions for setting up Serge on Kubernetes can be found in the [wiki](https://github.com/serge-chat/serge/wiki/Integrating-Serge-in-your-orchestration#kubernetes-example).

## 🧠 Supported Models

| Category      | Models |
|:-------------:|:-------|
| **Alfred** | 40B-1023 |
| **BioMistral** | 7B |
| **Code** | 13B, 33B |
| **CodeLLaMA** | 7B, 7B-Instruct, 7B-Python, 13B, 13B-Instruct, 13B-Python, 34B, 34B-Instruct, 34B-Python |
| **Codestral** | 22B v0.1 |
| **Gemma** | 2B, 1.1-2B-Instruct, 7B, 1.1-7B-Instruct |
| **Gorilla** | Falcon-7B-HF-v0, 7B-HF-v1, Openfunctions-v1, Openfunctions-v2 |
| **Falcon** | 7B, 7B-Instruct, 40B, 40B-Instruct |
| **LLaMA 2** | 7B, 7B-Chat, 7B-Coder, 13B, 13B-Chat, 70B, 70B-Chat, 70B-OASST |
| **LLaMA 3** | 11B-Instruct, 13B-Instruct, 16B-Instruct |
| **LLaMA Pro** | 8B, 8B-Instruct |
| **Med42** | 70B |
| **Medalpaca** | 13B |
| **Medicine** | Chat, LLM |
| **Meditron** | 7B, 7B-Chat, 70B |
| **Meta-LlaMA-3** | 8B, 8B-Instruct, 70B, 70B-Instruct |
| **Mistral** | 7B-V0.1, 7B-Instruct-v0.2, 7B-OpenOrca |
| **MistralLite** | 7B |
| **Mixtral** | 8x7B-v0.1, 8x7B-Dolphin-2.7, 8x7B-Instruct-v0.1 |
| **Neural-Chat** | 7B-v3.3 | 
| **Notus** | 7B-v1 |
| **Notux** | 8x7b-v1 |
| **Nous-Hermes 2** | Mistral-7B-DPO, Mixtral-8x7B-DPO, Mistral-8x7B-SFT |
| **OpenChat** | 7B-v3.5-1210 |
| **OpenCodeInterpreter** | DS-6.7B, DS-33B, CL-7B, CL-13B, CL-70B |
| **OpenLLaMA** | 3B-v2, 7B-v2, 13B-v2 |
| **Orca 2** | 7B, 13B |
| **Phi 2** | 2.7B |
| **Phi 3** | mini-4k-instruct, medium-4k-instruct, medium-128k-instruct |
| **Python Code** | 13B, 33B |
| **PsyMedRP** | 13B-v1, 20B-v1 |
| **Starling LM** | 7B-Alpha |
| **SOLAR** | 10.7B-v1.0, 10.7B-instruct-v1.0 |
| **TinyLlama** | 1.1B |
| **Vicuna** | 7B-v1.5, 13B-v1.5, 33B-v1.3, 33B-Coder |
| **WizardLM** | 2-7B, 13B-v1.2, 70B-v1.0 |
| **Zephyr** | 3B, 7B-Alpha, 7B-Beta |

Additional models can be requested by opening a GitHub issue. Other models are also available at [Serge Models](https://github.com/Smartappli/serge-models).

## ⚠️ Memory Usage

LLaMA will crash if you don't have enough available memory for the model

## 💬 Support

Need help? Join our [Discord](https://discord.gg/62Hc6FEYQH)

## 🧾 License

[Nathan Sarrazin](https://github.com/nsarrazin) and [Contributors](https://github.com/serge-chat/serge/graphs/contributors). `Serge` is free and open-source software licensed under the [MIT License](https://github.com/serge-chat/serge/blob/main/LICENSE-MIT) and [Apache-2.0](https://github.com/serge-chat/serge/blob/main/LICENSE-APACHE).

## 🤝 Contributing

If you discover a bug or have a feature idea, feel free to open an issue or PR.

To run Serge in development mode:
```bash
git clone https://github.com/serge-chat/serge.git
cd serge/
docker compose -f docker-compose.dev.yml up --build
```

The solution will accept a python debugger session on port 5678. Example launch.json for VSCode:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Remote Debug",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 5678
            },
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}/api",
                    "remoteRoot": "/usr/src/app/api/"
                }
            ],
            "justMyCode": false
        }
    ]
}
```
