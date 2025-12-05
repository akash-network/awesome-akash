# Bancor V3

[Bancor](https://app.bancor.network/) is a decentralized network of on-chain automated market makers (AMMs) supporting instant, low-cost trading, as well as Single-Sided Liquidity Provision and Liquidity Protection for any listed token.

## Deploying a React app
This template allows you to deploy an app from [bancorprotocol/webapp-v3](https://github.com/bancorprotocol/webapp-v3) repository on Akash Network.
Image in [deploy.yaml](deploy.yaml) deploys React app via `yarn start`. Docker image built with [Dockerfile_react](Dockerfile_react) file. Variables are set using ENV in [deploy.yaml](deploy.yaml). Image takes up about 730 MB of space.

## Deploying a static website
You can create your own static website from a React app and serve it as an image on Akash. This way, image will take up less than 30 MB of disk space.
To do this, use this [Dockerfile_static](Dockerfile_static) file and configure necessary APIs in ENV. If Alchemy API key is not specified, default value will be [_gg7wSSi0KMBsdKnGVfHDueq6xMB9EkC](https://eth-mainnet.alchemyapi.io/v2/_gg7wSSi0KMBsdKnGVfHDueq6xMB9EkC), as a result web app will not work as intended. Now let's build your Docker image:
```
docker build -t username/bancor-webapp-v3:0.0.1 .
docker push username/bancor-webapp-v3:0.0.1
```
Then use your image in this [deploy_static.yaml](deploy_static.yaml) file.
