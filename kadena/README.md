# Kadena node on Akash Network

The Kadena node needs a dedicated IP address. In `deploy.yml`, the standard settings for launch are already prepared.
Replace all values of `your_endpoint_name` with your own, for example `my_kadena_endpoint_name` . It is important that the value is **unique, and also does not contain spaces and consists only of lowercase letters**.

Once the deployment is running, you will be assigned an IP address. Go to `UPDATE` and replace `YOUR_STATIC_IP_ADDRESS` with the IP given to you by your provider. Next, click `UPDATE DEPLOYMENT`.

### Available launch flags in `args:` section:
|Flag|Description|
| :-------: | :-------: |
|`--info`                                    | Print program info message and exit.|
|`--long-info`                               | Print detailed program info message and exit.|
|`-v,--version`                              | Print version string and exit.|
|` --license`                                | Print license of the program and exit.|
|`-?,-h,--help`                              | Show this help message.|
|`--print-config-as`                         | `full/minimal/diff` Print the parsed configuration to standard out and exit.|
|`--print-config`                            | Print the parsed configuration to standard out and exit. This is an alias for `--print-config-as=full`.|
|`--config-file FILE`                        | Configuration file in YAML or JSON format. If more than a single config file option is present files are loaded in the order in which they appear on the command line.|
|`-v,--chainweb-version ARG`                 | The chainweb version that this node is using.|
|`--header-stream`                           | Whether to enable an endpoint for streaming block updates.|
|`--no-header-stream`                        | Unset flag header-stream.|
|`--enable-tx-reintro`                       | Whether to enable transaction reintroduction from losing forks.|
|`--disable-tx-reintro`                      | Unset flag `tx-reintro`.|
|`--p2p-hostname ARG`                        | Hostname for p2p.|
|`--p2p-port ARG`                            | Port number for p2p.|
|`--p2p-interface ARG`                       | Interface that the p2p Rest API binds to (see HostPreference documentation for details) for p2p.|
|`--p2p-certificate-chain ARG`               | PEM encoded X509 certificate or certificate chain of the local peer for p2p.|
|`--p2p-certificate-chain-file FILE`         | File with the PEM encoded certificate chain. A textually provided certificate chain has precedence over a file. for p2p.|
|`--p2p-key ARG`                             | PEM encoded X509 certificate key of the local peer for p2p.|
|`--p2p-certificate-key-file FILE`           | File with the PEM encoded certificate key. A textually provided certificate key has precedence over a file. for p2p.|
|`--p2p-max-session-count ARG`               | Maximum number of sessions that are active at any time.|
|`--p2p-max-peer-count ARG`                  | Maximum number of entries in the peer database.|
|`--p2p-session-timeout ARG`                 | Timeout for sessions in seconds.|
|`--known-peer-info [<PEERID>@]<HOSTADDRESS>`| Peer info that is added to the list of known peers. This option can be used multiple times.|
|`--enable-ignore-bootstrap-nodes`           | When enabled the hard-coded bootstrap nodes for network are ignored.|
|`--disable-ignore-bootstrap-nodes`          | Unset flag `ignore-bootstrap-nodes`.|
|`--enable-private`                          | When enabled this node becomes private and communicates only with the initially configured known peers.|
|`--disable-privat`                          | Unset flag `private`.|
|`--bootstrap-reachability [0,1]`            | The fraction of bootstrap nodes that must be reachable at startup.|
|`--enable-mempool-p2p`                      | Whether mempool-p2p is enabled or disabled.|
|`--disable-mempool-p2p`                     | Unset flag mempool-p2p.|
|`--mempool-p2p-max-session-count ARG`       | Maximum number of sessions that are active at any time.|
|`--mempool-p2p-session-timeout ARG`         | Timeout for sessions in seconds.|
|`--mempool-p2p-poll-interval ARG`           | Poll interval for synchronizing mempools in seconds.|
|`--block-gas-limit ARG`                     | The sum of all transaction gas fees in a block must not exceed this number.|
|`--log-gas`                                 | Log gas consumed by Pact commands.|
|`--no-log-gas`                              | Unset flag `log-gas`.|
|`--min-gas-price ARG`                       | The gas price of an individual transaction in a block must not be beneath this number.|
|`--pact-queue-size ARG`                     | Max size of pact internal queue.|
|`--reorg-limit ARG`                         | Max allowed reorg depth. Consult https://github.com/kadena-io/chainweb-node/blob/master/docs/RecoveringFromDeepForks.md for more information.|
|`--validateHashesOnReplay`                  | Re-validate payload hashes during transaction replay.|
|`--no-validateHashesOnReplay`               | Unset flag `validateHashesOnReplay`.|
|`--allowReadsInLocal`                       | Enable direct database reads of smart contract tables in local queries.|
|`--no-allowReadsInLocal`                    | Unset flag `allowReadsInLocal`.|
|`--rosetta`                                 | Enable the Rosetta endpoints.|
|`--no-rosetta`                              | Unset flag rosetta.|
|`--prune-chain-database`                    | `none/headers/headers-checked/full` How to prune the chain database on startup. This can take several hours.|
|`--cut-fetch-timeout ARG`                   | The timeout for processing new cuts in microseconds.|
|`--initial-block-height-limit INT`          | Reset initial cut to this block height.|
|`--fast-forward-block-height-limit INT`     | When `--only-sync-pact` is given fast forward to this height. Ignored otherwise.|
|`--service-port ARG`                        | Port number for service.|
|`--service-interface ARG`                   | Interface that the service Rest API binds to (see HostPreference documentation for details) for service.|
|`--service-payload-batch-limit ARG`         | Upper limit for the size of payload batches on the service API for service.|
|`--enable-mining-coordination`              | Whether to enable the mining coordination API.|
|`--disable-mining-coordination`             | Unset flag `mining-coordination`.|
|`--mining-public-key ARG`                   | Public key of a miner in hex decimal encoding. The account name is the public key prefix by 'k:'. (This option can be provided multiple times.).|
|`--mining-request-limit ARG`                | Number of /mining/work requests that can be made within a 5min period.|
|`--mining-update-stream-limit ARG`          | Maximum number of concurrent update streams that is supported.|
|`--mining-update-stream-timeout ARG`        | Duration that an update stream is kept open in seconds.|
|`--enable-node-mining`                      | ONLY FOR TESTING NETWORKS: whether to enable in node mining.|
|`--disable-node-mining`                     | Unset flag `node-mining`.|
|`--node-mining-public-key ARG`              | Public key of a miner in hex decimal encoding. The account name is the public key prefix by 'k:'. (This option can be provided multiple times.).|
|`--only-sync-pact`                          | Terminate after synchronizing the pact databases to the latest cut.|
|`--no-only-sync-pact`                       | Unset flag `only-sync-pact`.|
|`--sync-pact-chains`                        | JSON list of chain ids The only Pact databases to synchronize. If empty or unset, all chains will be synchronized.|
|`--enable-backup-api`                       | Whether backup-api is enabled or disabled.|
|`--disable-backup-api`                      | Unset flag `backup-api`.|
|`--backup-directory ARG`                    | Directory in which backups will be placed when using the backup API endpoint for backup.|
|`--module-cache-limit INT`                  | Maximum size of the per-chain checkpointer module cache in bytes.|
|`--queue-size INT`                          | Size of the internal logger queue.|
|`--log-level`                               | `quiet/error/warn/info/debug` threshold for log messages.|
|`--log-policy`                              | `block/raise/discard` how to deal with a congested logging pipeline.|
|`--exception-limit INT`                     | Maximal number of backend failures before and exception is raised.|
|`--exception-wait INT`                      | Time to wait after an backend failure occured.|
|`--exit-timeout INT`                        | Timeout for flushing the log message queue on exit.|
|`-c,--color ARG`                            |Whether to use ANSI terminal colors in the output.|
|`--log-format`                              | `text/json` format that is use for writing logs to file handles.|
|`-log-handle`                               | `stdout/stderr/file:<FILENAME>/es:[APIKEY]:<URL>` handle where the logs are written.|
|`--enable-telemetry-logger`                 | Whether telemetry-logger is enabled or disabled.|
|`--disable-telemetry-logger`                | Unset flag `telemetry-logger`.|
|`-c,--telemetry-color ARG`                  | Whether to use ANSI terminal colors in the output.|
|`--telemetry-log-format`                    | `text/json` format that is use for writing logs to file handles.|
|`--telemetry-log-handle`                    | `stdout/stderr/file:<FILENAME>/es:[APIKEY]:<URL>` handle where the logs are written.|
|`--cluster-id ARG`                          | A label that is added to all log messages from this node.|
|`--log-filter-rule`                         | `KEY:VALUE:LOGLEVEL[:RATE]` A log filter rule. Log messages with matching scope are discarded if they don't meet the log level threshold.|
|`--log-filter-default`                      | `LOGLEVEL:RATE` default log filter, which is applied to all messages that don't match any other filter rule.|
|`--database-directory ARG`                  | Directory where the databases are persisted.|
|`--enable-reset-chain-databases`            | Reset the chain databases for all chains on startup.|
|`--disable-reset-chain-databases`| Unset flag `reset-chain-databases`.|
