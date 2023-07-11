# Synthetix.Exchange

The code for the [Synthetix.Exchange](https://synthetix.exchange) dApp.<br />
It is powered by [synthetix-data](https://github.com/Synthetixio/synthetix-data) and [synthetix-js](https://github.com/Synthetixio/synthetix-js).

# Instructions

First of all you need to create docker image and push it to docker hub.

1. Build the project
    * `npm i`
    * `npm run build`
2. Make a container and an image based on `nginx:stable-alpine`
3. Push to the docker hub
4. Modify `deploy.yaml` to use your image
