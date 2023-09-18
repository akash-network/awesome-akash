# Bminer: When Crypto-mining Made Fast

Bminer is a highly optimized cryptocurrency miner that runs on modern AMD / NVIDIA GPUs. Bminer is one of the fastest publicly available miners today -- we use various techniques including tiling and pipelining to realize the full potentials of the hardware.

## Usage

```
Bminer supports the following options in the command line. You can also run bminer -help to get the full list of options.
Option
    Default     Description
-api string     null    The endpoint that Bminer serves its REST API. For example, 127.0.0.1:1880. The REST API is disabled if it is unspecified.
-devices value  null    List of GPU devices that Bminer should run on. If it is unspecified bminer runs on all CUDA devices available on the system.
-failover value     immediateNext   Fail-over strategy between multiple pools. Bminer can retry the connection, failover to the next pool or a pool that is randomly chosen in the lists of available pools. Supported strategies are sameHost, immediateNext and random.
-gpucheck uint  90  The interval in seconds that Bminer polls whether the CUDA devices have hung. Set to 0 to disable the checks.
-logfile string     null    Append the logs to the file.
-max-network-failures   -1  Number of consecutive attempts that Bminer tries to recover from network failures. Set to -1 to keep on recovering.
-max-temperature int    85  Hard limits of the temperature of the GPUs. BMiner slows down itself when the temperautres of the devices exceed the limits.
-no-runtime-info        Disable runtime information collection for Bminer.
-no-timestamps      Remove timestamp in your logging messages.
-nofee      Disable the devfee but it also disables some optimizations.
-pers   BgoldPoW    Personalization string for Equihash 144,5 based coins. Can be set to auto.
-share-check    900     The interval of seconds that Bminer polls to ensure there are accepted shares. Set to 0 to disable the checks.
-strict-secure      Verify the certificates of servers when connecting to a SSL-enabled Stratum server. The default is off.
-uri value      List of comma-separated URIs that bminer should mine towards. URI has a format of <scheme>://<username>[:<password>]@<host>:<port>. Note that the <scheme> for all the URIs have to be the same.
-uri2 value         List of comma-separated URIs that bminer should mine towards secondarily. It has the format of <scheme>://<username>[:<password>]@<host>:<port>. Currently Bminer supports scheme blake14r:// or blake2s:// as secondary for Ethash mining as primary.
-dual-subsolver int     -1  The sub-solver for dual mining. Valid values are 0, 1, 2, 3. Default is -1, which is to tune automatically.
-dual-intensity int     0   The intensity of the secondary mining. Valid values are from 0 to 300. Default is 0, which is to tune automatically.
-intensity  6   The CPU intensity of mining AE / Grin. Valid values are from 0 to 12.
-watchdog   true    Automatic restart to recover from hung GPUs. Bminer exits itself in case of errors if watchdog is disabled.
-version        Output version and exit.
```

## Specfying URIs

Bminer uses URIs to identify the mining pool and the account of the pool. The URIs has the format of <scheme>://<username>[:<password>]@<host>:<port>. Following RFC 3986, the scheme specifies both the proof-of-work (PoW) algorithm and the networking protocol. Bminer supports mining coins using the following PoW algorithm and protocols:
```
PoW algorithm   Networking protocol     Scheme
* Equihash  Stratum     stratum://
* Equihash  Stratum over SSL    stratum+ssl://
* Equihash 144,5    Stratum     equihash1445://
* Equihash 144,5    Stratum over SSL    equihash1445+ssl://
* Zhash     Stratum     zhash://
* Zhash     Stratum over SSL    zhash+ssl://
* Ethash    Stratum     ethash://
* Ethash    Stratum over SSL    ethash+ssl://
* Ethash    Ethereum Proxy  ethproxy://
* Ethash    Ethereum Stratum    ethstratum://
* Blake14r (secondary)  Stratum     blake14r://
* Blake2s (secondary)   Stratum     blake2s://
```

Bminer also supports failing over between multiple pools in case of network failures. To enable the feature, you can pass a lists of URIs that are separate by commas. For example, the following command

```
./bminer -uri stratum://t1ZBtpkUy1y1deYsNJnzdW4tk7HiJEcfUzr.worker@eu1-zcash.flypool.org:3333,
stratum://t1ZBtpkUy1y1deYsNJnzdW4tk7HiJEcfUzr.worker@zec-eu1.nanopool.org:6666
```
will instruct Bminer to mine Zcash over both Flypool and Nanopool.

## Bminer also comes with REST APIs to facilitate production deployments (e.g., mining farms).

    Bminer supports mining Equihash-based coins (e.g., BitcoinGold, BitcoinZ) with 2% of devfee.
    Bminer supports mining Ethash-based coins (e.g., Ethereum) with 0.65% of devfee. It is also possible to dual mine Ethash and Blake14r-based / Blake2s-based coins, where the devfee is 1.3%.
    Bminer supports mining Bytom (BTM) with 2% of devfee.
    Bminer supports mining Grin (GRIN) with 1% of devfee.

## Features

    Fast and efficient
        Bminer is one of the fastest miner on a number of algorithms.
    Secure and reliable
        SSL support
        Automatic reconnects to recover from transient network failures
        Automatic restarts if GPUs hang
    Operation friendly
        Comes with REST APIs to facilitate large-scale production deployments
