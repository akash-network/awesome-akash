# Arbitrum RPC node on Akash Network

Add Ethereum node RPC address in `--l1.url=` and create deployment.

Example:

```
...
services:
  app:
    image: offchainlabs/arb-node:v1.4.5-e97c1a4
    args:
      - '--l1.url=http://your-RPC-Ethereum-address.com:443' #Ethereum node RPC address
...

```

And another usage flags:

|Flag|Description|
| :-------: | :-------: |
|`--bridge-utils-address string` | bridgeutils contract address|
|`--conf.dump` | print out currently active configuration file|
|`--conf.env-prefix string` | environment variables with given prefix will be loaded as configuration values|
|`--conf.file string` | name of configuration file|
|`--conf.s3.access-key string` | S3 access key|
|`--conf.s3.bucket string` | S3 bucket|
|`--conf.s3.object-key string` | S3 object key|
|`--conf.s3.region string` | S3 region|
|`--conf.s3.secret-key string` | S3 secret key|
|`--conf.string string` | configuration as JSON string|
|`--core.add-messages-max-failure-count int` | number of add messages failures before exiting program (default 10)|
|`--core.cache.basic-interval int` | amount of gas to wait between saving to basic cache (default 100000000)|
|`--core.cache.basic-size int` | number of basic cache entries to save (default 100)|
|`--core.cache.disable `| disable saving to cache while in core thread|
|`--core.cache.last` | whether to always cache the machine from last block|
|`--core.cache.lru-size int` | number of recently used L2 blocks to hold in lru memory cache (default 1000)|
|`--core.cache.seed-on-startup `|  seed cache on startup by re-executing timed-expire worth of history|
|`--core.cache.timed-expire duration` |  length of time to hold L2 blocks in arbcore timed memory cache (default 20m0s)|
|`--core.checkpoint-gas-frequency int` | amount of gas between saving checkpoints (default 1000000000)|
|`--core.checkpoint-load-gas-cost int` | running machine for given gas takes same amount of time as loading database entry (default 250000000)|
|`--core.checkpoint-load-gas-factor int` | factor to weight difference in database checkpoint vs cache checkpoint (default 4)|
|`--core.checkpoint-max-execution-gas int` | maximum amount of gas any given checkpoint is allowed to execute (default 250000000)|
|`--core.checkpoint-max-to-prune int` | number of checkpoints to delete at a time, 0 for no limit (default 2)|
|`--core.checkpoint-prune-on-startup ` | perform full database pruning on startup|
|`--core.checkpoint-pruning-mode string` | Prune old checkpoints: 'on', 'off', or 'default' (default "default")|
|`--core.database.compact` | perform database compaction|
|`--core.database.exit-after` | exit after loading or manipulating database|
|`--core.database.metadata` | just print database metadata and exit|
|`--core.database.save-interval duration`  | duration between saving database backups, 0 to disable|
|`--core.database.save-on-startup` | save database backup on start|
|`--core.database.save-path string` | path to save database backups in (default "db_checkpoints")|
|`--core.debug` | print extra debug messages in arbcore|
|`--core.debug-timing` | print extra debug timing messages in arbcore|
|`--core.deliver-messages-max-failure-count int` | number of deliver messages failures before exiting program (default 50)|
|`--core.idle-sleep duration` | how long core thread should sleep when idle (default 5ms)|
|`--core.lazy-load-archive-queries ` | if the archive queries should be loaded as they're run (default true)|
|`--core.lazy-load-core-machine` | if the core machine should be loaded as it's run|
|`--core.message-process-count int` | maximum number of messages to process at a time (default 100)|
|`--core.test.load-count int` | number of snapshots to load from database for profile test, zero to disable|
|`--core.test.reorg-to.l1-block int` | reorg to snapshot with given L1 block or before, zero to disable|
|`--core.test.reorg-to.l2-block int` | reorg to snapshot with given L2 block or before, zero to disable|
|`--core.test.reorg-to.log int` |  reorg to snapshot with given log or before, zero to disable|
|`--core.test.reorg-to.message int` | reorg to snapshot with given message or before, zero to disable|
|`--core.test.reset-all-except-inbox` | remove all database info except for inbox|
|`--core.test.run-until int` | run until gas is reached for profile test, zero to disable|
|`--core.thread-max-failure-count int` | number of core thread failures before exiting program (default 2)|
|`--core.yield-instruction-count int` | number of instructions to for core thread to run between calling yield (default 50000000)|
|`--feed.input.require-chain-id` | disconnect if Chain-Id HTTP header not present|
|`--feed.input.timeout duration` | duration to wait before timing out connection to server (default 20s)|
|`--feed.input.url strings` | URL of sequencer feed source|
|`--feed.output.addr string` | address to bind the relay feed output to (default "0.0.0.0")|
|`--feed.output.client-timeout duration` | duration to wait before timing out connections to client (default 15s)|
|`--feed.output.io-timeout duration  ` | duration to wait before timing out HTTP to WS upgrade (default 5s)|
|`--feed.output.max-send-queue int` | Maximum number of messages allowed to accumulate before client is disconnected (default 4096)|
|`--feed.output.ping duration` | duration for ping interval (default 5s)|
|`--feed.output.port string` | port to bind the relay feed output to (default "9642")|
|`--feed.output.require-version` | disconnect if Arbitrum-Feed-Version HTTP header not present|
|`--feed.output.workers int` | Number of threads to reserve for HTTP to WS upgrade (default 100)|
|`--gas-price float` | float of gas price to use in gwei (0 = use L1 node's recommended value)|
|`--healthcheck.addr string` | address to bind the healthcheck endpoint to|
|`--healthcheck.enable `| enable healthcheck endpoint|
|`--healthcheck.l1-node` | enable checking the health of the L1 node|
|`--healthcheck.metrics` | enable prometheus endpoint|
|`--healthcheck.metrics-prefix string` | prepend the specified prefix to the exported metrics names|
|`--healthcheck.port int` | port to bind the healthcheck endpoint to|
|`--healthcheck.sequencer` | enable checking the health of the sequencer|
|`--l1.chain-id uint` | if set other than 0, will be used to validate database and L1 connection|
|`--l1.url string` | layer 1 ethereum node RPC URL|
|`--l2.disable-upstream` | disable feed and transaction forwarding|
|`--log.core string` | log level for general arb node logging (default "info")|
|`--log.rpc string` | log level for rpc (default "info")|
|`--metrics` | enable metrics|
|`--metrics-server.addr string` |  metrics server address (default "127.0.0.1")|
|`--metrics-server.port string` |  metrics server address (default "6070")|
|`--node.aggregator.inbox-address string` | address of the inbox contract|
|`--node.aggregator.max-batch-time int` | max-batch-time=NumSeconds (default 10)|
|`--node.aggregator.stateful` | enable pending state tracking|
|`--node.cache.allow-slow-lookup ` | load L2 block from disk if not in memory cache|
|`--node.cache.block-info-lru-size int` | number of recently used L2 block info to hold in lru memory cache (default 100000)|
|`--node.cache.lru-size int` | number of recently used L2 blocks to hold in lru memory cache (default 1000)|
|`--node.cache.timed-expire duration ` | length of time to hold L2 blocks in timed memory cache (default 20m0s)|
|`--node.chain-id uint` | chain id of the arbitrum chain (default 42161)|
|`--node.forwarder.rpc-mode string` | RPC mode: either full, non-mutating (no eth_sendRawTransaction), or forwarding-only (only requests forwarded upstream are permitted) (default "full")
|`--node.forwarder.submitter-address string` |  address of the node that will submit your transaction to the chain|
|`--node.forwarder.target string` | url of another node to send transactions through|
|`--node.inbox-reader.delay-blocks int` | number of L1 blocks to wait for confirmation before updating L2 state (default 4)|
|`--node.inbox-reader.paranoid `|  if enabled, check for reorgs before searching for messages|
|`--node.inbox-reader.sequencer-signature-expiry duration`| length of time between verifying sequencer feed signing address on-chain (default 10m0s)|
|`--node.log-idle-sleep duration ` | milliseconds for log reader to sleep between reading logs (default 100ms)|
|`--node.log-process-count int` |  maximum number of logs to process at a time (default 100)|
|`--node.rpc.addr string` | RPC address (default "0.0.0.0")|
|`--node.rpc.enable-devops-stubs ` | Enable fake versions of eth_syncing and eth_netPeers|
|`--node.rpc.enable-l1-calls` | If RPC calls which query the L1 node indirectly should be allowed|
|`--node.rpc.max-call-gas uint `| Max computational arbgas limit when processing eth_call and eth_estimateGas (default 5000000)|
|`--node.rpc.nitroexport.basedir string` | Base dir for nitro export|
|`--node.rpc.nitroexport.enable `| Enable rpcs for nitro export (stored locally on node)|
|`--node.rpc.path string` | RPC path (default "/")|
|`--node.rpc.port int` | RPC port (default 8547)|
|`--node.rpc.tracing.enable` | enable tracing api|
|`--node.rpc.tracing.namespace string` | rpc namespace for tracing api (default "arbtrace")|
|`--node.sequencer.continue-batch-posting-block-interval int` | block interval to post the next batch after posting a partial one (default 2)|
|`--node.sequencer.create-batch-block-interval int` | block interval at which to create new batches (default 270)|
|`--node.sequencer.dangerous.disable-batch-posting ` | disable posting batches to L1 (DANGEROUS)|
|`--node.sequencer.dangerous.disable-delayed-message-sequencing`| disable sequencing delayed messages (DANGEROUS)|
|`--node.sequencer.dangerous.disable-user-message-sequencing` | disable sequencing user messages (DANGEROUS)|
|`--node.sequencer.dangerous.publish-batches-without-lockout` | continue publishing batches (but not sequencing) without the lockout (DANGEROUS)|
|`--node.sequencer.dangerous.reorg-out-huge-messages` | erase any huge messages in database that cannot be published (DANGEROUS)|
|`--node.sequencer.dangerous.rewrite-sequencer-address` | reorganize to rewrite the sequencer address if it's not the loaded wallet (DANGEROUS)|
|`--node.sequencer.debug-timing` | log elapsed time throughout core sequencing loop|
|`--node.sequencer.delayed-messages-target-delay int` | delay before sequencing delayed messages (default 12)|
|`--node.sequencer.gas-refunder-address string` | address of the L1 gas refunder contract (optional)|
|`--node.sequencer.gas-refunder-extra-gas uint` | amount of extra gas to supply for the gas refunder operation (default 50000)|
|`--node.sequencer.l1-posting-strategy.high-gas-delay-blocks int` | wait up to this many more blocks when gas costs are high (default 270)|
|`--node.sequencer.l1-posting-strategy.high-gas-threshold float` | gwei threshold at which to consider gas price high and delay batch posting (default 150)|
|`--node.sequencer.lockout.redis string` | sequencer lockout redis instance URL|
|`--node.sequencer.lockout.self-rpc-url string` | own RPC URL for other sequencers to failover to|
|`--node.sequencer.max-batch-gas-cost int` | max L1 batch gas cost to post before splitting it up into multiple batches (default 2000000)|
|`--node.type string` | forwarder, aggregator, sequencer or validator (default "forwarder")|
|`--node.ws.addr string` | websocket address (default "0.0.0.0")|
|`--node.ws.path string` | websocket path (default "/")|
|`--node.ws.port int` | websocket port (default 8548)|
|`--persistent.chain string` | path that chain specific state is located|
|`--persistent.global-config string`                       |         location global configuration is located (default ".arbitrum")|
|`--pprof-enable` | enable profiling server|
|`--rollup.address string` | layer 2 rollup contract address|
|`--rollup.block-search-size int`   | number of blocks to search at a time when looking for validator smart contract wallet creation, 0 to search all blocks at once|
|`--rollup.from-block int` | layer 2 rollup contract creation block|
|`--rollup.machine.filename string` | file to load machine from|
|`--validator.contract-wallet-address string` | validator smart contract wallet public address|
|`--validator.contract-wallet-address-filename string` | json file that validator smart contract wallet address is stored in (default "chainState.json")|
|`--validator.dont-challenge` | don't challenge any other validators' assertions|
|`--validator.l1-posting-strategy.high-gas-delay-blocks int` | wait up to this many more blocks when gas costs are high (default 270)|
|`--validator.l1-posting-strategy.high-gas-threshold float` | gwei threshold at which to consider gas price high and delay batch posting (default 150)|
|`--validator.only-create-wallet-contract` | only create smart contract wallet contract, then exit|
|`--validator.staker-delay duration` | delay between updating stake (default 1m0s)|
|`--validator.strategy string` |   strategy for validator to use|
|`--validator.utils-address string` | validator utilities address|
|`--validator.wallet-factory-address string` | strategy for validator to use|
|`--validator.withdraw-destination string` | the address to withdraw funds to (defaults to the wallet address)|
|`--wait-to-catch-up` | wait to catch up to the chain before opening the RPC|
|`--wallet.fireblocks.feed-signer.password string` | password for feed-signer wallet (default "PASSWORD_NOT_SET")|
|`--wallet.fireblocks.feed-signer.pathname string` | path to store feed-signer wallet in (default "feed-signer-wallet")|
|`--wallet.fireblocks.feed-signer.private-key string` | wallet feed-signer private key string|
|`--wallet.local.only-create-key` | create new wallet and exit|
|`--wallet.local.password string` | password for wallet (default "PASSWORD_NOT_SET")|
|`--wallet.local.pathname string` | path to store wallet in (default "rpc-wallet")|
|`--wallet.local.private-key string` | wallet private key string|
