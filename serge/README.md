# Serge - LLaMa made easy 🦙

A chat interface based on `llama.cpp` for running Alpaca models. Entirely self-hosted, no API keys needed. Fits on 4GB of RAM and runs on the CPU.

- **SvelteKit** frontend
- **MongoDB** for storing chat history & parameters
- **FastAPI + beanie** for the API, wrapping calls to `llama.cpp`

[View Demo](https://user-images.githubusercontent.com/25119303/226897188-914a6662-8c26-472c-96bd-f51fc020abf6.webm)

## Models

Currently only the 7B, 713B and 30B alpaca models are supported. If you have existing weights from another project you can add them to the `serge_weights` volume using `docker cp`.

### :warning: A note on _memory usage_

llama will just crash if you don't have enough available memory for your model.

- 7B requires about 4.5GB of free RAM
- 13B requires about 12GB free
- 30B requires about 20GB free

### Compatible CPUS
Currently Serge requires a CPU compatible with AVX2 instructions. Try `lscpu | grep avx2` in a shell, and if this returns nothing then your CPU is incompatible for now.

## Support

Feel free to join the discord if you need help with the setup: [Discord](https://discord.gg/62Hc6FEYQH)

## Contributing

Serge is always open for contributions! If you catch a bug or have a feature idea, feel free to open an issue or a PR.

If you want to run Serge in development mode (with hot-module reloading for svelte & autoreload for FastAPI) you can do so like this:

```
git clone https://github.com/nsarrazin/serge.git
DOCKER_BUILDKIT=1 docker compose -f docker-compose.dev.yml up -d --build
```

You can test the production image with

```
DOCKER_BUILDKIT=1 docker compose up -d --build
```

## What's next

- [x] Front-end to interface with the API
- [x] Pass model parameters when creating a chat
- [x] Manager for model files
- [ ] Support for other models
- [ ] LangChain integration
- [ ] User profiles & authentication

And a lot more!
