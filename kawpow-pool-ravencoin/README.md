# NOMP KawPoW Algorithm Mining Pool
Highly Efficient mining pool for Coins based on KawPoW algo!

# Highly modified for the Akash.Network
Supports Ravencoin, Neoxa, Meowcoin

### Requirements

# I already have a Ravencoin wallet and private key

Great! You are steps away from your own private mining pool.  Click Deploy and update the required variables with your wallet information

```
WALLET=
FEE_WALLET=
PRIVATE_KEY=
```

After the deployment has started click on the URI / URL in the Deployment Details page to access the web interface.

# I don't have a Ravencoin wallet or private key.

You need a Ravencoin wallet address and private key to setup the mining pool.  If you do not have one, simply deploy this default template without any WALLET or PRIVATE_KEY defined.
In Akash Console, select "Shell" and from the services tab click on "ravencoin".  In the "Type command window" use the 2 following commands to generate a new address and show the private key of the new address.

```
/raven-cli getnewaddress
YOUR_NEW_ADDRESS
/raven-cli dumpprivkey YOUR_NEW_ADDRESS
```
* Replace YOUR_NEW_ADDRESS after dumpprivkey to get the private key!

You can now update the variables in the deployment with your new wallet and private key.  Be sure to write down the private key or keep it in a safe place!

# Connecting to the Mining Pool / Stratum Ports

The mining pool is pre-configured to map each stratum port to an ephemeral port.  After your deployment is successful you will see the new port numbers to connect to.

# What about security?  

The default template is configured to only deploy to audited Akash providers.  If you remove this `signedBy` attribution key you are putting your private key at risk.
The pool wallet should NEVER be used for long term/cold storage of coins.

-------
### Screenshots
#### Home<br />
![Home](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/home.png)

#### Pool Stats<br />
![Pool Stats](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/poolstats.png)<br /><br />

#### Miner Stats<br />
![Miner Stats](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/minerstats.png)<br /><br />

#### Payments<br />
![Payments](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/payments.png)<br /><br />

-------
### Node Open Mining Portal consists of 3 main modules:
| Project | Link |
| ------------- | ------------- |
| [KawPoWNOMP](https://github.com/Satoex/kawpow-pool.git) | https://github.com/Satoex/kawpow-pool.git |
| [Stratum Pool](https://github.com/GRinvestPOOL/kawpow-stratum-pool-1.git) | https://github.com/GRinvestPOOL/kawpow-stratum-pool-1.git |
| [Node Multihashing](https://github.com/zone117x/node-multi-hashing.git) | https://github.com/zone117x/node-multi-hashing.git |

-------
