# What is Counter-Strike: Global Offensive?
Counter-Strike: Global Offensive (CS: GO) expands upon the team-based action gameplay that it pioneered when it was launched 19 years ago. CS: GO features new maps, characters, weapons, and game modes, and delivers updated versions of the classic CS content (de_dust2, etc.).
This Docker image contains the dedicated server of the game.

>  [CS:GO](https://store.steampowered.com/app/730/CounterStrike_Global_Offensive/)

<img src="https://1000logos.net/wp-content/uploads/2017/12/CSGO-Logo.png" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=csgo-dedicated -e SRCDS_TOKEN={YOURTOKEN} cm2network/csgo
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/csgo-data
$ chmod 777 $(pwd)/csgo-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/csgo-data:/home/steam/csgo-dedicated/ --name=csgo-dedicated -e SRCDS_TOKEN={YOURTOKEN} cm2network/csgo
```

Running multiple instances (increment SRCDS_PORT and SRCDS_TV_PORT):
```console
$ docker run -d --net=host --name=csgo-dedicated2 -e SRCDS_PORT=27016 -e SRCDS_TV_PORT=27021 -e SRCDS_TOKEN={YOURTOKEN} cm2network/csgo
```

`SRCDS_TOKEN` **is required to be listed & reachable. Generate one here using AppID `730`:**  
[https://steamcommunity.com/dev/managegameservers](https://steamcommunity.com/dev/managegameservers)<br/><br/>
`SRCDS_WORKSHOP_AUTHKEY` **is required to use workshop features:**  
[https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey)<br/>

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
SRCDS_TOKEN="changeme" (value is is required to be listed & reachable, retrieve token here (AppID 730): https://steamcommunity.com/dev/managegameservers)
SRCDS_RCONPW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_NET_PUBLIC_ADDRESS="0" (public facing ip, useful for local network setups)
SRCDS_IP="0" (local ip to bind)
SRCDS_LAN="0"
SRCDS_FPSMAX=300
SRCDS_TICKRATE=128
SRCDS_MAXPLAYERS=14
SRCDS_STARTMAP="de_dust2"
SRCDS_REGION=3
SRCDS_MAPGROUP="mg_active"
SRCDS_GAMETYPE=0
SRCDS_GAMEMODE=1
SRCDS_HOSTNAME="New CSGO Server" (first launch only)
SRCDS_WORKSHOP_START_MAP=0
SRCDS_HOST_WORKSHOP_COLLECTION=0
SRCDS_WORKSHOP_AUTHKEY="" (required to use host_workshop_map)
ADDITIONAL_ARGS="" (Pass additional arguments to srcds. Make sure to escape correctly!)
```
## Config
The image contains a copy of the official ESL config files from [here](https://play.eslgaming.com/download/26251762/). You can edit the config using this command:
```console
$ docker exec -it csgo-dedicated nano /home/steam/csgo-dedicated/csgo/cfg/server.cfg
```

If you want to learn more about configuring a CS:GO server check this [documentation](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Advanced_Configuration).

# Image Variants:
The `csgo` images come in three flavors, each designed for a specific use case.

## `csgo:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is a bare-minimum CSGO dedicated server containing no 3rd party plugins.<br/>

## `csgo:metamod`
This is a specialized image. It contains the plugin environment [Metamod:Source](https://www.sourcemm.net) which can be found in the addons directory. You can find additional plugins [here](https://www.sourcemm.net/plugins).

## `csgo:sourcemod`
This is another specialized image. It contains both [Metamod:Source](https://www.sourcemm.net) and the popular server plugin [SourceMod](https://www.sourcemod.net) which can be found in the addons directory. [SourceMod](https://www.sourcemod.net) supports a wide variety of additional plugins that can be found [here](https://www.sourcemod.net/plugins.php).

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/csgo?size=50&padding=5&bots=false)](https://github.com/CM2Walki/csgo/graphs/contributors)
