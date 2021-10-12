## [How to mine Monero on Akash Network](https://nixaid.com/mine-monero-akash)

### deploy.yaml

Note that I've specified "MODE=light", that way you can mine with as low as 512Mi RAM (might be even lower, but not less than 256Mi). Mining will be slower, around 150 H/s.
If you set "MODE=fast" you will mine about x5 faster, around 850 H/s. But your deployment would need at least 8196Mi RAM

You can read more here:
- [RandomX readme](https://github.com/tevador/RandomX/blob/v1.1.9/README.md)
- [RandomX Optimization Guide](https://xmrig.com/docs/miner/randomx-optimization-guide)

### Check your miner's status

Just enter your deployment URI at http://workers.xmrig.info

### Check your miner's stats in the MineXMR pool

Enter your Monero address to see the stats at https://minexmr.com/dashboard
