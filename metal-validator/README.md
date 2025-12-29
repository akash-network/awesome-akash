<p align="center">
  <img src="assets/metalblockchain-logo.png" alt="Metal Blockchain Logo" width="200" />
</p>

# Deploy Metal Blockchain Validator

Launch a Metal blockchain validator node in minutes on Akash's decentralized cloud for a fraction of traditional VPS costs. Metal blockchain, developed by Metallicus, powers a compliant Digital Asset Banking Network connecting traditional finance with blockchain technology for regulated institutions.

## Requirements

Before deploying, ensure you have:

- Akash wallet with AKT tokens (for deployment costs)
- Metal wallet with 2,000+ METAL tokens (for mainnet staking)
- Access to Akash Console (no CLI required)
- 5-10 minutes for deployment and bootstrap

## Cost

Mainnet: Approximately $5-15/month on Akash Network (varies by provider and market conditions)

## Quick Deploy

1. Go to [Akash Console](https://console.akash.network)
2. Click "Deploy" → "Upload SDL"
3. Upload `deploy.yaml` from this repository
4. Deploy and wait 5-10 minutes

**GitHub Raw URL:**
```
https://raw.githubusercontent.com/VirgilBB/Metal-Validator/main/deploy.yaml
```

## Two-Step Deployment Process

The template requires a two-step deployment:

### Step 1: Initial Deployment
Deploy the `deploy.yaml` to trigger LoadBalancer IP assignment. Wait 1-2 minutes for the IP to appear.

### Step 2: Update with LoadBalancer IP
1. In Akash Console → Your Deployment → "IP(s)" field, copy your assigned IP
2. Click "Update" on your deployment
3. Find the `METAL_PUBLIC_IP` environment variable
4. Enter your LoadBalancer IP with port
   - Example: `METAL_PUBLIC_IP=http://203.45.67.89:9650`
5. Click "Update" to save

**Why two steps?** The LoadBalancer IP is assigned after deployment, so we update the configuration once the IP is available.

**Important:** Update promptly after getting your IP—don't wait too long between deployments.

## Registering Your Validator

The deployment shows different output based on the deployment phase:

### First Deployment (Initial Setup)
After the first deployment, you'll see:
```
========================================
METAL MAINNET VALIDATOR - INITIAL SETUP
========================================

✅ Node is running
✅ Connected to 167 peers
✅ Network: Metal Mainnet

Next steps:
1. Go to Akash Console → Leases tab → Copy the IP address
   (Example format: 203.45.67.89:9650)
2. Update deployment: METAL_PUBLIC_IP=http://YOUR-IP-HERE:9650
   (Replace YOUR-IP-HERE with your actual IP from step 1)

⚠️  No IP assigned? Redeploy on a different provider.

⚠️  IMPORTANT: Complete step 2 to finalize setup
========================================
```

**Note:** No Node ID is shown yet. Complete the IP update first.

### Second Deployment (After IP Update)
After updating with your LoadBalancer IP, you'll see the full validator data:
```
========================================
METAL MAINNET VALIDATOR - SETUP DATA
========================================

⚠️  SAVE THIS DATA NOW ⚠️

Node ID
NodeID-EmAczyoApADhjs4XAkodTKcrSLyjHNvSG

Proof of Possession - Public Key
0xa71852d4ddc0264781181e2f34991b25f0777d15f867219b5dc1b76244d0cda9b3c408d0e6496f9ab3bbb95255c31e82

Proof of Possession - Signature
0x8981dc303bab3a634f27f288313e801d1f9da065713f6e10817a7c248d0e39878a534d2b04217af834562d587be3507f0d006c7c8aab9343af8531b91ab9b0ca9b0d919135c1bcc478ea4742d16fcc4a1f54c99b27b319ed2e16646f963994ff

Public IP
184.105.162.180:9650

Note: Save this IP for Grafana monitoring template

Register your validator: https://wallet.metalblockchain.org/

========================================
VERIFICATION
========================================

✅ Node is operational
✅ Connected to 167 peer(s)
✅ Good connectivity (50+ peers)

✅ IP configured: 184.105.162.180:9650
   (Verify this matches your IP in Akash Console → Leases → IP(s))

========================================
```

**Copy all three pieces of data:**
- Node ID
- Proof of Possession - Public Key  
- Proof of Possession - Signature

All three are required to register your validator on the [Metal Wallet Dashboard](https://wallet.metalblockchain.org/).

**Also save the Public IP** for Grafana monitoring template.

**Important:** Use the Node ID, Public Key, and Signature from logs AFTER the IP update completes. The Node ID may change after the IP update, so always use the final values.

### Recurring Status Updates
After the IP update, your logs will show a status update every 20 minutes with your validator credentials. You can always find your Node ID, Public Key, Signature, and Public IP in recent logs.

## Backup Your Validator (Highly Recommended)

**⚠️ Highly Recommended:** Backup your validator credentials while your deployment is accessible. If your provider goes down or your deployment is lost, you can recover your validator identity instead of re-registering.

### Quick Backup (2 minutes)

1. In Akash Console → Your Deployment → **Shell** tab
2. Run this command:
```bash
   curl -s https://raw.githubusercontent.com/VirgilBB/Metal-Validator/main/metal-node-recovery/backup-node.sh | bash
```
3. **Copy and securely save** the base64 backup string that appears
4. Store it somewhere safe (encrypted password manager, secure note, etc.)

**That's it.** If you ever need to recover your validator, contact cerebro@cerebro.host with your backup string.

**Security:** Your backup contains your staking keys—keep it secure and never share it publicly.

## Key Features

- **Dedicated IP Support**: Uses endpoints with `kind: ip` for optimal P2P connectivity
- **Advanced IP Detection**: Multi-method IP detection (Kubernetes API → Environment Variables → External Services)
- **Manual IP Override**: Set `METAL_PUBLIC_IP` environment variable if auto-detection fails
- **File Descriptor Limits**: Increased to 65536 to prevent "too many open files" errors
- **Bootstrap Detection**: Waits for blockchain to fully bootstrap before reporting success

## Resources

- [Metal Blockchain](https://www.metalblockchain.org/)
- [Metal Mainnet Explorer](https://explorer.metalblockchain.org/)
- [Metal Wallet Dashboard](https://wallet.metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Akash Console](https://console.akash.network/)

## Troubleshooting

**Node shows "Not connected" in explorer**  
Complete the two-step deployment process. Set `METAL_PUBLIC_IP` to your LoadBalancer IP in Akash Console → Update deployment.

**"too many open files" errors**  
The template includes `ulimit -n 65536` to prevent this issue.

**0 peers connected**  
Ensure you completed the two-step process and set the correct LoadBalancer IP in `METAL_PUBLIC_IP`.

**Initial Node ID changes after update**  
This is normal. Use the final Node ID, Public Key, and Signature from logs AFTER the IP update completes.

**No IP assigned in Leases tab**  
Redeploy on a different provider.

## Need Help?

- **Direct Support**: Email cerebro@cerebro.host
- **Issues?** Open an issue in [this repository](https://github.com/VirgilBB/Metal-Validator)
- **Questions?** Join [Akash Discord](https://discord.gg/akash)
- **Metal Support?** Join [Metal Discord](https://discord.gg/B2QDmgf)

Deploy, copy your validator data, register on Metal dashboard, and start earning rewards!
