## Config Generator
Having troubles figuring out how to configure BzMiner?
Try the config generator:
https://www.bzminer.com/config-generator

## Why use BzMiner (v16.0.3)?
- Stable 100% LHR Unlock v1! (Tested on windows/linux drivers 465-511, see below)
- Supported Algos:
    - Ethw (AMD, Nvidia, 0.5% dev fee)
    - Etchash (AMD, Nvidia, 0.5% dev fee) 
    - Ergo (AMD, Nvidia, 1% dev fee) 
    - Rvn (AMD, Nvidia, 1% dev fee)
    - Meowcoin (AMD, Nvidia, 1% dev fee)
    - Neoxa (AMD, Nvidia, 1% dev fee)
    - Gamepass (AMD, Nvidia, 1% dev fee)
    - Clore (AMD, Nvidia, 1% dev fee)
    - Neurai (xna) (AMD, Nvidia, 1% dev fee)
    - Olhash (AMD, Nvidia, 1% dev fee)
    - Alephium (AMD, Nvidia, 0.5% dev fee)
    - Kaspa (AMD, Nvidia, 1% dev fee, +1% community fund can be optionally be enabled with community_fund options, disabled by DEFAULT)
    - Radiant (AMD, Nvidia, 1% dev fee, +1% community fund can be optionally be enabled with community_fund options, disabled by DEFAULT)
    - Ixian (AMD, Nvidia, 1% dev fee, Not optimized for ubuntu 16.04)
    - Woodcoin (AMD, Nvidia, 1% dev fee, use config "algo_opt" to move some processing to cpu)
    - Zil (AMD, Nvidia, 0% dev fee. Dual with ANY other coin)
    - Nexa (AMD, Nvidia, 2% dev fee, +1% community fund can be optionally be enabled with community_fund options, disabled by DEFAULT)
    - Ironfish (AMD, Nvidia, 1% dev fee)
    - Kylacoin (AMD, Nvidia, 1% dev fee)
    - Novo (AMD, Nvidia, 1% dev fee)
    - Octa (AMD, Nvidia, 0.5% dev fee)
    - Canxium (AMD, Nvidia, 0.5% dev fee)
    - Rethereum (AMD, Nvidia, 1% dev fee)
- Optimized dual mining for specific coins:
    - **Note**: Bz was designed around running multiple algos on a single gpu, so ALL algos can be mined together, these are just "optimized" combos
    - Octa + Alph (Nvidia only, experimental)
    - Octa + Kaspa (Nvidia only, experimental)
    - Octa + Radiant (Nvidia only, experimental)
    - Octa + Ironfish (Nvidia only, experimental)
    - Ethw + Alph (Nvidia only, experimental)
    - Ethw + Kaspa (Nvidia only, experimental)
    - Ethw + Radiant (Nvidia only, experimental)
    - Ethw + Ironfish (Nvidia only, experimental)
    - Etc + Alph (Nvidia only, experimental)
    - Etc + Kaspa (Nvidia only, experimental)
    - Etc + Radiant (Nvidia only, experimental)
    - Etc + Ironfish (Nvidia only, experimental)
    - Ergo + Kaspa (Nvidia only, experimental)
    - Ergo + Radiant (Nvidia only, experimental)
    - Any Algo + Zil (AMD, Nvidia)
- Supports Chinese Language (use `--lang cn` option)
- Realtime console inputs!
- Core Temp, Memory Temp, and Power Limit throttling (slowdown) notifications
- Nvidia GPU memory temperature monitoring on Linux and Windows
- Improved LHR Strategy dual/multi coin mining (ethash+kawpow, ethash+ol, ethash+alph)
- Multi coin mining supports three different strategies; Parallel mining, Alternate mining, DAG gen only mining
- Can overclock per algorithm when alternating multi coin mining
- Set Overclocks PER multi mine algo!
- Control algorithm/pool/wallet mining PER device, as well as Multi-coin mining on a single GPU
- Awesome Easy to use Linux and Windows miner (GUI available through browser)
- Hung GPU detection
- Watchdog service which automatically restarts BzMiner if anything goes wrong (such as a hung gpu)
- Customizable display
- Memory junction temperature monitoring (windows only)
- HTTP API!
- Remote management of all mining rigs on your network
- Fast Cuda v11 and OpenCL miner
- Constantly being improved based on feedback from you!
- Ability to OC in miner (OC's are removed during DAG generation to prevent invalid DAG generation)
- Advanced mining features, including cooldown, ramp up, dual/multi coin mining
- DAG Validation for very high OC cards
- Auto intensity, dyanamically adjusts gpu workloads, reducing stales while keeping hashrate high
- Ubuntu 16.04 support
- GDDR5 Memory Tweak (`--oc_mem_tweak`). Levels 1 - 3
- TBS Watchdog (monitors time since last share and resets gpus/reconnects to pools if too long)

## 100% LHR Unlock v1
BzMiner v9.1.0 introduced a 100% LHR unlocker, which was only semi-stable. v9.1.3 has much higher stability and hashrate.

If a card becomes unstable (eg. lhr exception), lower overclocks, and lower `--lhr_stability`.

`--lhr_stability` has an impact on both hashrate and stability of the LHR unlock. Higher values will increase hashrate, but may cause GPUs to crash. Lower values are more stable, but may cause LHR to trigger momentarily, lowering hashrate a little. Play with it.

To disable the LHR unlocker, set `--lhr_stability` to 0. Default is 100.

The LHR unlock can sometimes trigger an "LHR Exception". If this happens, lower the `--lhr_stability` option. This "exception" will allow the device to continue mining, but at a much slower speed. It requires a hard device reset to recover, which means restarting the pc. BzMiner provides the `--lhr_exception` option, which if set to true and a card experiences the LHR exception, will reboot the pc.

## Prerequisites
- Windows:
  - Requires Nvidia drivers supporting Cuda 11.2 or greater (Nvidia driver >= 460.27.03)
  - AMD OpenCL drivers 21.50.2 or higher
- Linux:
  - Nvidia driver >= 460.27.03
  - AMD OpenCL drivers 21.50.2 or higher

## Mining OS's that include BzMiner
- MMPOS - https://app.mmpos.eu/
- HiveOS - https://hiveos.farm/
- Minerstat - https://minerstat.com/
- RaveOS - https://raveos.com/
- OkminerOS - https://okminer.com/

## Discord Server
https://discord.gg/83EHruNzrh

## Official Website
http://www.bzminer.com


## Requirements
- At least one Nvidia GPU and Nvidia drivers
- Or at least one AMD GPU and AMD drivers

## Quick Start
Launch `bzminer` with the wallet and pool address as parameters:

```
bzminer -w 0x0000000000000000000000000000000000000000 -p ethstratum+tcp://eth.geodns.flexpool.io:4444 -r worker_name --nc 1
```

You may provide more than one pool address to -p for fallback pools on network errors:
```
bzminer -w 0x0000000000000000000000000000000000000000 -p ethstratum+tcp://eth.geodns.flexpool.io:4444 stratum+tcp://usw-eth.hiveon.net:4444 -r worker_name --nc 1
```

Optionally you can edit `config.txt` and launch `bzminer`. You can specify the config file with the `-c` argument:

```
bzminer -c eth-config.txt
```

### Ethw (EthPOW)

```
bzminer -a ethw -w 0x0000000000000000000000000000000000000000 -p ethproxy+tcp://pool.woolypooly.com:3096 -r worker_name --nc 1
```

### Ethereum Classic

```
bzminer -a etchash -w 0x0000000000000000000000000000000000000000 -p stratum+tcp://us1-etc.ethermine.org:4444 stratum+tcp://eu1-etc.ethermine.org:4444 -r worker_name --nc 1
```

### Ergo

```
bzminer -a ergo -w 0x0000000000000000000000000000000000000000 -p stratum-ergo.flypool.org:3333 -r worker_name --nc 1
```

### Ravencoin

```
bzminer -a rvn -w 0x0000000000000000000000000000000000000000 -p stratum+ssl://stratum-ravencoin.flypool.org:3443 -r worker_name --nc 1
```

### Neoxa

```
bzminer -a neox -w 0x0000000000000000000000000000000000000000 -p neox-eu.minerpool.org:10059 -r worker_name --nc 1
```

### Clore

```
bzminer -a clore -w 0x0000000000000000000000000000000000000000 -p stratum+ssl://stratum-eu.rplant.xyz:17083 -r worker_name --nc 1
```

### Neurai

```
bzminer -a xna -w 0x0000000000000000000000000000000000000000 -p stratum+ssl://stratum-eu.rplant.xyz:17029 -r worker_name --nc 1
```

### Nexa

woolypooly
```
bzminer -a nexa -w 0x0000000000000000000000000000000000000000 -p stratum+tcp://pool.ca.woolypooly.com:3124 -r worker_name --nc 1
```

pool137
```
bzminer -a nexa -w 0x0000000000000000000000000000000000000000 -p stratum+tcp://eu.nexa.pool137.io:3333 --nc 1
```

Nexa solo:
```
bzminer -a nexa -w 0x0000000000000000000000000000000000000000 -p solo+tcp://127.0.0.1:7227 -r worker_name --nc 1
```

### Meowcoin

```
bzminer -a meowcoin -w 0x0000000000000000000000000000000000000000 -p stratum-eu.rplant.xyz:17078 -r worker_name --nc 1
```

### Gamepass

```
bzminer -a gamepass -w 0x0000000000000000000000000000000000000000 -p stratum+ssl://stratum-eu.rplant.xyz:17041 -r worker_name --nc 1
```

### Radiant

```
bzminer -a radiant -w 0x0000000000000000000000000000000000000000 -p stratum+tcp://rxd.vipor.net:5066 -r worker_name --nc 1
```

### Overline

```
bzminer -a olhash -w 0x0000000000000000000000000000000000000000 -p ethproxy+ssl://us.extremehash.net:3443 ethproxy+ssl://eu-ol.extremehash.net:3443 -r worker_name --nc 1
```

### Alephium

Alephium mining may require 4 wallet addresses (solo mining)

For solo mining change "stratum" to "alphstratum"

```
bzminer -a alph -w 000000 -p stratum+tcp://eu.metapool.tech:20032 alphstratum+tcp://185.71.66.100:10159 --nc 1
```

### Kaspa

Kaspa mining currently requires a node running (experimental pool implementation provided in BzMiner)

For solo mining, use node+tcp

```
bzminer -a kaspa -w 000000 -p node+tcp://127.0.0.1:16110
```

For pool mining change "node" to "stratum"

```
bzminer -a kaspa -w 000000 -p stratum+tcp://pool.us.woolypooly.com:3112
```

### Ixian

Solo and pool both use the GetWork http/https protocol

```
bzminer -a ixi -w 000000 -p http://ixian.changeling.biz:8081
```

### Woodcoin

dragonpool.vip:

```
bzminer -a woodcoin -w 0000 -p stratum+tcp://dragonpool.vip:5233 --pool_password c=LOG,d=1,ID=rig_name
```

### Octa

vipor.net:

```
bzminer -a octa -w 0000 -p ethproxy+ssl://us.vipor.net:5104  --nc 1
```

### Kylacoin

Vipor:

```
bzminer -a kylacoin -w 0000 -p stratum+tcp://pool.vipor.io:15020 --nc 1
```

### Novo

Vipor:

```
bzminer -a kylacoin -w 0000 -p pool.vipor.io:15075 --nc 1
```

### Ironfish

Flexpool:

```
bzminer -a ironfish -w 0000 -p stratum+tcp://iron.fpmp.net:8888 --nc 1
```

How to solo mine Ironfish:

- follow guide at https://ironfish.network/docs/onboarding/iron-fish-tutorial to install ironfish
- run the ironfish node using the command `ironfish start`
- run the ironfish pool using the command `ironfish miners:pools:start`
- if your node is on a separate pc from bz, replace 127.0.0.1 with the ip address of the pc the node is running on (eg. 192.168.1.2)

```
bzminer -a ironfish -w 0000 -p 127.0.0.1:9034 --nc 1
```

### Dual Mining (eth + alph)

```
bzminer -a ethash -w 000000 -p stratum+tcp://us1.ethermine.org:4444 --a2 alph --w2 000000 --p2 stratum+tcp://eu.metapool.tech:20032
```

### Zil

Zil is only able to be mined during certain times of the day, so it's usually an algo you want to dual or triple mine with

```
bzminer -a zil -w 0000 -p zmp://zil.flexpool.io
```

### Zil dual mining

Zil can be mined with any other algo. Example below shows Erg + Zil

```
bzminer -a ergo -w 0000 -p stratum-ergo.flypool.org:3333 --a2 zil --w2 1111 --p2 zmp://zil.flexpool.io
```

### Zil triple mining

Zil can be mined with any other dual combo. Example below shows Erg + Kaspa + Zil

```
bzminer -a ergo -w 0000 -p stratum-ergo.flypool.org:3333 --a2 kaspa --w2 1111 --p2 stratum+tcp://pool.woolypooly.com:3112 --a3 zil --w3 2222 --p3 zmp://zil.flexpool.io
```

### OC Change on Algo Switch (eg. +zil)
Bzminer supports changing the overclocks for gpus between algo changes. A common example of this is doing a core algo like kaspa and a memory hard algo like zil, where each algo wants a different oc for best performance. This can be done from the command line or from config.txt.

From the command line, you will set the `oc_` options for the first algo (kaspa), and `oc_...2` options for the second algo. When the second algo starts, it will apply it's oc to the card. when it ends, it will apply the first algos oc. Example:

```
bzminer -a kaspa -w 0000 -p stratum+tcp://pool.woolypooly.com:3112 --a2 zil --w2 1111 --p2 zmp://zil.flexpool.io --oc_fan_speed 100 --oc_core_clock_offset 100 --oc_lock_memory_clock 810 -- oc_power_limit 200 --oc_fan_speed2 100 --oc_core_clock_offset2 -100 --oc_lock_memory_clock2 0 --oc_memory_clock_offset 1000 --oc_power_limit2 200 --oc_delay_ms 50
```

Current BzMiner supports overclocking for Nvidia only, but provides an option called `oc_script` which allows you to call a script to use a third party software to set the oc, which is useful for AMD cards.

### oc_script option
The oc_script option will be called wheneve the oc is set for a particular GPU. If this option is specified, all other oc_ options are ignored.

The script is called with parameters `--gpu_index {gpu index} --gpu_id {gpu id} --algo {algorithm oc is being set for}`. for example:
```
ocscript.bat --gpu_index 0 --gpu_id 1:0 --algo zil
```
This is also useful when you have many rigs with different gpu's. you can create a profile in your mining os's interface for all your rigs, and give each rig its own script to set oc's for

You can change the multi mining type using the `multi_mine_type` option in the command line. By default its set to 0 for parallel mining, but can be set to 1 for alternate mining or 2 for mine only during DAG generation

BzMiner has a couple "optimized" combinations. These are below:
    - Ethw + Alph (Nvidia only, experimental)
    - Ethw + Kaspa (Nvidia only, experimental)
    - Ethw + Radiant (Nvidia only, experimental)
    - Etc + Alph (Nvidia only, experimental)
    - Etc + Kaspa (Nvidia only, experimental)
    - Etc + Radiant (Nvidia only, experimental)
    - Ergo + Kaspa (Nvidia only, experimental)
    - Ergo + Radiant (Nvidia only, experimental)

## Console Input
BzMiner supports a couple console input actions:
- `Esc` - Shuts down BzMiner
- `Space` - Refresh console output
- `Arrow Keys` - Adjust intensity, up/down first algo, left/right second algo

## GUI
The GUI desktop app has been discontinued as of v4.3 in favor of the browser gui, which can be accessed by opening `index.html`, or by navigating to `http://your-rigs-ip:port/` in your favorite browser.

The GUI will display (and allow you to navigate to) other rigs running BzMiner. This is done through a UDP broadcast message which can be disabled on instances of BzMiner by setting "disable_udp" to true in the config file. 

![image](https://user-images.githubusercontent.com/83083846/147267304-8357dd99-1638-4d83-a41a-0ebabd01cd4b.png)


## CLI
BzMiner is a command line interface. Simply update `config.txt` and launch `bzminer`.

`bzminer` has an optional parameter, `-c`, which can be called to load a different configuration file. eg. `bzminer -c custom_config.txt`.

`bzminer` also has optional parameters for setting the pool url, wallet address, algorithm and rig/worker name for all devices

```
>bzminer --help
BzMiner - Advanced Crypto Miner
Usage: bzminer [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  --version                   Get the version of this binary
  --lang TEXT                 Set the language (en, cn). Default en
  -a TEXT                     Default Mining algorithm. eg. 'ethash'
  --a2 TEXT                   Default second Mining algorithm (dual mine). eg. 'ethash'
  --a3 TEXT                   Default third Mining algorithm (tri mine, also zil + dual). eg. 'zil'
  -r TEXT                     Default Rig (worker/username) name. eg. 'Rig'
  --r2 TEXT                   Default Pool username for second algo (dual mine)
  --r3 TEXT                   Default Pool username for third algo (tri mine, also zil + dual)
  --temp_stop INT             Temperature to pause mining on a device (should be higher than temp_start)
  --temp_start INT            Temperature to start mining on a device again (should be lower than temp_stop)
  --pool_password TEXT        Default Pool password
  --pool_password2 TEXT       Default Pool password for second algo (dual mine)
  --pool_password3 TEXT       Default Pool password for second algo (dual mine)
  --igpu BOOLEAN              Enable IGPU (0 = false, 1 = true, default 0)
  --nvidia INT                Mine with Nvidia devices (0 = false, 1 = true, 1 is default)
  --amd INT                   Mine with AMD devices (0 = false, 1 = true, 1 is default)
  --intel INT                 Mine with Intel devices (0 = false, 1 = true, 0 is default)
  --disable_opencl            Disable OpenCL. Useful for BzMiner crashing during startup due to AMD drivers.
  --nvidia_opencl             Enable Nvidia opencl device enumeration
  -w TEXT ...                 Wallet Address. If algorithm requires more than one address, list them same as -p
  --w2 TEXT ...               Wallet Address for second algo (dual mine). If algorithm requires more than one address, list them same as -p
  --w3 TEXT ...               Wallet Address for third algo (tri mine, also zil + dual). If algorithm requires more than one address, list them same as -p
  -p TEXT ...                 Array of Pool Addresses. eg. stratum+tcp://us1.ethermine.org:4444  stratum+tcp://us2.ethermine.org:4444
  --p2 TEXT ...               Array of Pool Addresses for second algo (dual mine). eg. stratum+tcp://us1.ethermine.org:4444  stratum+tcp://us2.ethermine.org:4444
  --p3 TEXT ...               Array of Pool Addresses for third algo (tri mine, also zil + dual). eg. zmp+tcp://zil.flexpool:4444 ethproxy+tcp://us-east.ezil.me:5555
  -v INT                      Set log verbosity. 0 = Error, 1 = warn, 2 = info 3 = debug, 4 = network
  --hide_disabled_devices     Do not log devices that are disabled.
  --max_log_history INT       For http api. max retained log history. default is 1024. Higher values increase memory usage.
  --log_solutions INT         If 1 (default 1), Solutions will be logged in output (as green).
  --log_date INT              If 1 (default 0), the current date/time will be logged at the start of every line of output.
  --immediate_log             If specified, logger will immediately output logs. This can have a small impact on performance.
  --log_frequency_ms INT      Log frequency in milliseconds. Default is 500.
  -o TEXT                     If provided, output will be logged to this file
  --log_file_verbosity INT    Set log file verbosity. Default 2.
  --clear_log_file INT        If 1 (default 0), BzMiner will overwrite the log file on start.
  -c TEXT                     Config file to load settings from. Default is config.txt
  -i INT                      Set mining intensity (0 - 64). 0 = auto. Higher means more gpu spends more time hashing. Default is 0.
  --i1 INT                    Set mining intensity (0 - 64). 0 = auto. Higher means more gpu spends more time hashing. Default is 0.
  --i2 INT                    Set mining intensity for second algo (dual mine) (0 - 64). 0 = auto. Higher means more gpu spends more time hashing. Default is 0.
  --i3 INT                    Set mining intensity for third algo (tri mine, also zil + dual) (0 - 64). 0 = auto. Higher means more gpu spends more time hashing. Default is 0.
  --lhr_stability INT ...     Set the LHR Unlock Stability value for each device. Lower is more stable, higher is less stable and higher hashrate. Default is 100.
  --lhr_exception_reboot      Reboot the pc when an LHR exception happens on a device (device hard reset currently requires pc reboot).
  --allow_stales BOOLEAN      If 0 (default 1), BzMiner will prevent stales from being sent to the pool.
  --throttle INT ...          Throttle mining on pool 1 (array of devices, or just one value to set all to same). default is 0.
  --throttle1 INT ...         Throttle mining on pool 1 (array of devices, or just one value to set all to same). default is 0.
  --throttle2 INT ...         Throttle mining on pool 2 (array of devices, or just one value to set all to same). default is 0.
  --throttle3 INT ...         Throttle mining on pool 3 (array of devices, or just one value to set all to same). default is 0.
  --mem_on_demand INT ...     An array of devices that should allocate memory (luts, dags) only when they are needed, then releasing that memory after they are no longer needed. Useful for cards that cannot hold two algos memory allocations at the same time such as nexa + zil on 8gb cards. Default is 0
  -g INT                      Ramp up miner rather than start at full speed.
  -b INT                      Cooldown period. 0 = disabled. Higher value means longer time between cooldown periods. default is 0
  --repair_dag INT            Validate and repair DAG. Default is 1
  --nc INT                    Do not save to the config file (but still read from it).
  --show_pending              Do not start watchdog service.
  --update_frequency_ms INT   Output frequency in milliseconds. 0 = disabled. Default is 15000.
  --update_frequency_shares INT
                              Output frequency based on new shares found. 0 = disabled. Does not replace update_frequency_ms, works in parallel. set update_frequency_ms to 0 if you only want to use update_frequency_shares. Default is 0.
  --avg_hr_ms INT             Hashrate averaging window. Longer is more stable hashrate reporting. Default is 30000.
  --disable_index_html        Disable creating index.html file
  --extra_dev_fee FLOAT       Add a little extra time for dev fee (percentage). Adds to default dev fee. Default 0.0
  --cpu_validate INT          Validate solutions on cpu before sending to pool.
  --multi_mine_ms INT ...     Time (ms) to mine each algo when dual mining.
  --multi_mine_type INT ...   Multi mine type. 0 = parallel, 1 = alternating (can oc per algo), 2 = mine only during DAG generation. default = 0
  --max_dual_autotune_drop FLOAT
                              Max hashrate drop of first algo in dual mining when autotuning. 0.0 - 1.0. default 0.92.
  --cache_dag INT             Useful for eth + zil. 0 = disabled (default), 1 = dag cached in vram (only supported on >6gb cards)
  --zil_only                  Only mine zil for the first algo (for zil + non-eth algo). Will set for first pool_config. Will only generate a dag for epoch 0 (zil). use in combination with --multi_mine_type 1, --multi_mine_ms 0 10000 and cache_dag 1
  --zil_retain_hashrate BOOLEAN
                              Continue showing last zil hashrate outside the zil window. This may result in OS's showing a hashrate for zil outside the window as well
  --zil_gpus INT ...          list if gpu indexes for which cards to mine zil. If not specified, all gpus by default will mine zil.
  --force_algo TEXT           Force an algorithm to run. Useful for OS's that do not currently have the desired algo implemented in integration scripts
  --force_algo2 TEXT          Force an algorithm to run as the second algo in dual. Useful for OS's that do not currently have the desired algo implemented in integration scripts
  --opencl_workgroup_size INT Force an opencl algorithm to use a specific workgroup size.
  --community_fund INT        Enable/Disable community fund (currently kaspa and radiant only). Value is a multiple of normal dev fee, so value of 1 = 1% donation, 2 = 2% donation, etc. Default is 1, 0 is disabled
  --algo_opt INT ...          A list (one per device) of whether to use algorithm optimizations if the algo supports it.
  --test INT                  Test mine. Useful for setting up overclocks.
  --testdiff INT              Test difficulty. 1 - lowest difficulty, no limit to max difficulty
  --pool_reconnect_timeout_ms INT
                              Pool reconnect timeout override in ms. default is 30000
  --http_enabled INT          Enable or disable HTTP API. 0 = disabled, 1 = enabled Default is enabled.
  --http_address TEXT         Set IP address for HTTP API to listen on. Default is 0.0.0.0.
  --http_port INT             Set which port the HTTP API listens on. default is 4014.
  --http_password TEXT        Set password for HTTP API. If not set, HTTP API will not be enabled. default is empty.
  --force_opencl INT          Force all devices to use the OpenCL implementation (if possible).
  --reset_oc_dag_gen INT      Reset overclocks before dag generation. Clocks will be set back after dag is generated. 1 = enabled, 0 = disabled
  --devices                   Only log devices. Does not start miner
  --no_watchdog               Do not start watchdog service.
  --disable TEXT ...          Disable specific GPUs from mining, separate by a space. Use device id in the format of pci_bus:pci_device (eg. --disable 1:0 3:0). use --devices to find device id.
  --enable TEXT ...           Enable specific GPUs from mining, separate by a space. This overrides --disable. Use device id in the format of pci_bus:pci_device (eg. --enable 1:0 3:0). use --devices to find device id.
  --advanced_config INT       If 1 (default 0), advanced config options will be showin in config.txt.
  --start_script TEXT         If specified, this script will run when BzMiner starts.
  --hung_gpu_ms INT           When GPU does not respond for this amount of time (ms), will be considered hung.
  --crash_script TEXT         When hung GPU is detected, this script will run.
  --hung_gpu_reboot INT       If 1 (default 0), BzMiner will reboot the rig when a hung GPU is detected.
  --hung_gpu_restart_bzminer INT
                              If 1 (default 1), and watchdog is enabled, watchdog will restart BzMiner process when hung GPU is detected.
  --reboot_after_watchdog_restarts INT
                              Reboot PC after watchdog restarts x number of times
  --restart_miner_minutes INT If specified and greater than 0, BzMiner watchdog will restart BzMiner process after this amount of time (minutes).
  --reboot_minutes INT        If specified and greater than 0, BzMiner will reboot the rig after this amount of time (minutes).
  --no_color INT              If 1 (default 0), output in console will not have color.
  --webhook_discord_url TEXT  Discord webhook api url
  --webhook_discord_solutions_only INT
                              If true, only solutions will be sent to this webhook
  --webhook_discord_interval_ms INT
                              How often to send the logs to discord
  --webhook_discord_verbosity INT
                              verbosity of discord web hook. default is 2
  --oc_delay_ms INT ...       Time (ms) to delay algo switch before/after oc changed for algo. default 50.
  --oc_enable INT ...         Whether oc should be set for the first algo or not (per device). Default is 1.
  --oc_fan_speed TEXT ...     Set the target fan speed (as percentage) for devices, separated by a space. 0 = auto, -1 = ignore, 100 = max.
                              Optionally use target temperature format, eg. --oc_fan_speed t:N[fMin-fMax]
                              where t is core, tm is mem , N is target temp, fMin is min fan speed percent, fMax is max fan speed percent
                              eg. --oc_fan_speed t:65[25-75] tm:85[50-100]
  --oc_power_limit INT ...    Set the power limite for devices (in watts), separated by a space. 0 = ignore.
  --oc_core_clock_offset INT ...
                              Set the target core clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_memory_clock_offset INT ...
                              Set the target memory clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_core_volt_offset INT ...
                              Set the target core voltage offset (in mv) for devices, separated by a space. 0 = ignore. 
  --oc_memory_volt_offset INT ...
                              Set the target memory voltage offset (in mv) for devices, separated by a space. 0 = ignore.
  --oc_lock_core_clock INT ...
                              Lock the core clock for devices (in mhz), separated by a space. Overrides oc_core_clock.
  --oc_lock_memory_clock INT ...
                              Lock the memory clock for devices (in mhz), separated by a space. Overrides oc_memory_clock.
  --oc_pstate INT ...         Force a specific pstate. default is -1, will not change pstate
  --oc_script TEXT ...        Instead of BzMiner setting oc's for a card/algo, call a script instead when oc needs to be set.
                               script is called with parameters --gpu_index {gpu index} --gpu_id {gpu id} --algo {algorithm oc is being set for}
                               eg.
                               'oc_script.bat --gpu_index 0 --gpu_id 1:0 --algo kaspa`
                               BzMiner will call this script for each gpu that needs oc to be set. If this parameter is specified, BzMiner will not set any overclocks on it's own. Can pass an array of scripts, one for each gpu. Default is empty string
  --oc_enable2 INT ...        Whether oc should be set for the second algo or not (per device). Default is 1.
  --oc_fan_speed2 TEXT ...    (second algo) Set the target fan speed (as percentage) for devices, separated by a space. 0 = auto, -1 = ignore, 100 = max.
                              Optionally use target temperature format, eg. --oc_fan_speed t:N[fMin-fMax]
                              where t is core, tm is mem , N is target temp, fMin is min fan speed percent, fMax is max fan speed percent
                              eg. --oc_fan_speed t:65[25-75] tm:85[50-100]
  --oc_power_limit2 INT ...   (second algo) Set the power limite for devices (in watts), separated by a space. 0 = ignore.
  --oc_core_clock_offset2 INT ...
                              (second algo) Set the target core clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_memory_clock_offset2 INT ...
                              (second algo) Set the target memory clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_core_volt_offset2 INT ...
                              (second algo) Set the target core voltage offset (in mv) for devices, separated by a space. 0 = ignore.
  --oc_memory_volt_offset2 INT ...
                              (second algo) Set the target memory voltage offset (in mv) for devices, separated by a space. 0 = ignore.
  --oc_lock_core_clock2 INT ...
                              (second algo) Lock the core clock for devices (in mhz), separated by a space. Overrides oc_core_clock.
  --oc_lock_memory_clock2 INT ...
                              (second algo) Lock the memory clock for devices (in mhz), separated by a space. Overrides oc_memory_clock.
  --oc_pstate2 INT ...        (second algo) Force a specific pstate. default is -1, will not change pstate
  --oc_script2 TEXT ...       (second algo) Instead of BzMiner setting oc's for a card/algo, call a script instead when oc needs to be set.
                               script is called with parameters --gpu_index {gpu index} --gpu_id {gpu id} --algo {algorithm oc is being set for}
                               eg.
                               'oc_script.bat --gpu_index 0 --gpu_id 1:0 --algo kaspa`
                               BzMiner will call this script for each gpu that needs oc to be set. If this parameter is specified, BzMiner will not set any overclocks on it's own. Can pass an array of scripts, one for each gpu. Default is empty string
  --oc_enable3 INT ...        Whether oc should be set for the third algo or not (per device). Default is 1.
  --oc_fan_speed3 TEXT ...    (third algo) Set the target fan speed (as percentage) for devices, separated by a space. 0 = auto, -1 = ignore, 100 = max.
                              Optionally use target temperature format, eg. --oc_fan_speed t:N[fMin-fMax]
                              where t is core, tm is mem , N is target temp, fMin is min fan speed percent, fMax is max fan speed percent
                              eg. --oc_fan_speed t:65[25-75] tm:85[50-100]
  --oc_power_limit3 INT ...   (third algo) Set the power limite for devices (in watts), separated by a space. 0 = ignore.
  --oc_core_clock_offset3 INT ...
                              (third algo) Set the target core clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_memory_clock_offset3 INT ...
                              (third algo) Set the target memory clock offset (in mhz) for devices, separated by a space. 0 = ignore.
  --oc_core_volt_offset3 INT ...
                              (third algo) Set the target core voltage offset (in mv) for devices, separated by a space. 0 = ignore.
  --oc_memory_volt_offset3 INT ...
                              (third algo) Set the target memory voltage offset (in mv) for devices, separated by a space. 0 = ignore.
  --oc_lock_core_clock3 INT ...
                              (third algo) Lock the core clock for devices (in mhz), separated by a space. Overrides oc_core_clock.
  --oc_lock_memory_clock3 INT ...
                              (third algo) Lock the memory clock for devices (in mhz), separated by a space. Overrides oc_memory_clock.
  --oc_pstate3 INT ...        (third algo) Force a specific pstate. default is -1, will not change pstate
  --oc_script3 TEXT ...       (third algo) Instead of BzMiner setting oc's for a card/algo, call a script instead when oc needs to be set.
                               script is called with parameters --gpu_index {gpu index} --gpu_id {gpu id} --algo {algorithm oc is being set for}
                               eg.
                               'oc_script.bat --gpu_index 0 --gpu_id 1:0 --algo kaspa`
                               BzMiner will call this script for each gpu that needs oc to be set. If this parameter is specified, BzMiner will not set any overclocks on it's own. Can pass an array of scripts, one for each gpu. Default is empty string
  --oc_mem_tweak INT          gddr5x memory tweak. 0-4, 0 = disabled, 1-4 = timing, higher = faster. May need to reduce overclocks.
  --oc_unlock_clocks          Unlock the core and memory clocks. Will not mine (same as --devices argument).
  --oc_reset_all              Completely reset oc on all devices. Requires admin/root
  --oc_reset_on_exit INT      Reset overclocks on bzminer exit. default 1 (enable), 0 = disable
  ```
  
  ![image](https://user-images.githubusercontent.com/83083846/147267767-29a8f092-694f-40f0-acb9-bb01fceba41d.png)


## The Configuration File (config.txt)
The configuration file is in the json file format, and can be manually updated, or updated through `bzminer.exe`'s remote commands.

There are three main sections:
- pool_configs - This contains a list of your pools. You can add as many pools as you want, even if your not currently mining to them
- global settings/device defaults - this contains global settings and default settings for devices if the devices do not specify those settings
- device_overrides - this contains a list of the devices on your system. By default they will use the device default settings

BzMiner reads and saves to the configuration file. Upon first running BzMiner, the configuration file will be updated with a new property called `device_overrides`, which contain a list of all the mining devices found on the pc. This is where individual device settings can be set.

With "advanced_config" turned on (default), the full config file is as follows:

```
{
    "extra_dev_fee": 0.0, // additional percentage to add to dev fee (thanks for your support!)

    "pool": [0,1], // one or more pools to mine to. devices that do not specify will mine to these pools (these are indices into the pool_config list)
        
    "lang": "en", // set the language. Default is en. Supported languages are en and cn

    "intensity": [0], // set mining intensity for device. 0-64, 0 = auto

    "repair_dag": [true], // Whether the dag (currently only ethash and etchash) should be repaired if an issue occurs. Useful for extreme overclocking. this has an impact on dag generation time
    
    "opencl_workgroup_size": [], // try setting a different workgroup size. should be a multiple of 32
    
    "calc_dag_crc": [false], // Whether to calculate the dag crc. this will have an impact on dag generation time.
    
    "ramp_up": [false], // Starts mining at a slower speed and slowly ramps up to full mining speed
    
    "cooldown_period": [0], // Allows the GPU to cool down after some time. 0 = off, default = 0, higher values means longer intervals between cooldowns
    
    "cpu_validate": [false], // Whether solutions from this device should be validated on the CPU before sent to pool
    
    "reset_oc_dag_gen": [false], // If true, will reset overclocks before dag is generated. after dag is generated, will set overclocks back to what they currently are. Useful for very high OC
    
    "disable_community_fund": false, // If true, will disable the community fund
    
    "multi_mine_ms": [5000, 15000], // how long each algo should mine when dual mining
    
    "multi_mine_type": 1, // 0 = parallel mine, 1 = alternate mine (can oc per algo), 2 = DAG gen only mining
    
    "temp_start": 80, // temperature (C) that device should start mining at after it has stopped due to temp_stop
    
    "temp_stop": 120, // temperature (C) that device should stop mining at
    
    "rig_name": "rig", // default name of rig, if pool does not specify, will use this as the username/worker name
    
    "force_algo": "", // Some OS's may not have updated scripts to allow mining new coins in BzMiner. Use this option to force the first algo
    
    "force_algo2": "", // Some OS's may not have updated scripts to allow mining new coins in BzMiner. Use this option to force the second algo
    
    "log_file": "", // if not empty, the file logs should be written to
    
    "clear_log_file": false, // by default, the log file will not be cleared when bzminer starts. set this to true to clear the log file when bzminer starts
    
    "enable_igpu": false, // enable mining on igpus
    
    "nvidia_only": false, // only mine using nvidia cards
    
    "nvidia_opencl": false, // have opencl enumerate nvidia devices. allows the "force_opencl" option for nvidia cards. disabled by default
    
    "amd_only": false, // only mine using amd cards
    
    "disable_opencl ": false, // do not load OpenCL. Useful for some rigs that are having AMD driver issues
    
    "lhr_stability": [100], // adjustment for lhr unlock for each card. Lower values = higher stability, higher values = lower stability
    
    "lhr_exception_reboot": false, // if set to true, will reboot the pc if the LHR exception is triggered (which requires a hard device reset)
    
    "lock_config": false, // if true, bzminer will never write to this file
    
    "cache_dag": 0, // when running eth + zil, if set to 1 eth dag will be cached while mining zil, so dag does not need to be recalculated after zil session. If mining Ergo, will preload next dag
    
    "advanced_config": true, // show advanced config options (after setting true, must run bzminer once so it can update this file)
    
    "advanced_display_config": true, // show advanced display options (after changing, must run bzminer once so it can update this file)
    
    "launch_on_boot": false, // if true, will automatically launch bzminer when pc turns on (windows only)
    
    "start_script": "start.bat", // Optional script to run when bzminer starts up
    
    "hung_gpu_ms": 30000, // After GPU is unresponsive for this number of milliseconds, it is considered "hung"
    
    "reboot_after_wathdog_restarts": 0, // reboot pc after watchdog restarts bzminer x number of times. default 0
    
    "crash_script": "crash.bat", // Optional script to call when a hung gpu is detected
    
    "hung_gpu_reboot": false, // If true, will reboot rig when a hung gpu is detected
    
    "hung_gpu_restart_bzminer": true, // If true, and watchdog is running, will restart bzminer when a hung gpu is detected
    
    "restart_miner_minutes": 0, // restart bzminer after this amount of time (minutes), IF watchdog is enabled
    
    "reboot_minutes": 0, // reboot pc after this amount of time (minutes)
    
    "webhook_discord_url": "", // url to discord webhook (create a channel, go to channel options, add a webhook and paste url here
    
    "webhook_discord_solutions_only": false, // useful for solo mining. get discord ping when you find a block. this overrides logs to the discord api
    
    "webhook_discord_interval_ms": 0, // how often to send logs up. 0 is asap (100ms or so)
    
    "webhook_discord_verbosity": 2, // same as verbosity but which logs to send up to the discord webhook
    
    "no_color": false, // disable all color output
    
    "verbosity": 2, // log level (0 = errors only, 1 = warnings, 2 = info (default), 3 = debug, 4 = network, 5 = trace (not available in release)
    
    "log_file_verbosity": 2, // same as "verbosity" but for the log file
    
    "update_frequency_ms": 15000, // how often to log info (in milliseconds). set to 0 to disable
    
    "update_frequency_shares": 0, // how often to log info (in after x amount of shares). set to 0 to disable
    
    "avg_hr_ms": 30000, // time to average hashrate (ms). Higher time means more stable hashrate, lower time means more realtime
    
    "log_solutions": true,  // whether to log each solution found in the output
    
    "show_pending": false, // whether to show pending shares which pool has not responded to
    
    "log_date": false, // whether to log the date on each log line
    
    "http_password": "", // password for http api
    
    "http_port": 4014, // port to use for http api
    
    "http_address": "0.0.0.0", // address to listen on for http api
    
    "http_enabled": true, // set to false to disable http api
    
    "disable_udp": false, // If true, the UDP service is disabled and this device will not show up in other instances of the BzMiner GUI
    
    "oc_reset_on_exit": false,
    
    "allow_stales": true, // If false, bz will attempt to detect stales and not send them to the pool
    
    "x_display": ":0", // which x display to use (for nvidia, linux only)
    
    "start_x": false, // attempt to start an x display (for nvidia, linux only)
    
    "zil_test": false, // whether to test zil or not
    
    "zil_test_diff": 1, // zil difficulty (1-5)
    
    "zil_test_frequency": 300, // seconds between zil iterations (zil windows last 30 seconds)
    
    "zil_pool": "", // zil pool to mine to
    
    "zil_wallet": "", // zil wallet to mine to
    
    "zil_gpus": [0, 1, 2, 3], // list of gpu indexes to mine zil. If no gpus are specified then all gpus will mine zil (if zil is enabled)
    
    "zil_retain_hashrate": false, // If true, zil hashrate will continue to display after the zil window has ended
    
    "table_width": 100, // number of characters wide the tables are. 0 = auto

    "wrap": true, // whether the table should allow columns to wrap (set to false to disable cells from wrapping their contents to the next line)

    "title_align": 1, // table title horrizontal alignment. 0 = left, 1 = center, 2 = right. default is 1 = center

    "date_align": 0, // table date alignment. 0 = left, 1 = center, 2 = right. default is 0 = left

    "max_log_history": 1024, // For http api. max retained log history. default is 1024. Higher values increase memory usage.

    "hide_unused_devices": false // if true, will hide any devices that are not mining (with start_mining: false setting)

    "show_devices": true, // show the devices table

    "devices_title_color": 7, // set the color of the devices table title

    "devices_border_color": 8, // set the color of the devices table border

    "devices_columns": "#,name:nw,free,total,core,mem,fan,pwr,temp", // which columns to show for devices table. supported list below

    "show_pool": true, // whether to show the pool tables

    "pool_title_color": 7, // pool table title color

    "pool_border_color": 8, // pool table border color

    "pool_columns": "#,uptime,a/r/i,avg,eff,pool mh,miner mh,status" // which columns to show in the pool tables
    
    "pool_configs": [{
            "algorithm": "ethash", // pool algorithm
            
            "wallet": "0x0000000000000000000000000000000000000000", // wallet to mine to
            
            "url": ["stratum+tcp://yourpool:4444", "stratum+tcp://yourpool:4444"], // list of urls to connect to. will rotate through urls if they fail
            
            "username": "rig", // username/worker name to use
            
            "lhr_only": false, // if true only lhr cards will mine to this pool
            
            "delay_before_connection_retry": 3000, // milliseconds between each reconnection retry (minimum is 1 second)
            
            "no_work_timeout": 30000, // ms after connection begins before no work timeout is triggered and reconnection happens
            
            "test": false, // run this algo in test mode (will not connect to a pool)
            
            "test_iteration_ms": 15000 //  seconds between new work in test mode
            
            "community_fund": 1, // Multiple of dev fee to donate to blockchain dev team (kaspa only right now). if 1, will be 1%, 2 = 2%
            
            "tbs_watchdog": 1000, // If time since last share is over this percentage of estimated tbs, tbs watchdog triggers. append "s, m, h, d" to base on time
            
            "algo_opt": 0, // If algorithm supports it (woodcoin), can set algo_opt to values that change how algorithm runs
            
            "zil_only": false, // If the algo is Eth + zil, will only allocate dag for zil, and ignore eth mining. for dual mining zil + another algo
            
            "max_dual_autotune_drop": 0.92 // max alowable drop for dual autotune (eg. 0.92 ~ 92% lowest eth hashrate)
        },
        {
            "algorithm": "kawpow", // pool algorithm
            
            "wallet": "0x0000000000000000000000000000000000000000", // wallet to mine to
            
            "url": ["stratum+tcp://yourpool:4444", "stratum+tcp://yourpool:4444"], // list of urls to connect to. will rotate through urls if they fail
            
            "username": "rig", // username/worker name to use
            
            "lhr_only": false, // if true only lhr cards will mine to this pool
            
            "delay_before_connection_retry": 3000, // milliseconds between each reconnection retry (minimum is 1 second)
            
            "no_work_timeout": 30000, // ms after connection begins before no work timeout is triggered and reconnection happens
            
            "test": false, // run this algo in test mode (will not connect to a pool)
            
            "test_iteration_ms": 15000 //  seconds between new work in test mode
            
            "community_fund": 1, // Multiple of dev fee to donate to blockchain dev team (kaspa only right now). if 1, will be 1%, 2 = 2%
            
            "tbs_watchdog": 1000, // If time since last share is over this percentage of estimated tbs, tbs watchdog triggers. append "s, m, h, d" to base on time
            
            "algo_opt": 0, // If algorithm supports it (woodcoin), can set algo_opt to values that change how algorithm runs
            
            "zil_only": false // If the algo is Eth + zil, will only allocate dag for zil, and ignore eth mining. for dual mining zil + another algo
            
            "max_dual_autotune_drop": 0.92 // max alowable drop for dual autotune (eg. 0.92 ~ 92% lowest eth hashrate)
        }],
        
    "throttle": [], // List of throttle amount per algo (optionally 2d list for per gpu/algo). 0 means disable throttle. higher means more throttling
    "oc_delay_ms": 50, // for dual mining only, time before/after oc is applied when switching to next algo
    "oc_fan_speed": [], // List (optionally of lists for dual mining oc's) of fan speeds (%)
    "oc_power_limit": [], // List (optionally of lists for dual mining oc's) of power limits (watts)
    "oc_core_clock_offset": [], // List (optionally of lists for dual mining oc's) of core offsets (mhz)
    "oc_memory_clock_offset": [], // List (optionally of lists for dual mining oc's) of memory offsets (mhz)
    "oc_lock_core_clock": [], // List (optionally of lists for dual mining oc's) of locked core clocks (mhz, overrides core offset when not 0)
    "oc_lock_memory_clock": [], // List (optionally of lists for dual mining oc's) of locked memory clocks (mhz, overrides memory offset when not 0)
    "oc_pstate": [], // force a performance state
    "oc_mem_tweak": 0, // Gddr5x memory timings tweak, levels 1-3. Higher tweak may require lower OC
    
    "device_overrides": [{
            // device info/settings
            "uid": "1:0", // pci bus id : pci device id. this uniquely identifies the device as long as it doesn't change pci slots
            
            "name": "EVGA RTX 3090 FTW3 Ultra", // name of the device
            
            "start_mining": true, // if false, device will not mine
            
            "lhr": false, // whether this device is an lhr card or not ( set automatically )
            
            "temp_start": 80, // temperature (C) that device should start mining at after it has stopped due to temp_stop
            
            "temp_stop": 120, // temperature (C) that device should stop mining at

            // pool settings for this device
            "pool": [0,1], // list of pools this device should mine to
            
            "intensity": [0], // mining intensity. 0-64, 0 = auto. higher values generally means higher hashrate, but higher chance of stales
            
            "repair_dag": [true],  // Whether the dag (currently only ethash and etchash) should be repaired if an issue occurs. Useful for extreme overclocking. this has an impact on dag generation time
            
            "calc_dag_crc": [false], // Whether to calculate the dag crc. this will have an impact on dag generation time.
            
            "ramp_up": [false], // Starts mining at a slower speed and slowly ramps up to full mining speed
            
            "cooldown_period": [0], // Allows the GPU to cool down after some time. 0 = off, default = 0, higher values means longer intervals between cooldowns
            
            "reset_oc_dag_gen": [false], // If true, will reset overclocks before dag is generated. after dag is generated, will set overclocks back to what they currently are. Useful for very high OC
            
            "force_opencl": [false], // force device to mine on OpenCL (if available, only affects nvidia)
            
            "dag_dev_ref": [""], // Instead of this device generating the dag, it can copy the dag from another device. Nvidia only currently. useful for high oc's
 
            // overclocking
            "oc_fan_speed": [-1], // set the devices fan speed. -1 = do not change, 0 = auto, >0 = lock at percentage. Optionally a list for dual mining
            
            "oc_power_limit": [0], // set the max power consumption (watts) the device will use. 0 = do not change, >0 = max watts. Optionally a list for dual mining
            
            "oc_core_clock_offset": [0], // set the core clock speed offset in MHz. 0 = do not change, !0 = set clock speed offset. Optionally a list for dual mining
            
            "oc_memory_clock_offset": [0], // set the memory clock speed offset in MHz. 0 = do not change, !0 = set memory speed offset. Optionally a list for dual mining
            
            "oc_lock_core_clock": [0], // Lock the core clock to a specific mhz, if device allows it. Optionally a list for dual mining
            
            "oc_lock_memory_clock": [0], // Lock the memory clock to a specific mhz, if device allows it. Optionally a list for dual mining
                        
            "oc_core_volt_offset": [0], // Set the core voltage offset in mv (currently intel gpus only)
                        
            "oc_memory_volt_offset": [0] // Set the memory voltage offset in mv (currently intel gpus only)
        }]
}
```

### How to disable specific GPUs

GPU's can be disabled either through the command line or through `config.txt`

The command line argument is `--disable` and expects a space separated list of gpu unique ids, or indexes

eg.

`bzminer --disable 1:0 3:0`

or 

`bzminer --disable 0 3 5`

Optionally they can be disabled directly from the `config.txt` file, under the gpu in the config.txt file, set `auto_start` to false

### Auto fan
Bz has an autofan ability to keep gpu at a target temperature.
Set the target fan speed (as percentage) for devices, separated by a space. 0 = auto, -1 = ignore, 100 = max.
Optionally use target temperature format, eg. --oc_fan_speed t:N[fMin-fMax]
where t is core, tm is mem , N is target temp, fMin is min fan speed percent, fMax is max fan speed percent
fMin and fMax are optional
eg. --oc_fan_speed t:75[25-75] tm:85[50-100]
eg. --oc_fan_speed m:65

config.txt example:
`"oc_fan_speed": ["t:75", "t:72"]`

where gpu 0 will target the core temp 75c and gpu 1 will target the memory temp 72c

### GPU Throttle Notifications

BzMiner will color code certain elements based on whether they are causing the GPU to throttle (slowdown). Current Core and Memory temperatures, as well as Power limit are supported.

Core/Memory - Green if not throttling. Red if GPU is throttling due to high temps. Yellow if GPU is close to throttling due to high temps

Power Limit - Power usage will be white when not causing GPU to throttle. Power usage will turn yellow when GPU is throttling do to power limit being reached.

### Dual Mining

To employ this strategy:
- Add the two coins to the pool_config section you wish to mine to, or use the command line
- Set either the global "pool" setting, or device override "pool" setting to use both pool_configs. eg. "pool": [0, 1]
- Run bzminer using that config. eg. `bzminer -c config.txt`
- Or optionally run with the command line similar to this:
`bzminer -a ethash -w 000000 -p stratum+tcp://us1.ethermine.org:4444 --a2 kaspa --w2 kaspa:000000 --p2 stratum+tcp://pool.us.woolypooly.com:3112`
- `-a` is the first algo, `-w` is first algo wallet, `-p` is first algo pool
- `--a2` is second algo, `--w2` is second algo wallet, `--p2` is second algo pool
- Intensity can be set for first algo with `-i` and for second algo with `--i2`
- The first intensity value controls the overal GPU workload for both algorithms when in parallel mining mode (default, multi_mine_type = 1)
- The second intensity value controls the "ratio" between the two algos. A higher second intensity, the more hashrate the second algo gets. It's a multiple of the first algo's hashrate. So a value of 10 would mean the second algo gets the same hashrate as the first algo. A value of 20 would mean the second algo gets double the hashrate as the first algo. When in parallel mining mode (dual mining), the second algo intensity has no maximum value.

v9.2.1 introduced optimized dual mining for specific algorithms. these combinations are supported:
- Ethw + Kaspa (Nvidia only, experimental)
- Etc + Kaspa (Nvidia only, experimental)
- Erg + Kaspa (Nvidia only, experimental)
- Ethw + Radiant (Nvidia only, experimental)
- Etc + Radiant (Nvidia only, experimental)
- Erg + Radiant (Nvidia only, experimental)
- Eth + Alph (Nvidia only, experimental)
- Etc + Alph (Nvidia only, experimental)

Use the `max_dual_autotune_drop` option to change behavior of dual autotune. by default this is 0.92, which means autotune will attempt to get maximum hashrate for both algos, but keep first algo (etc) at 92% hashrate or higher

BzMiner allows alternate/split mining by using the `multi_mine_type` option. Default is 0, parallel. By setting it to 1, the algorithms will take turns mining on the gpu. The duration they mine can be specified in the `multi_mine_ms` option, which takes an array [firstalgoms, secondalgoms]

## Overclock per Dual Mine Algo
BzMiner allows you to set an overclock for each algo you are dual mining. Be aware that extreme oc's can much easier cause a GPU to hang (crash) in this scenario, and for that reason the config option `oc_delay_ms` is used, to give the oc time to kick in before switching to next algo.

Here's a sample dual mine config with oc's per algo:

```
{
    "pool": [0, 1],
    "intensity": [0],
    "multi_mine_ms": [5000, 15000],
    "rig_name": "ethash_rig",
    "log_file": "",
    "clear_log_file": false,
    "nvidia_only": false,
    "amd_only": false,
    "lock_config": false,
    "pool_configs": [{
            "algorithm": "ethash",
            "wallet": "0000",
            "url": ["stratum+tcp://us2.ethermine.org:4444"],
            "lhr_only": false,
            "max_dual_autotune_drop": 0.92
        }, {
            "algorithm": "alph",
            "wallet": "0000",
            "url": ["stratum+tcp://eu.metapool.tech:20032", "stratum+tcp://pool.woolypooly.com:3106"],
            "username": "alph_rig",
            "lhr_only": false,
            "max_dual_autotune_drop": 0.92
        }],
    "oc_delay_ms": 100,
    "device_overrides": [{
            "uid": "1:0",
            "name": "EVGA RTX 3090 FTW3 Ultra",
            "start_mining": true,
            "lhr_mine_ms": [5000, 15000],
            "oc_fan_speed": [-1],
            "oc_power_limit": [0],
            "oc_core_clock_offset": [-200, 50],
            "oc_memory_clock_offset": [1100, 0],
            "oc_lock_core_clock": [0],
            "oc_lock_memory_clock": [0, 810]
        }]
}
```

## Display configuration

BzMiner allows you to customize the output displays. This includes the table width, title color, border color, and which columns in each table to show.

There are two tables that are logged by default, the devices table, and the pool tables. On each display update, the devices table is logged, which contain information about all the devices on the system. This table is not in the context of a pool, so does not support some of the column options the pool tables support, including hashrate.

The Pool table is logged for each pool that devices are mining to. If there are two devices on the system, and each device is mining to a different pool (or different algorithm), then there will be two pool tables in the output, one for each pool. This table supports all the columns in the device table, as well as columns specific to the pool context.

default device column configuration: `"#,name:nw,cfg,free,total,core,mem,fan,pwr,temp"`

default pool column configuration: `"#,uptime,a/r/i,avg,eff,pool mh,miner mh,status:nw"`

### Supported Device table columns
- `#` - The device id in the format of `pci_bus_id:pci_device_id`
- `name` - The display name of the device
- `free` - Free device memory
- `total` - Total device memory
- `core` - Current core clock speed
- `mem` - Current memory clock speed
- `fan` - Fan speed
- `pwr` - Power Usage
- `pstate` - Current GPU Performance State
- `temp` - Temperature. In the format of `core temp/memory temp`
- `status` - Device status for all pools

### Supported Pool table columns (In addition to all device table supported columns)
- `%` - Percentage of Accepted shares (relative to all shares including rejected, invalid and stale)
- `uptime` - The time the device has been mining without stopping or resetting
- `cfg` - The device configuration. eg. i6 = intensity 6
- `a/r/i` - Accepted/Rejected/Invalid shares
- `tbs` - Average time between shares
- `tsls` - Time since last share
- `spm` - Average number of shares per minute
- `best` - Show the highest difficulty share found
- `eff` - Efficiency, in the units of hashes per watt
- `pool_hr` - Estimated effective hashrate based on pool difficulty and shares found (effective/current hashrate on some pools)
- `miner_hr` - Current miner speed (reported hashrate on some pools)
- `status` - Device/Pool status.

The pool table has an additional row at the bottom which is the summary of all devices mining to that pool. The status column for the pool includes the epoch number, difficulty, and average latency to pool.

To update the column in config.txt (hiveos):
`"pool_columns": "#,a/r/i,cfg,tbs,tsls,eff,pool_hr,miner_hr,status"`

### Customizing the display
- Colors are integers and correspond to normal terminal color codes. Default BzMiner logging color is 7.
- Columns are a comma separated string. do not include spaces unless the column name includes spaces (eg. "pool mh"). Columns can have options (currently just one), which is specified by adding a colon (:) after the column name, and specifying the option, eg `name:nw`. Two supported options; `nw`, which prevents that particular column from wrapping to the next line if the column cannot get wide enough to support the entire value on one line, and `nc`, which disables coloring of the column values

## Pool URLs

Urls should be in the form of `{protocol}+{tcp/ssl}:{url}:{port}` (username and password are optional)

eg. `stratum+tcp://us1.ethermine.org:4444`

If username and password are required, eg. `{protocol}+{tcp/ssl}:<{username}:{password}@>{url}:{port}`, they can be set per device in the config file, or through the command line. If device pool_username is blank, it will use the rig name from the config file. if pool_password is blank, it will use the default pool_password for the rig in the config file. Leave both pool_password blank if no password is required for the pool. Do not put the username and password in the url (If there are enough requests for this, this can be added in a future release)

BzMiner supports 4 network protocols
- Node - use `node` or `solo`
- Stratum - use `stratum`
- Eth Proxy - use `ethproxy`
- Ethereum Stratum v1.0.0 - use `ethstratum`
- Ethereum Stratum v2.0.0 - use `ethstratum2`
- Alephium Binary Stratum - use `alphstratum`
- HTTP or HTTPS GetWork - use `http` or `https`

BzMiner will attempt to auto select a protocol the pool supports if the provided protocol does not succeed in establishing a connection with the pool.


## HTTP API

HTTP API can be enabled by launching bzminer with the --http_enabled flag, or by setting "http_enabled": true in the config file.

For more details, enable the http api, and go to `http://{http_address}:{http port}/help`. If you are on the same computer, you can use `localhost` or `127.0.0.1` as the http_address.

A simple viewer can be found at `/index` when the HTTP API is enabled. `index.html` is provided for your convenience.

## Watchdog service

By default, the wathdog service is running. The watdog service watches for:

- Hung GPU (GPU not responding after a period of time)
- Unresponsive network activity
- Unresponsive main loop
- BzMiner crashing

If a hung GPU is detected, the watchdog service will optionally call a script specified in the config file, then optionally reboot the rig if specified in the config file.

The last log (and output) from BzMiner before the optional script is called is in the format of:

`<Error> Hung GPU detected! (bus_id:device_id)`

Which could be read from the called script if needed.

The watchdog also restarts BzMiner if BzMiner crashes for whatever reason. This shouldn't normally happen, but the occasional bug can cause BzMiner to crash, and with the wathdog service, it'll start back up again. The watchdog service also restarts BzMiner in instances of unresponsive network activity and an unresponsive main loop.
