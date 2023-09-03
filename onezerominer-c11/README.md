# OneZeroMiner 

Optimized GPU miner for crypto projects. Currently, the only supported algorithm is DynexSolve.
### Links 

![GitHub all releases](https://img.shields.io/github/downloads/OneZeroMiner/onezerominer/total)


Website: http://onezerominer.com

Discord server : https://discord.gg/mXnyrHa

Releases: https://github.com/OneZeroMiner/onezerominer/releases

Options
------------------------------------------           
 ```                                                                                                   
Options:        
  -a, --algo <algo>
          The algorithm to use for mining. Currently supported algorithms are: 
                - dynex   (dnx)
          
           [possible values: dynex]
  -o, --pool <pool>
          Comma seperated list of pools to use
  -w, --wallet <wallet>
          Wallet address/Pool Username
  -p, --pass <pass>
          Pool Password [default: X]
      --api-host <api_host>
          Host of the API [default: 127.0.0.1]
      --api-port <api_port>
          Port of the API [default: 3001]
      --api-disable
          Disable API
  -d, --devices <devices>
          Comma seperated list of devices to use
      --chips-memory <chips-memory>
          Percentage of total memory allocated for dynex chips. 
          (Default is 96 percent but uses free memory instead of total)
      --mallob-endpoint <mallob_endpoint>
          List of Mallob endpoints for Dynex
      --log-file <log_file>
          log file path
      --cclk <cclk>
          list of core clocks. Use * to skip a GPU
      --coff <coff>
          list of core clocks offsets. Use * to skip a GPU
      --mclk <mclk>
          list of memory clocks. Use * to skip a GPU
      --moff <moff>
          list of memory clocks offsets. Use * to skip a GPU
      --fan <fan>
          list of fan speeds. Use * to skip a GPU
      --pl <pl>
          list of power limits. Use * to skip a GPU
      --max-no-job <max_no_job>
          Maximum number of minutes that the pool can stay connected without recieving a new job [default: 15]
      --max-no-acc <max_no_acc>
          Maximum number of minutes that the pool can stay connected without an accepted share [default: 15]
  -h, --help
          Print help
  -V, --version
          Print version
```

Dev fee
------------------------------------------

Algorithm           |  Fee 
--------------------| ---- 
dynex               | 3%


Requirements
------------------------------------------ 
* Minimum Compute Capability of 3.5.
* Binary file have been built with CUDA 11.8 and minimum supported Nvidia driver version is 450.80.02.

HiveOS
------------------------------------------
#### HiveOS package name is onezerominer-x.x.x.tar.gz
#### Sample Flight Sheet:

![HiveOS](https://github.com/OneZeroMiner/onezerominer/raw/main/hiveos.png?raw=true)
