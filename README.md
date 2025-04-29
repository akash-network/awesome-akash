# Awesome Akash <!-- omit in toc -->

Awesome Akash is a curated list of awesome resources people can use to familiarize themselves with [Akash](https://akash.network) and includes examples of several applications they can deploy on the platform. Please submit a pull request if you know any resources that might be helpful to other developers.

Instructions on how to deploy the SDL files in this repository can be found [here](https://akash.network/docs/deployments/overview/).

Join our [Discord](https://discord.akash.network) if you have questions or concerns. Our team is always eager to hear from you.
Also, follow [@akashnet\_](https://twitter.com/akashnet_) to stay in the loop with updates and announcements.

## How to add a template to the console api <!-- omit in toc -->

1. Create a new folder in the root directory with the name of the template.
2. Add the `deploy.yaml` file to the folder.
3. Add the `README.md` file to the folder.
4. (Optional) There's a `config.json` file that you can add to the template folder to add a custom config for the template, like a logo url. It follows the same schema as the [config.schema.json](config.schema.json) file. (ex. [DeepSeek config](DeepSeek-R1/config.json)).
5. Add the name of the template with the name of the template that will be displayed in the console api and name of the template folder under the [Table of Contents](#table-of-contents) section in the appropriate category. (ex. `[DeepSeek-R1](#DeepSeek-R1)`)
6. Done! There's a 5 minutes cache time for the console api to update.

## Table of Contents <!-- omit in toc -->

- [Official](#official)
- [AI - CPU](#ai---cpu)
- [AI - GPU](#ai---gpu)
- [Blogging](#blogging)
- [Built with Cosmos-SDK](#built-with-cosmos-sdk)
- [Chat](#chat)
- [Machine Learning](#machine-learning)
- [CI/CD, DevOps](#cicd-devops)
- [Data Visualization](#data-visualization)
- [Databases and Administration](#databases-and-administration)
- [DeFi](#defi)
- [Benchmarking](#benchmarking)
- [Blockchain](#blockchain)
- [Business](#business)
- [Games](#games)
- [Game Servers](#game-servers)
- [Hosting](#hosting)
- [Media](#media)
- [Search Engines](#search-engines)
- [Mining - CPU](#mining---cpu)
- [Mining - GPU](#mining---gpu)
- [Mining Pools](#mining-pools)
- [Peer-to-peer File Sharing](#peer-to-peer-file-sharing)
- [Project Management](#project-management)
- [Social](#social)
- [Tools](#tools)
- [Network](#network)
- [Databases](#databases)
- [Video Conferencing](#video-conferencing)
- [Wallet](#wallet)
- [Web Frameworks](#web-frameworks)

### Official

- [Lunie Wallet for Cosmos SDK](lunie-lite)
- [Cosmos SDK Node](https://github.com/ovrclk/akash-on-akash)
- [Ubuntu SSH](ssh-ubuntu)

### AI - CPU

- [Alpaca.cpp](alpaca-cpp)
- [Auto-GPT](auto-gpt)
- [BabyAGI](babyagi)
- [BabyAGI-UI](babyagi-ui)
- [Bark small](bark-small)
- [Botpress](botpress)
- [ChatChat](chatchat)
- [Daila](daila)
- [Faster Whisper](fast-whisper-cpu)
- [Flowise](flowise)
- [Eliza AI Agent](elizaos-ai_Agents)
- [InvokeAI](invoke-ai-cpu)
- [Langflow](langflow)
- [Morpheus Lumerin Node](morpheus-lumerin-node)
- [Ollama](ollama-cpu)
- [Open WebUI](open-webui-cpu)
- [PrivateGPT](privategpt-cpu)
- [Serge](serge-cpu)
- [Stable Diffusion](stable-diffusion-ui)
- [Terminal GPT](tgpt)
- [Venice-ElizaOS](Venice-ElizaOS)
- [Weaviate](weaviate)
- [Whisper ASR](whisper-asr-cpu)
- [Whisper GUI](whisper-gui-cpu)

### AI - GPU

- [AI-Image-App](AI-Image-App)
- [AUTOMATIC1111](AUTOMATIC1111)
- [BERT](bert)
- [BERT Sentiment Analysis](bert-sentiment-analysis)
- [ChatGLM-6B](ChatGLM-6B)
- [ComfyUI](comfyui)
- [DeepSeek-Janus](DeepSeek-Janus)
- [DeepSeek-R1](DeepSeek-R1)
- [DeepSeek-R1-Distill-Qwen-7B](DeepSeek-R1-Distill-Qwen-7B)
- [DeepSeek-R1-Distill-Qwen-1.5B](DeepSeek-R1-Distill-Qwen-1.5B)
- [DeepSeek-R1-Distill-Qwen-14B](DeepSeek-R1-Distill-Qwen-14B)
- [DeepSeek-R1-Distill-Qwen-32B](DeepSeek-R1-Distill-Qwen-32B)
- [DeepSeek-R1-Distill-Llama-70B](DeepSeek-R1-Distill-Llama-70B)
- [DeepSeek-R1-Distill-Llama-8B](DeepSeek-R1-Distill-Llama-8B)
- [Dria](dria)
- [Dolly-v2-12b](dolly-v2-12b)
- [Falcon-7B](Falcon-7B)
- [FastChat](FastChat)
- [Faster Whisper](fast-whisper-gpu)
- [Flan-T5 XXL](flan-t5-xxl)
- [FLock Validator](FLock-validator)
- [FLock-Training-Node](FLock-training-node)
- [Foundry-RIT AI Training Model Challenge](Foundry-rit-ai-training-model-challenge)
- [GPT-Neo](gpt-neo)
- [GPUStack](gpustack)
- [GPUStack Worker](gpustack-worker)
- [Grok](grok)
- [InvokeAI](invoke-ai-gpu)
- [Llama-2-70B](Llama-2-70B)
- [Llama-3.1-Nemotron-Super-49B-v1](Llama-3.1-Nemotron-Super-49B-v1)
- [Llama-3-8B](Llama-3-8B)
- [Llama-3-Groq-8B-Tool-Use](Llama-3-Groq-8B-Tool-Use)
- [Llama-3-70B](Llama-3-70B)
- [Llama-3.1-8B](Llama-3.1-8B)
- [Llama-3.1-405B-AWQ-INT4](Llama-3.1-405B-AWQ-INT4)
- [Llama-3.1-405B-BF16](Llama-3.1-405B-BF16)
- [Llama-3.1-405B-FP8](Llama-3.1-405B-FP8)
- [Llama-3.2-3B](Llama-3.2-3B)
- [Llama-3.2-11B-Vision-Instruct](Llama-3.2-11B-Vision-Instruct)
- [Llama-3.2-90B-Vision-Instruct](Llama-3.2-90B-Vision-Instruct)
- [Llama-3.3-70B](Llama-3.3-70B)
- [Llama-4-Maverick-17B-128E-Instruct-FP8](Llama-4-Maverick-17B-128E-Instruct-FP8)
- [Llama-4-Scout-17B-16E-Instruct](Llama-4-Scout-17B-16E-Instruct)
- [Mistral-7B](Mistral-7B)
- [Ollama](ollama-gpu)
- [Open GPT](open-gpt)
- [Open WebUI](open-webui-gpu)
- [PrivateGPT](privategpt-gpu)
- [Qwen-QwQ-32B](QwQ-32B)
- [Qwen3-235B-A22B-FP8](Qwen3-235B-A22B-FP8)
- [RedPajama-INCITE-7B-Instruct](redpajama-incite-7b-instruct)
- [Semantra](semantra)
- [Serge](serge-gpu)
- [Stable Diffusion](stable-diffusion-ui)
- [Stable Diffusion Webui](stable-diffusion-webui)
- [StableStudio](StableStudio)
- [StableSwarmUI](stableswarmui)
- [Text generation WebUi](text-generation-webui)
- [TTS](TTS)
- [vllm](vllm)
- [Whisper ASR](whisper-asr-gpu)
- [Whisper GUI](whisper-gui-gpu)
- [XLM-roBERTa](XLM-roBERTa)

### Blogging

- [SteemCN](steemcn)
- [Ghost](ghost)
- [Grav](Grav)
- [Wordpress](wordpress)
- [Confluence](confluence)
- [Drupal](drupal)
- [Wiki.js](wikijs)
- [Nitropage](nitropage)

### Built with Cosmos-SDK

- [Dharani](Dharani)
- [Big Dipper](big-dipper)

### Chat

- [Mattermost](mattermost)
- [Status](status)

### Machine Learning

- [Ray Cluster](ray)
- [Jupyter Notebook](jupyter)
- [Jupyter Notebook with ezkl](tensorflow-jupyter-ezkl)
- [Jupyter Notebook with Python Kernel](tensorflow-jupyter-mnist)
- [TensorFlow Serving MNIST CNN Model](tensorflow-serving-mnist)
- [Handwritten Digits Recognition Application](tensorflow-webapp-mnist)
- [Doccano](doccano)

### CI/CD, DevOps

- [Jenkins](jenkins)
- [Bitbucket](bitbucket)
- [Azure Devops Agent](azure-devops-agent)
- [Github Runner](ghrunner)
- [Radicle](radicle)
- [Automatic Deployment and CICD Template](automatic-deployment-CICD-template)

### Data Visualization

- [Redash Data Charts for Akash Analytics](Redash)
- [UFO Sightings](ufo-data-vis)

### Databases and Administration

- [json-server](json-server)
- [pgAdmin](pgadmin4)
- [mongoDB](mongoDB)
- [postgresSQL](postgres)
- [adminer](adminer)
- [MySQL](MySQL)
- [CouchDB](couchdb)
- [InfluxDB](influxdb)
- [SurrealDB](SurrealDB)
- [DefraDB](defradb)

### DeFi

Awesome DeFi apps you can deploy on Akash

- [Serum DEX UI](serum)
- [Uniswap](uniswap)
- [dFed](dfed)
- [Pancake Swap](pancake-swap)
- [Augur](augur)
- [Bancor](bancor)
- [Balancer](balancer)
- [Luaswap](luaswap)
- [SushiSwap](sushiswap)
- [Uma Protocol](uma-protocol)
- [Yearn.finance](Yearn.finance)
- [ThorChain BEPSwap](Thorchain-BEPSwap)
- [Curve](curve)
- [Synthetix.Exchange](synthetix.exchange)
- [Ren Protocol](renprotocol)
- [yfii](yfii)
- [Sifchain DEX](sifchain-ui)
- [Osmosis DEX](osmosis-fe)

### Benchmarking

- [Fast.com by Netflix](fast)
- [Flexible IO Tester](fio)
- [Geekbench 5](geekbench)
- [LibreSpeed](librespeed)
- [MonkeyTest](monkeytest)
- [OpenSpeedTest](openspeedtest)
- [Phoronix](phoronix)
- [Serverbench](serverbench)
- [Speedtest by Ookla](speedtest-cli)
- [Speedtest Tracker](speedtest-tracker)
- [Persistent Storage benchmarking tool](persistent-storage-performance-testing)

### Blockchain

- [Bitcoin](bitcoin)
- [Prysm Beacon](prysm-beacon)
- [Substrate Node](substrate-node)
- [Near Node](near)
- [Vidulum](vidulum)
- [Ethereum 2.0](Ethereum_2.0)
- [POKT Network](pokt-network)
- [Polkadot](polkadot)
- [Kadena](Kadena)
- [Bitcoin Cash Node](bitcoincashnode)
- [Handshake](handshake)
- [Fuse Network Node](fuse-network-node)
- [Injective](injective)
- [Starknet Node by Juno](juno)
- [Witness Chain Watchtower](witnesschain-watchtower)
- [Concordium node](concordium)

### Business

- [Odoo](odoo)
- [RAIR-Dapp](RAIR-Dapp)

### Games

- [Minecraft](minecraft)
- [Tetris](tetris)
- [Pac-Man](pacman)
- [Supermario](supermario)
- [Minesweeper](minesweeper)
- [Tetris2](tetris2)
- [MemoryGame](MemoryGame)
- [Snake Game](snake-game)

### Game Servers

- [Counter-Strike: Global Offensive](csgo)
- [Holdfast: Nations At War](holdfastnaw)
- [Mordhau](mordhau)
- [Squad](squad)
- [SteamCMD](steamcmd)
- [SteamPipe](steampipe)
- [Team Fortress 2](tf2)

### Hosting

- [Caddy](caddy)
- [Flame](flame)
- [Grafana](grafana)
- [Nginx Let's Encrypt Proxy](nginx-letsencrypt-proxy)

### Media

- [FreeFlix Nucleus](freeflix-nucleus)

### Search Engines

- [Whoogle Search](whoogle-search)
- [Presearch](presearch)
- [YaCy](yacy)

### Mining - CPU

- [Chia Bladebit](chia-bladebit)
- [Chia Bladebit Disk](chia-bladebit-disk)
- [Chia Madmax](chia-madmax)
- [Honeygain](honeygain)
- [IPRoyal Pawns](iproyal-pawns)
- [Iron Fish](iron-fish)
- [MoneroOcean CPU with XMR payout](moneroocean)
- [PacketStream](packetstream)
- [pkt.cash](pkt-miner)
- [RainbowMiner CPU](rainbowminer)
- [Raptoreum](raptoreum-miner)
- [Traffmonetizer](traffmonetizer)
- [XMRig CPU](xmrig)

### Mining - GPU

- [Bminer](bminer-c11)
- [BzMiner](bzminer-c11)
- [CryptoDredge](cryptodredge-c11)
- [GMiner](gminer-c11)
- [lolMiner](lolminer-c11)
- [MoneroOcean GPU with XMR payout](xmrig-moneroocean-c11)
- [Nanominer](nanominer-c11)
- [NBMiner](nbminer-c11)
- [OneZeroMiner](onezerominer-c11)
- [Quai Network](quai-gpu-miner)
- [RainbowMiner GPU](rainbowminer-c11)
- [Rigel](rigel-c11)
- [SRBMiner-MULTI](srbminer-multi-c11)
- [T-Rex](t-rex-c11)
- [WildRig Multi](wildrig-multi-c11)
- [XMRig GPU](xmrig-c11)

### Mining Pools

- [monero-pool by jtgrassie](monero-pool)
- [Meowcoin Pool](kawpow-pool-meowcoin)
- [Neoxa Pool](kawpow-pool-neoxa)
- [Ravencoin Pool](kawpow-pool-ravencoin)

### Peer-to-peer File Sharing

- [qBittorrent](qbittorrent)

### Project Management

- [Jira Software](jira)
- [Redmine](redmine)
- [Kanboard](kanboard)

### Social

- [Discourse](discourse)
- [TeamSpeak](teamspeak)
- [Waku](waku)

### Decentralized Storage

- [Codex](codex)
- [IPFS](ipfs)

### Tools

- [thirdweb](thirdweb)
- [authsteem](authsteem)
- [Code-Server](code-server)
- [CodiMD](CodiMD)
- [dart-hello](dart)
- [DEGO Stats](dego-stats)
- [Folding@home](folding-at-home)
- [Hashicorp Vault](hashicorp-vault)
- [KnowYourDeFi](knowyourdefi)
- [Matomo](matomo)
- [microbox](microbox)
- [Mintr](mintr)
- [Nextcloud](nextcloud)
- [owncloud](owncloud)
- [PeerJS Server](peerjs-server)
- [Periodic Table Creator](Periodic-Table-Creator)
- [Quill editor](quill-editor)
- [Uptime Kuma](uptime-kuma)
- [Webtop](webtop)
- [Zammad](zammad)
- [Budibase](budibase)
- [Keycloak IAM](keycloak-iam)
- [vaultwarden](vaultwarden)

### Network

- [SoftEther VPN](softether-vpn)
- [Sentinel dVPN node](Sentinel-dVPN-node)
- [V2RAY](v2ray)
- [X-UI](x-ui)
- [Tor Proxy](tor-proxy)
- [CJDNS PKT](cjdns-pkt)

### Databases

- [redis](redis)

### Video Conferencing

- Your project can be the first!

### Wallet

- [MyetherWallet](MyetherWallet)
- [tronwallet](tronwallet)

### Web Frameworks

- [NextJS](nextjs)
