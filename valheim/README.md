[![](https://img.shields.io/codacy/grade/33ce0225cb214844b8995d24c75a3080.svg)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cm2network/valheim)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/valheim.svg)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/valheim.svg)](https://hub.docker.com/r/cm2network/valheim/) [![](https://img.shields.io/docker/image-size/cm2network/valheim)](https://img.shields.io/docker/image-size/cm2network/valheim) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
-	[`base`, `latest` (*bullseye/Dockerfile*)](https://github.com/CM2Walki/Valheim/blob/master/bullseye/Dockerfile)
-	[`plus` (*bullseye/Dockerfile*)](https://github.com/CM2Walki/Valheim/blob/master/bullseye/Dockerfile)

# What is Valheim?
A brutal exploration and survival game for 1-10 players, set in a procedurally-generated purgatory inspired by viking culture. Battle, build, and conquer your way to a saga worthy of Odin’s patronage!

>  [Valheim](https://store.steampowered.com/app/892970/Valheim/)

<img src="https://static.wikia.nocookie.net/valheim/images/4/4c/Logo_valheim.png" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=valheim-dedicated cm2network/valheim
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/valheim-data
$ chmod 777 $(pwd)/valheim-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/valheim-data:/home/steam/valheim-dedicated/ --name=valheim-dedicated cm2network/valheim
---
$ docker volume create valheim-plus-data # For valheim:plus - Create an additional world volume
$ docker run -d --net=host -v $(pwd)/valheim-data:/home/steam/valheim-dedicated/ -v valheim-plus-data:/home/steam/.config/unity3d/IronGate/Valheim/ --name=valheim-plus-dedicated cm2network/valheim:plus
```

Running multiple instances (increment SERVER_PORT by two, there is no way to overwrite the steam query port, it will always be SERVER_PORT + 1!):
```console
$ docker run -d --net=host -e SERVER_PORT=2458 --name=valheim-dedicated2 cm2network/valheim
```

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
SERVER_PORT=2456 (Game Port (tcp & udp); Steam Query Port (udp) will be SERVER_PORT + 1)
SERVER_PUBLIC=1
SERVER_WORLD_NAME="BraveNewWorld"
SERVER_PW="changeme"
SERVER_NAME="New \"${STEAMAPP}\" Server"
SERVER_LOG_PATH="logs_output/outputlog_server.txt"
SERVER_SAVE_DIR="Worlds"
SCREEN_QUALITY="Fastest"
SCREEN_WIDTH=640
SCREEN_HEIGHT=480
STEAMCMD_UPDATE_ARGS="" (Gets appended here: +app_update [appid] [STEAMCMD_UPDATE_ARGS]; Example: "validate")
ADDITIONAL_ARGS="" (Pass additional arguments to the server. Make sure to escape correctly!)
```

If you want to learn more about configuring a Valheim server check this [documentation](https://valheim.fandom.com/wiki/Hosting_Servers).

## Config
You can find the `adminlist.txt`, `bannedlist.txt` and `permittedlist.txt` here: `/home/steam/valheim-dedicated/Worlds`.

The world database files can be found in:
- `/home/steam/valheim-dedicated/Worlds/worlds` for tag `valheim:latest`
- `/home/steam/.config/unity3d/IronGate/Valheim/` for tag `valheim:plus`

# Image Variants:
The `valheim` images come in two flavors, each designed for a specific use case.

## `valheim:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is a bare-minimum Valheim dedicated server containing no 3rd party plugins.<br/>

## `valheim:plus`
This is a specialized image. It contains the popular mod [ValheimPlus](https://github.com/valheimPlus/ValheimPlus). 

Note: The game world is saved in a different directory in this tag, make sure to create an additional volume for world persistency across container recreations. See [#Hosting a simple game server](https://github.com/CM2Walki/Valheim/edit/master/README.md#hosting-a-simple-game-server)

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/Valheim?size=50&padding=5&bots=false)](https://github.com/CM2Walki/Valheim/graphs/contributors)
