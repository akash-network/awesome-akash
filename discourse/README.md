# Discourse on Akash

This guide is intended to describe the process to run Discourse Multi-Tiered application on Akash Network.

## About Akash

Akash Network, the world’s first decentralized and open-source cloud, accelerates deployment, scale, efficiency and price performance for high-growth industries like blockchain and machine learning/AI.

Akash means "open space" or "sky" in ancient Sanskrit.

https://akash.network/

## Firsts steps on Akash

Read the docs: https://docs.akash.network/ 

Setup your wallet: https://docs.akash.network/token/keplr

Step by step guides to Akash:

- Desktop App (Cloudmos): https://docs.akash.network/guides/deploy
- Web App: https://docs.akash.network/guides/web 
- CLI: https://docs.akash.network/guides/cli

## About Discourse

Discourse is the 100% open source discussion platform built for the next decade of the Internet. Use it as a mailing list, discussion forum, long-form chat room, and more! 

https://www.discourse.org/


## Discourse on Akash in a Nutshell

The provided SDL deploy a Multi-Tiered application with 4 services/containers:

### Backend

- PostgreSQL
- Redis
- Sidekiq discourse

### Frontend

- Discourse


All you need to run your own Discourse services in Akash Network is deploy the SDL: [``deploy.yml``](./deploy.yml) script on Mainnet using your preferred "Step by step guides to Akash" mentioned above. 

Additionally this guide show how to using [Cloudmos](https://docs.akash.network/guides/deploy):

1. Download [Cloudmos](https://cloudmos.io/cloud-deploy) for your platform.
2. Execute the installer and setup your wallet in Cloudmos, you will need your mnemonic (setup a new wallet is recommended).
3. [Fund your wallet](https://docs.akash.network/guides/cli#part-3.-fund-your-account) (at least 6 AKT)
4. If you want, customize the SDL [deploy.yml](deploy.yml)
4. Deploy the SDL file Cloudmos (video):

[![Discourse on Akash Network](https://img.youtube.com/vi/XFweRMMZ10s/0.jpg)](https://youtu.be/XFweRMMZ10s)

**Note:** the process is the same if you use https://akashdeploy.hns.siasky.net/ to deploy your SDL.

### Security issues

#### Content Security Policy

Discourse need deploy over HTTPS otherwise could get a browser block for Content Security Policy issues [this guide](https://teeyeeyang.medium.com/how-to-use-a-custom-domain-with-your-akash-deployment-5916585734a2) written by Tee Yee Yang show how to do that.

To get past this and test your deployment, change your browser settings and temporarily disable CSP, in Firefox based browsers the steps are:

- Put _about:config_ as URL and press enter
- Confirm you know what are you doing
- Search `security.csp.enable` and clic to disable
- Test Discourse on Akash
- Enable `security.csp.enable` policy

#### Set `ALLOW_EMPTY_PASSWORD` to NO in production environment

Follow the comments in SDL file to enable passwords

```yml
      - ALLOW_EMPTY_PASSWORD=yes
      - POSTGRESQL_USERNAME=akt_discourse
      - POSTGRESQL_DATABASE=akash_discourse
      ## Set if ALLOW_EMPTY_PASSWORD=no
      #- POSTGRESQL_PASSWORD=changeme 
      #- POSTGRESQL_POSTGRES_PASSWORD=changeme
```

## Costs

The costs depends on capacity described in section `profiles.compute` in [deploy.yml](deploy.yml) file. 

With the default setting this deployment aprox. cost 6 AKT per month (someting like $14).

## Disclaimer

Taken from [Cloudmos website](https://cloudmos.io/cloud-deploy):

- Cloudmos Deploy is currently in BETA. We strongly suggest you start with a new wallet and a small amount of AKT until we further stabilize the product.
- We're not responsible for any loss or damages related to using the app.
- The app has a high chance of containing bugs since it's in BETA, use at your own risk.

