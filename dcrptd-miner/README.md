/dcrptd-miner ^C
root@8dd4e595dabc:/dcrptd-miner/bin/Release/net6.0/linux-x64# ./^C
root@8dd4e595dabc:/dcrptd-miner/bin/Release/net6.0/linux-x64# cat config.
cat: config.: No such file or directory
root@8dd4e595dabc:/dcrptd-miner/bin/Release/net6.0/linux-x64# cat config.json
{
    "_url": "Pool or node url. You can set multiple addresses, first one will be used as default and if connection fails miner will move to next one. Address prefix determines protocol used.",
    "url": [
        "shifu://185.215.180.7:5555"
    ],
    "_user": "Username or wallet address as required by pool",
    "user": "WALLET_ADDRESS_HERE.WorkerName",
    "_password": "Password",
    "password": "x",
    "_retries": "Specifies how many times miner will try to connect to a specific url until selecting next",
    "retries": 5,
    "_action_after_retries_done": "Set action on what to do after all urls have been retried. Possible values: RETRY (= start again from first url), EXIT (= exits the miner)",
    "action_after_retries_done": "RETRY",
    "periodic_report": {
        "_initial_delay": "Delay in seconds to wait before first Periodic Report",
        "initial_delay": 30,
        "_report_interval": "Delay in seconds between Periodic Reports",
        "report_interval": 300
    },
    "api": {
        "_enabled": "Enable or disable api endpoint",
        "enabled": false,
        "_port": "Specify port to be used for api service",
        "port": 9000,
        "_localhost_only": "Bind api service only to localhost (127.0.0.1) address. [true / false]",
        "localhost_only": true,
        "_access_token": "Access token to provide as Authorization header to access api. Set to null to disable",
        "access_token": null
    },
    "Logging": {
        "Loglevel": {
            "Default": "Warning"
        }
    }
}
