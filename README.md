# Awesome Akash <!-- omit in toc -->

Awesome Akash is a curated list of awesome resources people can use to familiarize themselves with [Akash](https://akash.network) and includes examples of several applications they can deploy on the platform. Please submit a pull request if you know any resources that might be helpful to other developers.

Instructions on how to deploy the SDL files in this repository can be found [here](https://akash.network/docs/deployments/overview/).

Join our [Discord](https://discord.akash.network) if you have questions or concerns. Our team is always eager to hear from you.
Also, follow [@akashnet\_](https://twitter.com/akashnet_) to stay in the loop with updates and announcements.

## Contributing

See our [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on adding new templates and resources.

To add a new template/resource:

1. **Create a New Folder:**
   - Name your folder using lowercase, hyphen-separated naming (e.g., `my-template`).
   - Place it in the root directory.

2. **Required Files:**
   - `deploy.yaml` — Main deployment SDL.
   - `README.md` — Include instructions for setup, usage, and details about your template/resource.
   - *(Optional)* `config.json` — Custom configuration (e.g., logo). Must follow the schema in `config.schema.json`. See [DeepSeek-R1/config.json](DeepSeek-R1/config.json) for an example.

3. **Update Table of Contents:**
   - Add your template/resource in the appropriate category section in the Table of Contents below, maintaining alphabetical order within the category.
   - Use the format: `[Display Name](#folder-name)` where "folder-name" matches your actual folder name.
   - Note: The console API has a 5-minute cache, so changes may take up to 5 minutes to appear.

## Table of Contents <!-- omit in toc -->

- [AI - CPU](#ai---cpu)
- [AI - GPU](#ai---gpu)
- [Benchmarking](#benchmarking)
- [Blockchain](#blockchain)
- [Blogging](#blogging)
- [Built with Cosmos-SDK](#built-with-cosmos-sdk)
- [Business](#business)
- [CI/CD, DevOps](#cicd-devops)
- [Chat](#chat)
- [Data Visualization](#data-visualization)
- [Databases and Administration](#databases-and-administration)
- [Decentralized Storage](#decentralized-storage)
- [DeFi](#defi)
- [Game Servers](#game-servers)
- [Games](#games)
- [Hosting](#hosting)
- [Machine Learning](#machine-learning)
- [Media](#media)
- [Mining - CPU](#mining---cpu)
- [Mining - GPU](#mining---gpu)
- [Mining Pools](#mining-pools)
- [Network](#network)
- [Peer-to-peer File Sharing](#peer-to-peer-file-sharing)
- [Project Management](#project-management)
- [Search Engines](#search-engines)
- [Social](#social)
- [SSH](#ssh)
- [Tools](#tools)
- [Video Conferencing](#video-conferencing)
- [Wallet](#wallet)
- [Web Frameworks](#web-frameworks)

### AI - CPU

- [Alpaca.cpp](alpaca-cpp)
- [Auto-GPT](auto-gpt)
- [BabyAGI-UI](babyagi-ui)
- [BabyAGI](babyagi)
- [Bark small](bark-small)
- [Botpress](botpress)
- [ChatChat](chatchat)
- [Daila](daila)
- [Eliza AI Agent](Elizaos-ai_Agents)
- [Faster Whisper](faster-whisper-cpu)
- [Flowise](flowise)
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
- [Chromadb](chromadb)
- [Whisper ASR](whisper-asr-cpu)
- [Whisper GUI](whisper-gui-cpu)

### AI - GPU

- [AI-Image-App](AI-Image-App)
- [AUTOMATIC1111](AUTOMATIC1111)
- [Axolotl AI](axolotlai)
- [BERT Sentiment Analysis](bert-sentiment-analysis)
- [BERT](bert)
- [ChatGLM-6B](ChatGLM-6B)
- [ComfyUI](comfyui)
- [DeepSeek-Janus](DeepSeek-Janus)
- [DeepSeek-R1-0528](DeepSeek-R1-0528)
- [DeepSeek-R1-Distill-Llama-70B](DeepSeek-R1-Distill-Llama-70B)
- [DeepSeek-R1-Distill-Llama-8B](DeepSeek-R1-Distill-Llama-8B)
- [DeepSeek-R1-Distill-Qwen-1.5B](DeepSeek-R1-Distill-Qwen-1.5B)
- [DeepSeek-R1-Distill-Qwen-14B](DeepSeek-R1-Distill-Qwen-14B)
- [DeepSeek-R1-Distill-Qwen-32B](DeepSeek-R1-Distill-Qwen-32B)
- [DeepSeek-R1-Distill-Qwen-7B](DeepSeek-R1-Distill-Qwen-7B)
- [DeepSeek-R1](DeepSeek-R1)
- [DeepSeek-V3.1](DeepSeek-V3.1)
- [Dolly-v2-12b](dolly-v2-12b)
- [Dria](dria)
- [Falcon-7B](Falcon-7B)
- [FastChat](FastChat)
- [Faster Whisper](faster-whisper-gpu)
- [Flan-T5 XXL](flan-t5-xxl)
- [FLock Validator](FLock-validator)
- [FLock-Training-Node](FLock-training-node)
- [Foundry-RIT AI Training Model Challenge](Foundry-rit-ai-training-model-challenge)
- [Gensyn RL Swarm](gensyn-rl-swarm)
- [GPT-Neo](gpt-neo)
- [GPUStack Worker](gpustack-worker)
- [GPUStack](gpustack)
- [Grok](grok)
- [Hermes-4-405B-FP8](Hermes-4-405B-FP8)
- [InvokeAI](invoke-ai-gpu)
- [Llama-2-70B](Llama-2-70B)
- [Llama-3-70B](Llama-3-70B)
- [Llama-3-8B](Llama-3-8B)
- [Llama-3-Groq-8B-Tool-Use](Llama-3-Groq-8B-Tool-Use)
- [Llama-3.1-405B-AWQ-INT4](Llama-3.1-405B-AWQ-INT4)
- [Llama-3.1-405B-BF16](Llama-3.1-405B-BF16)
- [Llama-3.1-405B-FP8](Llama-3.1-405B-FP8)
- [Llama-3.1-8B](Llama-3.1-8B)
- [Llama-3.2-11B-Vision-Instruct](Llama-3.2-11B-Vision-Instruct)
- [Llama-3.2-3B](Llama-3.2-3B)
- [Llama-3.2-90B-Vision-Instruct](Llama-3.2-90B-Vision-Instruct)
- [Llama-3.3-70B](Llama-3.3-70B)
- [LLaMA-Factory](llama-factory)
- [Llama-3_3-Nemotron-Super-49B-v1](Llama-3_3-Nemotron-Super-49B-v1)
- [Llama-4-Maverick-17B-128E-Instruct-FP8](Llama-4-Maverick-17B-128E-Instruct-FP8)
- [Llama-4-Scout-17B-16E-Instruct](Llama-4-Scout-17B-16E-Instruct)
- [Mistral-7B](Mistral-7B)
- [Ollama](ollama-gpu)
- [Open GPT](open-gpt)
- [Open WebUI](open-webui-gpu)
- [OpenAI gpt-oss-120b](openai-gpt-oss-120b)
- [Pluralis-Node](Pluralis-Node)
- [PrivateGPT](privategpt-gpu)
- [Qwen-QwQ-32B](QwQ-32B)
- [Qwen3-235B-A22B-FP8](Qwen3-235B-A22B-FP8)
- [Qwen3-235B-A22B-Instruct-2507-FP8](Qwen3-235B-A22B-Instruct-2507-FP8)
- [Qwen3-235B-A22B-Instruct-2507](Qwen3-235B-A22B-Instruct-2507)
- [Qwen3-235B-A22B-Thinking-2507-FP8](Qwen3-235B-A22B-Thinking-2507-FP8)
- [Qwen3-235B-A22B-Thinking-2507](Qwen3-235B-A22B-Thinking-2507)
- [Qwen3-Coder-480B-A35B-Instruct](Qwen3-Coder-480B-A35B-Instruct)
- [Qwen3-Next-80B-A3B-Instruct](Qwen3-Next-80B-A3B-Instruct)
- [RedPajama-INCITE-7B-Instruct](redpajama-incite-7b-instruct)
- [Semantra](semantra)
- [Serge](serge-gpu)
- [Stable Diffusion Webui](stable-diffusion-webui)
- [Stable Diffusion](stable-diffusion-ui)
- [StableStudio](StableStudio)
- [StableSwarmUI](stableswarmui)
- [Text generation WebUi](text-generation-webui)
- [TTS](TTS)
- [Unsloth AI](unsloth-ai)
- [vllm](vllm)
- [Whisper ASR](whisper-asr-gpu)
- [Whisper GUI](whisper-gui-gpu)
- [XLM-RoBERTa](XLM-RoBERTa)

### Benchmarking

- [Fast.com by Netflix](fast)
- [Flexible IO Tester](fio)
- [Geekbench 5](geekbench)
- [LibreSpeed](librespeed)
- [MonkeyTest](monkeytest)
- [OpenSpeedTest](openspeedtest)
- [Persistent Storage benchmarking tool](persistent-storage-performance-testing)
- [Phoronix](phoronix)
- [Serverbench](serverbench)
- [Speedtest Tracker](speedtest-tracker)
- [Speedtest by Ookla](speedtest-cli)

### Blockchain

- [Akash On Akash](https://github.com/ovrclk/akash-on-akash)
- [Bitcoin Cash Node](bitcoincashnode)
- [Bitcoin Knots and mempool UI](bitcoin-knots-mempool-ui)
- [Bitcoin](bitcoin)
- [Concordium node](concordium)
- [Ethereum 2.0](Ethereum_2.0)
- [Fuse Network Node](fuse-network-node)
- [Handshake](handshake)
- [Injective](injective)
- [Kadena](Kadena)
- [Near Node](near)
- [POKT Network](pokt-network)
- [Polkadot](polkadot)
- [Prysm Beacon](prysm-beacon)
- [Starknet Node by Juno](juno)
- [Substrate Node](substrate-node)
- [Vidulum](vidulum)
- [Witness Chain Watchtower](witnesschain-watchtower)

### Blogging

- [Confluence](confluence)
- [Drupal](drupal)
- [Ghost](ghost)
- [Grav](Grav)
- [Nitropage](nitropage)
- [SteemCN](steemcn)
- [Wiki.js](wikijs)
- [Wordpress](wordpress)

### Built with Cosmos-SDK

- [Big Dipper](big-dipper)
- [Dharani](Dharani)

### Business

- [Odoo](odoo)
- [RAIR-Dapp](RAIR-Dapp)
- [n8n](n8n)

### Chat

- [Mattermost](mattermost)
- [Status](status)

### CI/CD, DevOps

- [Automatic Deployment and CICD Template](automatic-deployment-CICD-template)
- [Azure Devops Agent](azure-devops-agent)
- [Bitbucket](bitbucket)
- [Gitea](gitea)
- [Github Runner](ghrunner)
- [Gogs](gogs)
- [Jenkins](jenkins)
- [Micro-services Example](micro-services-example)
- [Radicle](radicle)  

### Data Visualization

- [Redash Data Charts for Akash Analytics](Redash)
- [UFO Sightings](ufo-data-vis)

### Databases and Administration

- [Adminer](adminer)
- [CockroachDB](CockroachDB)
- [CouchDB](couchdb)
- [DefraDB](defradb)
- [InfluxDB](influxdb)
- [JSON Server](json-server)
- [MongoDB](mongoDB)
- [MySQL](MySQL)
- [neo4j](neo4j)
- [pgAdmin](pgadmin4)
- [PostgreSQL](postgres)
- [Qdrant](qdrant)
- [Redis](redis)
- [Supabase](supabase)
- [SurrealDB](SurrealDB)

### Decentralized Storage

- [Codex](codex)
- [IPFS](ipfs)

### DeFi

- [Augur](augur)
- [Balancer](balancer)
- [Bancor](bancor)
- [Curve](curve)
- [dFed](dfed)
- [Luaswap](luaswap)
- [Osmosis DEX](osmosis-fe)
- [Pancake Swap](pancake-swap)
- [Ren Protocol](renprotocol)
- [Serum DEX UI](serum)
- [Sifchain DEX](sifchain-ui)
- [SushiSwap](sushiswap)
- [Synthetix.Exchange](synthetix.exchange)
- [ThorChain BEPSwap](Thorchain-BEPSwap)
- [Uma Protocol](uma-protocol)
- [Uniswap](uniswap)
- [Yearn.finance](Yearn.finance)
- [yfii](yfii)

### Game Servers

- [Counter-Strike: Global Offensive](csgo)
- [Holdfast: Nations At War](holdfastnaw)
- [Mordhau](mordhau)
- [Squad](squad)
- [SteamCMD](steamcmd)
- [SteamPipe](steampipe)
- [Team Fortress 2](tf2)

### Games

- [MemoryGame](MemoryGame)
- [Minecraft](minecraft)
- [Minesweeper](minesweeper)
- [Pac-Man](pacman)
- [Snake Game](snake-game)
- [Supermario](supermario)
- [Tetris by bsord](tetris)
- [Tetris by uzyexe](tetris2)

### Hosting

- [Caddy](caddy)
- [Flame](flame)
- [Grafana](grafana)
- [Nginx Let's Encrypt Proxy](nginx-letsencrypt-proxy)

### Machine Learning

- [Doccano](doccano)
- [Handwritten Digits Recognition Application](tensorflow-webapp-mnist)
- [Jupyter Notebook with ezkl](tensorflow-jupyter-ezkl)
- [Jupyter Notebook with Python Kernel](tensorflow-jupyter-mnist)
- [Jupyter Notebook](jupyter)
- [Ray Cluster](ray)
- [TensorFlow Serving MNIST CNN Model](tensorflow-serving-mnist)

### Media

- [FreeFlix Nucleus](freeflix-nucleus)

### Mining - CPU

- [Chia Bladebit Disk](chia-bladebit-disk)
- [Chia Bladebit](chia-bladebit)
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

- [Meowcoin Pool](kawpow-pool-meowcoin)
- [monero-pool by jtgrassie](monero-pool)
- [Neoxa Pool](kawpow-pool-neoxa)
- [Ravencoin Pool](kawpow-pool-ravencoin)

### Network

- [CJDNS PKT](cjdns-pkt)
- [Sentinel dVPN node](Sentinel-dVPN-node)
- [SoftEther VPN](softether-vpn)
- [Tor Proxy](tor-proxy)
- [V2RAY](v2ray)
- [X-UI](x-ui)

### Peer-to-peer File Sharing

- [qBittorrent](qbittorrent)

### Project Management

- [Jira Software](jira)
- [Kanboard](kanboard)
- [Redmine](redmine)

### Search Engines

- [Presearch](presearch)
- [Whoogle Search](whoogle-search)
- [YaCy](yacy)

### SSH

- [base-ssh](base-ssh)

### Social

- [Discourse](discourse)
- [TeamSpeak](teamspeak)
- [Waku](waku)

### Tools

- [anubis](anubis)
- [authsteem](authsteem)
- [Budibase](budibase)
- [Code-Server](code-server)
- [CodiMD](CodiMD)
- [dart-hello](dart)
- [DEGO Stats](dego-stats)
- [Folding@home](folding-at-home)
- [Hashicorp Vault](hashicorp-vault)
- [Keycloak IAM](keycloak-iam)
- [KnowYourDeFi](knowyourdefi)
- [LibreTranslate](libretranslate)
- [Matomo](matomo)
- [microbox](microbox)
- [Mintr](mintr)
- [Nextcloud](nextcloud)
- [owncloud](owncloud)
- [PeerJS Server](peerjs-server)
- [Periodic Table Creator](Periodic-Table-Creator)
- [Quill editor](quill-editor)
- [Swagger UI](swagger-ui)
- [thirdweb](thirdweb)
- [Uptime Kuma](uptime-kuma)
- [vaultwarden](vaultwarden)
- [Webtop](webtop)
- [Zammad](zammad)

### Video Conferencing

- Your project can be the first!

### Wallet

- [Lunie Wallet for Cosmos SDK](lunie-lite)
- [MyEtherWallet](MyEtherWallet)
- [Tron Wallet](tronwallet)

### Web Frameworks
- [Gin](gin)
- [NextJS](nextjs)
- [React](react)
- [Ruby on Rails](ruby-on-rails)
