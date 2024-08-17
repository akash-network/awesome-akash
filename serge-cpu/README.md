# Serge - LLaMA made easy 🦙

A chat interface based on [llama.cpp](https://github.com/ggerganov/llama.cpp) for running Alpaca models. Entirely self-hosted, no API keys needed. Fits on 4GB of RAM and runs on the CPU.

- **SvelteKit** frontend
- **Redis** for storing chat history & parameters
- **FastAPI + langchain** for the API, wrapping calls to [llama.cpp](https://github.com/ggerganov/llama.cpp) using the [python bindings](https://github.com/abetlen/llama-cpp-python)

[demo.webm](https://user-images.githubusercontent.com/25119303/226897188-914a6662-8c26-472c-96bd-f51fc020abf6.webm)

## Getting started

Deploy and click the URI in Akash Console.

The API documentation can be found at http://localhost:8008/api/docs

## Models

Currently the following models are supported:

- GPT4-Alpaca-LoRA-30B
- Alpaca-LoRA-65B
- OpenAssistant-30B
- GPT4All-13B
- Stable-Vicuna-13B
- Guanaco-7B
- Guanaco-13B
- Guanaco-33B
- Guanaco-65B

If you have existing weights from another project you can add them to the `serge_weights` volume using `docker cp`.

### :warning: A note on _memory usage_

LLaMA will just crash if you don't have enough available memory for your model.

- 7B requires about 4.5GB of free RAM
- 13B requires about 12GB free
- 30B requires about 20GB free


## Support

Feel free to join the discord if you need help with the setup: https://discord.gg/62Hc6FEYQH

## Contributing

Serge is always open for contributions! If you catch a bug or have a feature idea, feel free to open an issue or a PR.

## What's next

- [x] Front-end to interface with the API
- [x] Pass model parameters when creating a chat
- [x] Manager for model files
- [ ] Support for other models
- [ ] LangChain integration
- [ ] User profiles & authentication

And a lot more!
