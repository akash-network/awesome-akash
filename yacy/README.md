[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-yacy)

YaCy Search Engine Software
===========================

YaCy is a distributed Web Search Engine, based on a peer-to-peer network.

Homepage: [YaCy.net](https://yacy.net)

Using This SDL
--------------

- HTTP port 8090 must be exposed globally as port 80 (or YaCy will refuse to crawl without any error). Exposing HTTPS port 8443 is not required.
- Enabling persistent storage feature in SDL is highly recommended. Some settings in YaCy requires a server restart and it will reset all of your data.
- Default username and password to access administrative features is `admin` and `yacy`.
