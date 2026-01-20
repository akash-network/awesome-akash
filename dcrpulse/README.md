[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-dcrpulse)

<p align="center">
  <img src="assets/decred-logo.jpg" alt="Decred logo" width="220" />
</p>

# dcrpulse GUI Dashboard on Akash

Decred is an autonomous digital currency with a hybrid PoW/PoS consensus system, built to be a superior store of value. Running a full node strengthens the network's decentralization and security. **dcrpulse** makes it easy to deploy your own full node and web dashboard on Akash Network with just a few clicks—no technical expertise required.

> **dcrpulse** is an open-source project by [karamble](https://github.com/karamble). This Akash deployment uses the official [dcrpulse](https://github.com/karamble/dcrpulse) project.

## Features

- **Hybrid PoW/PoS Consensus**: Combines the security of Proof-of-Work with the governance of Proof-of-Stake
- **Community Governance**: Stakeholders vote on consensus rule changes and project treasury spending
- **Self-Funding**: Built-in treasury system funds ongoing development
- **Privacy Features**: Optional privacy transactions via CoinShuffle++
- **Lightning Network**: Support for instant, low-fee transactions
- **Watch-Only Wallet Monitoring**: Import Extended Public Keys (xpub) to monitor wallet balances and transactions without exposing private keys

## About This Deployment

This deployment runs **dcrpulse (web dashboard) + a full Decred node (`dcrd`)** on Akash Network in **one container**, providing:

- **Full blockchain sync** and validation
- **Web dashboard** exposed on port **80**
- **P2P networking** on port **9108**
- **Persistent storage** for blockchain data (PVC)

**Note**: This is not a mining setup. Deploying a full node helps strengthen Decred's network decentralization and security—supporting the network "for the love of the game."

Why one container? Akash provisions per-service PVCs, so "shared volumes across services" don't work the same as docker-compose. Combining the processes avoids that class of issues.

## Resources

- **dcrpulse Project**: https://github.com/karamble/dcrpulse
- **Website**: https://decred.org/
- **Documentation**: https://docs.decred.org/
- **Block Explorer**: https://dcrdata.decred.org/
- **GitHub**: https://github.com/decred/dcrd

## Configuration

The deployment uses the following default settings:

- **Dashboard**: `http://<your-lease-ingress>/` (port 80) - No password required
- **RPC User**: `decred` (internal communication only)
- **RPC Password**: `decredpass` (used for internal communication between dashboard and node)
- **Storage**: 120Gi persistent storage
- **CPU**: 2.5 units
- **Memory**: 5Gi

## Usage

1. Deploy using the provided `deploy.yaml`
2. Check deployment logs—you'll see a prominent message: **🔗 ACCESS DASHBOARD: AKASH CONSOLE → LEASES → <u>URI(S) LINK</u>**
3. Click the **<u>URI(s)</u>** link in Akash Console (Leases tab) to open the dashboard
4. View real-time sync progress with percentage status bar (initial sync takes 6-8 hours)

### Watch-Only Wallet Monitoring

You can import an Extended Public Key (xpub) to monitor your Decred wallet without exposing private keys:

1. Access the dashboard and navigate to **Settings** → **Import Extended Public Key**
2. Paste your xpub (Decred mainnet xpubs start with `dpub`)
3. Provide a friendly account name
4. The wallet will automatically rescan the blockchain to find all historical transactions 

**Note**: Watch-only wallets can monitor balances and transactions but **cannot spend funds**. This is a security feature that allows you to track your wallet activity without risking your private keys.

### Monitoring Sync Progress

The deployment logs display sync progress every 5 minutes with clear instructions to access the dashboard. The dashboard shows real-time sync status with percentage progress bar and current block height.

**Access dashboard**: Akash Console → Leases → **<u>URI(s)</u>** link

Compare your node's block height with the network: https://dcrdata.decred.org/

## Security Note

⚠️ **Important**: The dashboard itself has no password protection and is publicly accessible via the ingress URL. The RPC password (`decredpass`) is used for internal communication between the dashboard and `dcrd` node. For production deployments, change the RPC password in `deploy.yaml` to secure the internal RPC connection.

## Need Help?

- **Direct Support**: Email cerebro@cerebro.host
- **Issues?** Open an issue in [this repository](https://github.com/VirgilBB/dcrpulse)
- **Questions?** Join [Akash Discord](https://discord.com/invite/akash)
- **Decred Support?** Join [Decred Discord](https://discord.com/invite/dXSmwvYury)
