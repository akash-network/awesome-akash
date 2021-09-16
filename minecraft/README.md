# Akash Minecraft

Launch a Minecraft server on the Akash blockchain. It can be easily configured with only changes to deploy.yaml, and supports any Minecraft version, including multiple modded server types.

A default vanilla configuration is included, and this is ready to run out-of-the-box.

For an even easier one-liner deployment, see the deployment script repository at https://github.com/slowriot/akash_minecraft.

# Configuration
## deploy.yaml
The simplest way to configure your Minecraft server is through environment variables; just edit `deploy.yaml` prior to deploying, looking at the `env` block: https://github.com/slowriot/akash_minecraft/blob/master/deploy.yaml#

The default variables are minimal:
- FORCE_REDOWNLOAD=true
- EULA=TRUE
- VERSION=latest
- SERVER_NAME=AkashMinecraft
- MEMORY=4G
- MAX_PLAYERS=10

### Common configuration adjustments
If you wish to run a different version of the game, simply state the version in the `VERSION=...` variable.  This can be set to `LATEST`, `SNAPSHOT`, or a numerical version such as `1.7.10`.

Difficulty can be adjusted with settings like `DIFFICULTY=hard`, `HARDCORE=true`.  Server name is self-explanatory.  Op and whitelist players can be listed with `OPS=user1,user2` and `WHITELIST=user1,user2`.  The default maximum number of players is 20, if no value is specified in environment variables, and the default for this configuration is 10 to match the performance settings below - feel free to experiment with this.  A full list of variabels can be found in the container's documentation at https://github.com/slowriot/docker-minecraft-server#server-configuration.

### Mods
You can run a modded server by specifying `TYPE=FORGE`, `TYPE=BUKKIT`, `TYPE=SPIGOT`, `TYPE=PAPER`, etc.  Mod packs can be added in different ways depending on the framework - for example, for Spigot use `SPIGET_RESOURCES=9089,34315` where the numbers are resource IDs, and for Forge, Bukkit etc you can use `MODPACK=http://www.example.com/mods/modpack.zip`.  For detailed instructions on managing mods, see the link to the Minecraft server container documentation at the end of this page.

### Adjusting container performance
Configuring the performance of the server can also be done by editing `deploy.yaml` prior to deploying.  The default settings attempt to offer good performance while offering the cheapest costs, and should be adequate for up to 10 players.  It is easy to adjust these settings for your particular needs.

If you want to adjust your memory usage - either to increase it in order to accomodate more players, or to reduce it in order to reduce deployment cost - you need to alter it in two places.  By default, `MEMORY=4G` instructs the Minecraft server itself to use a maximum of 4GB of RAM, and `memory: size: 5Gi` specifies the maximum memory for the container it runs in.  The memory for the container should always be larger than the memory configured for the game, but you can experiment with how big a gap you need between the two.

Default CPU usage is configured as 1.5 - that's one-and-a-half cores, which seems to work well for vanilla Minecraft, which at the time of writing is still largely single-threaded.  If you find server performance could be better (for example if you are using a lot of redstone, or have a lot of mobs on the server), you may want to raise this - and the cost of the deployment may rise slightly as a result.

# Minecraft configuration
For more detailed information on configuring the Minecraft docker image, including how to enable mod support, see the docker container's documentation at https://github.com/slowriot/docker-minecraft-server#readme.  Wherever an environment variable is given with `-e VARIABLE=VALUE`, just insert `VARIABLE=...` under the `env` section of `deploy.yaml`.

# Easier deployment
If you do not wish to manage your deployment manually, you can use the deployment script repository at https://github.com/slowriot/akash_minecraft - this will deploy the server to Akash with a single command, automatically selecting the lowest bidder, and providing you with links to the server and the log streams.
