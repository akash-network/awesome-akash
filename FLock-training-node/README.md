# 🌳 Run a FLock Training Node on Akash

This is a template for running a FLock Training Node on Akash. It enables users to run FLock's [Training Node Quickstart Script](https://github.com/FLock-io/testnet-training-node-quickstart) directly from the Akash Console and earn FML rewards on [train.flock.io](http://train.flock.io/).

[train.flock.io](http://train.flock.io/) is the gateway to [FLock.io](http://flock.io/)'s decentralized AI training platform, AI Arena. It is currently on incentivised testnet, and all participants who have earned FML rewards will receive mainnet airdrops.

To participate, you need to first [get whitelisted](https://blog.flock.io/news/trainflock), acquire [FML test tokens](https://train.flock.io/faucet) and test tokens for Base Sepolia, then [stake FML](https://train.flock.io/stake) on the task you wish to train models for.  Afterwards, you can use this template to run training tasks with Akash compute; the script automates the entire Training Node process, from downloading training dataset, model training, uploading to a Hugging Face repo, and submitting the training task.

# 🚀 About [FLock.io](http://flock.io/)

[FLock.io](http://flock.io/) is a decentralised AI co-creation platform aimed at democratising AI development and alignment, battling the concentration of power and data ownership in centralised corporations. It closed a $6m seed round in March 2024, led by Lightspeed Faction with participation from DCG, Volt, OKX Ventures among others. The core team, from Oxford University, has 10+ years of AI and blockchain experience.

## 💻 Usage

To use the training node,obtain your `FLOCK_API_KEY` and `task_id` from [FLock](https://train.flock.io),obtain your `HG_USERNAME` and `HF_TOKEN` from [Hugging Face](https://huggingface.co/) and fill in the `deploy.yaml` file accordingly.To train with your own dataset or configure your training parameters, upload demo_data.jsonl and training_args.yml to your GitHub project (see [example](https://github.com/FLock-io/akash-hackthon-train-example)), and then enter the project URL in the GIT_URL field in deploy.yaml.

## 📖 Documentation

For comprehensive guides and documentation, refer to the [FLock Docs](https://docs.flock.io/flock-product/ai-arena/training-node-guide).

## 🙋 Support

If you have any questions, encounter any issues, or have feature requests, feel free to reach out:

- Follow us on [Twitter](https://twitter.com/flock_io)
- Connect with us on [LinkedIn](https://www.linkedin.com/company/flock-io/)
- Join the [discussion on Discord](https://discord.com/invite/ay8MnJCg2W)
- Join our [Telegram community](https://t.me/flock_io_community)
