# What is Holdfast: Nations At War ?
Fight on multiple fronts in Holdfast: Nations At War - A competitive multiplayer first and third person shooter set during the great Napoleonic Era. Charge into battle with over 150 players per server!

>  [Holdfast: NaW](https://store.steampowered.com/app/589290/Holdfast_Nations_At_War/)

<img src="https://holdfastgame.com/Content/imgs/site/holdfast-logo.png" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated cm2network/holdfastnaw
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/holdfastnaw-data
$ chmod 777 $(pwd)/holdfastnaw-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/holdfastnaw-data:/home/steam/holdfastnaw-dedicated/ --name=holdfastnaw-dedicated cm2network/holdfastnaw
```

Running multiple instances:
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated2 cm2network/holdfastnaw
```

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
FPSMAX=120
SERVER_PORT=20100
STEAM_QUERY_PORT=27000
SCREEN_QUALITY="Fastest"
SCREEN_WIDTH=640
SCREEN_HEIGHT=480
SERVER_REGION="europe"
SERVER_CONFIG_PATH="serverconfig_default.txt"
SERVER_LOG_PATH="logs_output/outputlog_server.txt"
SERVER_LOG_ARCHIVE_PATH="logs_archive/"
STEAMCMD_UPDATE_ARGS="" (Gets appended here: +app_update [appid] [STEAMCMD_UPDATE_ARGS]; Example: "validate")
ADDITIONAL_ARGS="" (Pass additional arguments to server binary. Make sure to escape correctly!)
```
## Config
```console
$ docker exec -it holdfastnaw-dedicated nano /home/steam/holdfastnaw-dedicated/serverconfig_default.txt
```

If you want to learn more about configuring a Holdfast: Nations At War server check this [documentation](https://wiki.holdfastgame.com/Server_Configuration).

# Image Variants:

## `holdfastnaw:latest`
This is the defacto image. It is a bare-minimum Holdfast: Nations At War dedicated server containing no 3rd party plugins.<br/>

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/HoldfastNaW?size=50&padding=5&bots=false)](https://github.com/CM2Walki/HoldfastNaW/graphs/contributors)
