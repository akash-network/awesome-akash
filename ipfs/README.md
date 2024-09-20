# IPFS - InterPlanetary File System
The InterPlanetary File System (IPFS) is a protocol and peer-to-peer network for storing and sharing data in a distributed file system. IPFS uses content-addressing to uniquely identify each file in a global namespace connecting all computing devices. 
(Source: [Wikipedia](https://en.wikipedia.org/wiki/InterPlanetary_File_System))


## Setup
After deploying the IPFS WebUI will be available at assigned provider ingress URL. For the WebUI to work, you will need to update the deployment and set this URL in `IPFS_EXTERNAL_ADDR` (without trailing slash). 

The IPFS node API is secured by nginx reverse proxy with basic auth - you can modify the user and password in the deployment via nginx service environment variables.

IPFS Gateway is also available on the external address - simply use `${IPFS_EXTERNAL_ADDR}/ipfs/${CID}`.

> NOTE: IPFS Kubo node requires HTTPS, so make sure your provider provides HTTPS for the ingress URL (e.g. [Europlots](https://console.akash.network/providers/akash18ga02jzaq8cw52anyhzkwta5wygufgu6zsz6xc?network=mainnet))