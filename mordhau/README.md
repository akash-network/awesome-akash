# What is Mordhau?
MORDHAU is a multiplayer medieval slasher. Create your mercenary and fight in brutal battles where you will experience fast paced combat, castle sieges, cavalry charges, and more. <br/>
This Docker image contains the dedicated server of the game. <br/>

> [Mordhau](https://store.steampowered.com/app/629760/MORDHAU/)

<img src="https://mordhau.com/static/presskit/mordhau_logo.png" alt="logo" width="300"/></img>

# How to use this image

## Hosting a simple game server
Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=mordhau-dedicated cm2network/mordhau
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/mordhau-data
$ chmod 777 $(pwd)/mordhau-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/mordhau-data:/home/steam/mordhau-dedicated/ --name=mordhau-dedicated cm2network/mordhau
```

Running multiple instances (iterate SERVER_PORT, SERVER_QUERYPORT and SERVER_BEACONPORT):<br/>
```console
$ docker run -d --net=host -e SERVER_PORT=7778 -e SERVER_QUERYPORT=27016 -e SERVER_BEACONPORT=15001 --name=mordhau-dedicated2 cm2network/mordhau
```

**It's also recommended using "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
SERVER_ADMINPW="replacethisyoumadlad"
SERVER_PW=""
SERVER_NAME="My Mordhau Server"
SERVER_MAXPLAYERS=32
SERVER_TICKRATE=60
SERVER_PORT=7777
SERVER_QUERYPORT=27015
SERVER_BEACONPORT=15000
SERVER_GAMEINI="cfg/Game.ini"
SERVER_ENGINEINI="cfg/Engine.ini"
SERVER_DEFAULTMAP="ThePit\/FFA_ThePit.FFA_ThePit"
STEAMCMD_UPDATE_ARGS="" (Gets appended here: +app_update [appid] [STEAMCMD_UPDATE_ARGS]; Example: "validate")
ADDITIONAL_ARGS="" (Pass additional arguments to srcds. Make sure to escape correctly!)
```

## Config
The config files (Game.ini & Engine.ini) can be found under */home/steam/mordhau-dedicated/cfg*

If you want to learn more about configuring a Mordhau server check this [documentation](https://mordhau.gamepedia.com/Dedicated_Server_Hosting_Guide#Tweaks_and_configurations).

# Image Variants:

## `holdfastnaw:latest`
This is the defacto image. It is a bare-minimum Holdfast: Nations At War dedicated server containing no 3rd party plugins.<br/>

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/Mordhau?size=50&padding=5&bots=false)](https://github.com/CM2Walki/Mordhau/graphs/contributors)
