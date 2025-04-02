# morpheus-lumerin-node
<!-- markdownlint-disable first-line-h1 -->
<!-- markdownlint-disable html -->
<!-- markdownlint-disable no-duplicate-header -->

<video width="100%" autoplay loop muted playsinline style="border: none;">
  <source src="https://pub-6497706944e34d308b0afa5d4483d9b5.r2.dev/WEBM%2Flumerin_morpheus.webm" type="video/quicktime">
</video>

## 🔗 Related Resources

* <img src="https://morpheusai.gitbook.io/~gitbook/image?url=https%3A%2F%2F382415899-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Forganizations%252F4ZkFBwm0Y9Vw2Hlxkfhw%252Fsites%252Fsite_pK3pL%252Ficon%252FGFGh6tiIUbFV3TLjr65h%252Favatar_one_icon.png%3Falt%3Dmedia%26token%3D25c1d4a3-f574-4338-a0df-339887b6515b&width=32&dpr=1&quality=100&sign=9e535bfe&sv=2" width="20" height="20" alt="Morpheus favicon"> [Morpheus AI Project](https://mor.org/) - Official Morpheus Network Website
* <img src="https://avatars.githubusercontent.com/u/102425763?v=4" width="20" height="20" alt="Lumerin favicon"> [Morpheus-Lumerin-Node Repository](https://github.com/Lumerin-protocol/Morpheus-Lumerin-Node) - Main development repository
* 📖 [Documentation](https://github.com/Lumerin-protocol/Morpheus-Lumerin-Node/tree/main/docs) - Detailed setup and configuration guides

# Deploying Morpheus Lumerin Node on Akash

This guide covers deploying the proxy-router component of the Morpheus AI Network on Akash Network. The deployment provides API access via Swagger interface without GUI or wallet components.

## Prerequisites

* Running AI model accessible via private endpoint (e.g., `http://model.domain.com:8080`)
* Funded wallet with MOR and ETH tokens
* Wallet private key for blockchain interactions
* Akash account with deployment experience
* Note: The final endpoint URL will be available after provider selection and deployment

## Configuration

The proxy-router uses environment variables for configuration instead of volume mounts for improved reliability on Akash:

* `COOKIE_CONTENT`: API authentication (format: `username:password`)
* `MODELS_CONFIG_CONTENT`: JSON configuration for model endpoints
* `WALLET_PRIVATE_KEY`: For blockchain interactions
* Network-specific variables (chain ID, contract addresses, etc.)

## Deployment Steps

1. **Prepare SDL Template**
   * Download and customize [Akash SDL Template](./deploy.yaml)
   * Minimum version: `v3.0.0`
   * Configure:
     - Wallet private key
     - API credentials
     - Model configurations
   * Save securely (contains sensitive data)

2. **Deploy Container**
   * Use Akash Dashboard: `DEPLOY` → `Custom Container`
   * Upload customized SDL
   * Select provider and deploy
   * Verify deployment status and logs

3. **Configure Endpoints**
   * Update `WEB_PUBLIC_URL` with provider URL and port
   * Note both API port (8082) and proxy-router port (3333)
   * Format: `http://provider.domain:port`

4. **Register Provider**
   * Access Swagger UI: `http://provider.domain:port/swagger/index.html`
   * Authenticate using configured credentials
   * Update provider endpoint via `POST /blockchain/providers`:
   ```json
   {
     "endpoint": "provider.domain:proxy_port",
     "stake": "123000000000"
   }
   ```
   * Verify registration via `GET /blockchain/providers`

## Example Logs

![akash_good_start](https://raw.githubusercontent.com/Lumerin-protocol/Morpheus-Lumerin-Node/main/docs/images/akash_good_start.png)

