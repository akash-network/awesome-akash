# Grok-1

**Please be aware of potential costs when deploying this.**

This deployment sets up all dependencies for [grok-1](https://github.com/xai-org/grok-1), downloads the weights, and runs the model.

Weights are ~296GB in size and take ~10h+ to download via torrent (aria2c).
Due to DockerHub limitations in dockerfile layer size, we cannot build the weights into the image and must do this at entrypoint.sh.

Model is 314B int8 params, so 314GB of mem is required to load the model.

Approximately 630GB of VRAM is required to run the model, this is equivalent to ~8 H100s (80GB).

# License

The code and associated Grok-1 weights in this release are licensed under the
Apache 2.0 license. The license only applies to the source files in this
repository and the model weights of Grok-1.