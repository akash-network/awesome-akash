[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-Pluralis-Node)

<!-- markdownlint-disable first-line-h1 -->
<!-- markdownlint-disable html -->
<!-- markdownlint-disable no-duplicate-header -->

<div align="center">
    <a href="https://pluralis.ai/" target="_blank">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://github.com/PluralisResearch/node0/raw/main/images/node0-logo-white.png">
        <source media="(prefers-color-scheme: light)" srcset="https://github.com/PluralisResearch/node0/raw/main/images/node0-logo-black.png">
        <img alt="PluralisResearch Node0 Logo" src="https://github.com/PluralisResearch/node0/raw/main/images/node0-logo-black.png" width="500px" style="max-width: 100%; margin-bottom: 30px">
    </picture>
    </a>
</div>
<div align="center">
    <a href="https://dashboard.pluralis.ai/"><img alt="Dashboard"
    src="https://img.shields.io/badge/Dashboard-Online-62BB47"/></a>
    <a href="https://pluralis.ai/"><img alt="Website"
    src="https://img.shields.io/badge/PluralisResearch-Website-6F02B5"/></a>
    <a href="https://discord.gg/GD2RGdYGKQ"><img alt="Discord"
    src="https://img.shields.io/badge/Discord-Join-5865F2?logo=discord"/></a>
</div>

## ✨ Description

Node0 is a collaborative event powered by Protocol Learning, our decentralized approach to AI development.

This is the first pretraining run open to the public that can use commodity hardware, so anyone can join and help train this model. This training run supports participants with compute resources as small as a 16GB consumer GPU (e.g., an Nvidia 3090). For the first time, small devices are contributing to a global training cluster, demonstrating that the online community can collaboratively train massive models.

Each participant (node) holds a small portion of the model's computation graph. Despite being connected over the internet (which has 100x slower speeds compared to datacenter connections), we are able to achieve training speeds and performances on par with centralized systems, utilizing the same amount of compute. The swarm of nodes is fully dynamic, meaning participants can join and leave at any time. As a result, the system scales horizontally – the more nodes join, the faster training proceeds.

Because decentralized protocols allow us to pool compute resources from many sources, they enable access to more computational power than is typically available in centralized datacenters. This opens up the possibility to train larger models than ever before, giving the community the ability to push the boundaries of AI training.

This is a hands-on demonstration of our vision: to make AI more accessible and less centralized by pooling compute resources from a global community.

Each participant's progress is logged - check their contribution in the dashboard.

<div align="center">
  <a href="https://dashboard.pluralis.ai/">
    <img src="https://github.com/PluralisResearch/node0/raw/main/.github/assets/dashboard-button.svg" alt="Live Dashboard"/>
  </a>
</div>

      
## 📑 Table of Contents

- [Deploy on Akash](#-deploy-on-akash)
- [Requirements](#-requirements)
- [Usage](#-usage)
- [Important](#-important)
- [Troubleshooting](#-troubleshooting)
- [Citations](#-citations)
- [License](#-license)
- [Acknowledgements](#-acknowledgements)

## 📋 Deploy on Akash

After deploying the deployment SDL file via [Akash Console](https://console.akash.network/new-deployment), you can find the deployment in the [Deployments](https://console.akash.network/deployments) tab.

After successful deployment, copy the assigned external port in the Forwarded Ports section because we will use it to start the server.
Then head over to the Shell and run the following commands:
```bash
cd node0
python3 generate_script.py --identity_path /persistent/private.key --announce_port EXTERNAL_49200_PORT # Use the assigned external port
# follow the prompts and provide your huggingface token
cp start_server.sh /persistent/
cd /persistent/
pm2 start python3.11 --name "pluralis" -- $(grep "python3.11" start_server.sh | sed 's/.*python3.11 //')
```
After that, you can see the server running in the Logs tab.

## 📋 Requirements

### Hardware Requirements

**PC/Server with Nvidia GPU:**

- Minimum 16GB GPU memory
- Minimum 32GB RAM
- Minimum 80GB disk space (required for Docker image)


### Authentication

Create HuggingFace access token ([instruction](https://huggingface.co/docs/hub/en/security-tokens)). The token doesn't need any read/write permissions as it will only be used for authorization.


### Option 1: From Source (Preferred on WSL)

#### Prerequisites

- Python 3.11
- pip or conda package manager

#### Conda ([install](https://www.anaconda.com/docs/getting-started/miniconda/install#linux))

```bash
# Clone repository
git clone https://github.com/PluralisResearch/node0
cd node0

# Create conda environment
conda create -n node0 python=3.11
conda activate node0

# Install node0
pip install .
```

## 🚀 Usage

### Generate starting script

To create the script that starts the server, run the following command:

#### Using Docker

```bash
python3 generate_script.py --use_docker
```

#### Without Docker

```bash
python3 generate_script.py
```

This command generates a **start_server.sh** file.

#### Parameters

The **generate_script.py** script requires a few authorization parameters:

- HuggingFace token (follow instructions in the [Requirements](#-requirements) section to obtain one)
- Email address (optional) - please provide your email address so we can get in touch with you

You can either enter these interactively (default) or pass them as command-line arguments:

- `--token <HF_token>`
- `--email <email_address>`

To skip interactive prompts entirely, use `--skip_input` flag.

#### Multiple GPUs

Currently, Node0 supports **single-GPU training only**.

If you're running on a multi-GPU machine, you can specify which GPU to use with the `--gpu_id` flag:

```bash
--gpu_id <ID>
```

By default, the script uses **GPU 0**.

If you want to run multiple training scripts (each one with a different GPU) on the same machine, each instance needs its own `node0` repository folder (as otherwise private keys and logs get overridden). Each instance should also use a different host/announce port. See below how to change the default exposed port. 

#### Changing exposed port

By default, Node0 exposes port `49200` for P2P connections. If you need to modify the exposed port, use the following flags:

```bash
--host_port <port>     # The internal port the library will listen on
--announce_port <port> # The external port other peers will connect to
```

In most cases, `host_port` and `announce_port` should be identical. However, some compute providers (e.g., RunPod) assign random external port mappings. In this case:

1. Set `--host_port` to the internal port you want the library to listen on
2. Set `--announce_port` to the external port that has been mapped by your provider

### Start the server

To join the experiment, run:

```bash
./start_server.sh
```

The **stdout** from the Docker container is saved in the **run.out** file. To keep track of the training, you can use this command to see the file updates in the terminal:

```bash
tail -f run.out
```

If running outside of Docker, we recommend running the code inside a [tmux](https://github.com/tmux/tmux/wiki) session, which allows the script to persist when you disconnect from the machine and provides better control for resource cleanup when stopping the script.

### Stop the server

You can stop the server at any time and rejoin the experiment later &mdash; your contribution will be saved.

**Do not delete private.key** file between runs (see [Important](#-important) section).

To stop the server, run:

#### Using Docker

```bash
# Find the container name or ID
docker ps

# Stop the server
docker stop <container_name_or_ID>

# Remove the container
docker rm <container_name_or_ID>

# Update file ownership
sudo chown -R <linux_user> .
```

#### Without Docker

Press `Ctrl + Z` in the terminal running the server to stop it.

Remove temporary files and free ports:

```bash
# Remove socket files
rm /tmp/hivemind*

# Install lsof (omit sudo if running on cloud providers without sudo access)
sudo apt-get install lsof

# Kill all processes using host port (default port number is 49200)
# (omit sudo if running on cloud providers without sudo access)
for i in $(sudo lsof -t -i tcp:<host_port>); do kill -9 $i; done
```

⚠️ **Note:** On some cloud providers sudo may not be available. In such cases, simply omit sudo from the commands above.

If the GPU memory is not released, you can run the following command to kill ***all*** python processes that use GPU. ⚠️ **WARNING**: do not run this if you have any other python code using GPU running as it will be killed as well.

```bash

# Install lsof (omit sudo if running on cloud providers without sudo access)
sudo apt-get install lsof

# Kill processes (omit sudo if running on cloud providers without sudo access)
for i in $(sudo lsof /dev/nvidia* | grep python  | awk '{print $2}' | sort -u); do kill -9 $i; done
```

### Restart the server

If the server has been stopped, you can restart it as follows:

```bash
./start_server.sh
```

Make sure you've followed all the steps in the [Stop the server](#stop-the-server) section to properly stop the old run first.

⚠️ **Note:** If you experience any problems, try restarting your computer and then attempt to start the server again.

### Verify training

It may take few minutes for the server to find other peers and join the training. Check the training logs (**logs/server.log**) or **stdout** to monitor the process. If you're running the code inside a Docker, **stdout** is saved in **run.out** file.

At first, you will see that authorization is completed and new parameters are downloaded from a peer:

<pre>
INFO:node0.security.authorization: <b>Access for user username has been granted until </b>2025-04-15 12:59:12.613600+00:00 UTC
INFO:node0.security.authorization: <b>Authorization completed</b>
 
 ...

INFO:hivemind.averaging.averager: <b>Downloading parameters from peer </b><...>
INFO:hivemind.averaging.averager: <b>Finished downloading state in 0.309s from </b><...>
</pre>

After some time the training will start and you will see similar logs:

<pre>
INFO:hivemind.moe.server.runtime: <b>Processed 51 batches in last 60 seconds:</b>
INFO:hivemind.moe.server.runtime: <b>body2.0.919_backward: 27 batches (100.62 batches/s), 108 examples (402.50 examples/s), avg batch size 4.00</b>
INFO:hivemind.moe.server.runtime: <b>body2.0.919_forward: 24 batches (382.51 batches/s), 96 examples (1530.02 examples/s), avg batch size 4.00</b>
</pre>

**Sanity check:** a healthy peer will periodically report `Processed [N] batches in last 60 seconds` and `Averaged gradients/parameters with [N > 1]` peers.

## 🚨 Important

### private.key

The code generates a **private.key** file during initial setup. This file:

- Contains your node's cryptographic identity
- Is required for secure communication within the network
- Should be kept confidential and never shared publicly

### Docker files

All files created within the Docker container have a different level of ownership. To modify/delete them outside of the container, you need to reclaim ownership.

**Linux:**

```bash
sudo chown -R <linux_user> <path/to/project>
```

## 🔍 Troubleshooting

### Network-Related Issues

The following errors in logs are typically related to internet connectivity:

- **`Averaging failed with <class 'TimeoutError'>`**

    This occurs when slow internet connections prevent averaging operations from completing in time. This is generally acceptable. 
    > ⚠️ Note: If you only see averaging errors and never see "Averaged gradients/averaged parameters" messages, your internet connection may be too slow for proper operation.

- **`Averaging step failed: could not find a group`**
    
    Similar to the above error, this is caused by network connectivity issues during averaging operations.

- **`An error occurred during the speed test, skipping`**
    
    Indicates that the library couldn't perform an internet speed test. This error can be safely ignored as it doesn't affect core functionality.

- **`Your node cannot be reached by other peers. Please check that the announced port is open to inbound connections.`**
    
    Verify that your port is open for both inbound and outbound connections (follow [this guide](docs/network.md)). Check that no firewall rules are blocking the connection.

- **`Failed to load state from peers.`**

    This error is likely caused by the slow internet connection.

### Authorization Issues
The following errors may occur during the authorization process:

- **`Invalid token`**

    Verify that you've provided a valid Hugging Face token.

- **`Verification failed`**

    If you've made local changes, revert them or use a clean copy of the repository.
    If you recently pulled new commits from the repository:

    * Reinstall the library (if installed from source)
    * Rebuild the Docker image (if using Docker)

- **`This peer_id is already used by another user`**

    This error occurs when attempting to join an experiment with a different Hugging Face account. Delete the private.key file and try again.


## 📚 Citations

If you use this project in your research, please cite:


Gil Avraham*, Yan Zuo*, Violetta Shevchenko, Hadi Mohaghegh Dolatabadi, Thalaiyasingam Ajanthan, Sameera Ramasinghe, Chamin Hewa Koneputugodage, and Alexander Long. **Node0: Model Parallel Training over the Internet with Protocol Models**. 2025.

**equal contribution*

```bibtex
@misc{avraham2025node0,
    title={Node0: Model Parallel Training over the Internet with Protocol Models}, 
    author={Gil Avraham and Yan Zuo and Violetta Shevchenko and Hadi Mohaghegh Dolatabadi and Thalaiyasingam Ajanthan and Sameera Ramasinghe and Chamin Hewa Koneputugodage and Alexander Long},
    year={2025},
    url={https://github.com/PluralisResearch/node0}, 
}
```

&nbsp;

Sameera Ramasinghe, Thalaiyasingam Ajanthan, Gil Avraham, Yan Zuo, and Alexander Long. [Protocol Models: Scaling Decentralized Training with Communication-Efficient Model Parallelism](https://arxiv.org/pdf/2506.01260). 2025.

```bibtex
@misc{ramasinghe2025protocolmodelsscalingdecentralized,
    title={Protocol Models: Scaling Decentralized Training with Communication-Efficient Model Parallelism}, 
    author={Sameera Ramasinghe and Thalaiyasingam Ajanthan and Gil Avraham and Yan Zuo and Alexander Long},
    year={2025},
    eprint={2506.01260},
    archivePrefix={arXiv},
    primaryClass={cs.LG},
    url={https://arxiv.org/abs/2506.01260}, 
}
```

 &nbsp;

Thalaiyasingam Ajanthan, Sameera Ramasinghe, Yan Zuo, Gil Avraham, and Alexander Long. [Nesterov Method for Asynchronous Pipeline Parallel Optimization](https://arxiv.org/pdf/2505.01099). ICML. 2025.
```bibtex
@article{ajanthan2025asyncpp,
    title={Nesterov Method for Asynchronous Pipeline Parallel Optimization},
    author={Ajanthan, Thalaiyasingam and Ramasinghe, Sameera and Zuo, Yan and Avraham, Gil and Long, Alexander},
    journal={ICML},
    year={2025}
}
```

## 📄 License

Distributed under the [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) License. See [LICENSE](LICENSE) for more information.

Third-party dependencies and their licenses are listed in [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## 🙏 Acknowledgements

### Core Framework

This project is built upon the [Hivemind library](https://github.com/learning-at-home/hivemind) for decentralized deep learning, distributed under the [MIT License](https://opensource.org/license/mit).

### Datasets

This project uses the [FineWeb-Edu dataset](https://huggingface.co/datasets/HuggingFaceFW/fineweb-edu) by HuggingFace, made available under the [Open Data Commons Attribution License (ODC-BY) v1.0](https://opendatacommons.org/licenses/by/1-0/).
