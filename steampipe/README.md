# What is SteamPipe?
SteamPipe is the game/application content system that powers Steam. SteamPipe includes the following features: Efficient and fast content delivery. Unlimited public and private "beta" branches, allowing multiple builds to be tested (Source: [developer.valvesoftware.com](https://partner.steamgames.com/doc/sdk/uploading)). If you are developing a game on Steam, this is the tool you use to upload new builds of your game to Steam.
 
# How to use this image
As of now, the image only supports the ContentBuilder of SteamPipe. Further SteamPipe features will be added in the future, as long as they don't directly require an installation of Steamworks SDK (which would be non-compliant with the SDK's developer agreement).

## Using ContentBuilder
**Use-Case: Upload build to a depot and/or deploy to a branch (CI/CD).**

The ContentBuilder image replicates a minimal directory structure of a Steamworks SDK installation, whilst actually only being dependent on a [SteamCMD](https://github.com/CM2Walki/steamcmd) installation. This image assumes that you already have depots and branches setup on [partner.steamgames.com](https://partner.steamgames.com). You will also require a seperate Steamworks account (e-mail Steam Guard **enabled**) that has sufficient permissions to push to your steam depots. If you haven't completed any of these steps consult [the official documentation](https://partner.steamgames.com/doc/sdk/uploading).

**Initial one-time setup:**

Create required named volumes:
```console
$ docker volume create steamcmd_login_volume # Location of login session
$ docker volume create steamcmd_output_volume # Location of contentbuilder build cache (it's important to preserve this! Otherwise builds will need to start from scratch each time!)
$ docker volume create steamcmd_volume # Optional: Location of SteamCMD installation, to avoid unnecessary duplication
```

Activate the SteamCMD login session, you will be asked to enter your e-mail Steam Guard code once (this will permanently save your login session in `steamcmd_login_volume`). Replace the following fields before executing the command:
- [STEAMUSER] - steam username
- [ACCOUNTPASSWORD] - steam account password

```console
$ docker run -it --rm \
    -v "steamcmd_login_volume:/home/steam/Steam:z" \
    -v "steamcmd_volume:/home/steam/steamcmd:z" \
    cm2network/steampipe:contentbuilder \
    bash /home/steam/steamcmd/steamcmd.sh +login [STEAMUSER] [ACCOUNTPASSWORD] +quit
```

**Using Contentbuilder:**

The **simple** way -> uploading to a single depot. Replace the following fields before executing the command:
- [STEAMUSER] - steam username
- [ACCOUNTPASSWORD] - steam account password
- [STEAMAPPID] - appid of application/game
- [STEAMDEPOTID] - depotid to upload to
- [UPLOADDIR] - location (on host) of application/game files to upload to the depot (for example the artifact location of your CI builds)

```console
$ docker run -d --net=host \
    -e STEAMUSER="[STEAMUSER]" \
    -e STEAMPASSWORD="[ACCOUNTPASSWORD]" \
    -e STEAMAPPID="[STEAMAPPID]" \
    -e STEAMDEPOTID="[STEAMDEPOTID]" \
    -e STEAMAPPBUILDESC="Automated CD Upload" \
    -v "[UPLOADDIR]:/home/steam/steamsdk/sdk/tools/ContentBuilder/content" \
    -v "steamcmd_login_volume:/home/steam/Steam:z" \
    -v "steamcmd_volume:/home/steam/steamcmd:z" \
    -v "steamcmd_output_volume:/home/steam/steamsdk/sdk/tools/ContentBuilder/output" \
    --rm "cm2network/steampipe:contentbuilder"
```

The **complex** way -> using custom .vdf files (for example for building to multiple depots). Replace the following fields before executing the command:
- [STEAMUSER] - steam username
- [ACCOUNTPASSWORD] - steam account password
- [VDFAPPBUILDFILE] - The .vdf file steamcmd should call on container start (file must be located in [VDFFILESDIR])
- [VDFFILESDIR] - location (on host) of the vdf files that [VDFAPPBUILDFILE] depends on
- [UPLOADDIR] - location (on host) of application/game files to upload to the depot (for example the artifact location of your CI builds)

```console
$ docker run -d --net=host \
    -e STEAMUSER="[STEAMUSER]" \
    -e STEAMPASSWORD="[ACCOUNTPASSWORD]" \
    -e VDFAPPBUILD="[VDFAPPBUILDFILE]" \
    -e STEAMAPPBUILDESC="Automated CD Upload" \
    -v "[UPLOADDIR]:/home/steam/steamsdk/sdk/tools/ContentBuilder/content" \
    -v "[VDFFILESDIR]:/home/steam/steamsdk/sdk/tools/ContentBuilder/scripts" \
    -v "steamcmd_login_volume:/home/steam/Steam:z" \
    -v "steamcmd_volume:/home/steam/steamcmd:z" \
    -v "steamcmd_output_volume:/home/steam/steamsdk/sdk/tools/ContentBuilder/output" \
    --rm "cm2network/steampipe:contentbuilder"
```

### Configuration
**Environment Variables:**

Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
VDFAPPBUILD="app_build_default.vdf" (The vdf steamcmd should call on container start)
STEAMAPPBRANCH="" (Steam partner branch of appid to upload to. Warning: Setting this to a branch will instantly set the uploaded builds live! Useful for full CI/CD pipelines)
STEAMAPPBUILDESC="Docker CD upload" (Partner page build description)

STEAMAPPID="22222" (Only Used if there are no scripts in ${BUILDERSCRIPTDIR})
STEAMDEPOTID="22223" (Only Used if there are no scripts in ${BUILDERSCRIPTDIR})
FILEEXCLUSIONS="" (; seperated list of things to exclude from the build, Only Used if there are no scripts in ${BUILDERSCRIPTDIR})

CONTENTBUILDERDIR="${HOMEDIR}/steamsdk"
BUILDERSCRIPTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/scripts"
BUILDERCONTENTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/content"
BUILDEROUTPUTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/output"
LOCALCONTENTPATH="*" (Directory to build inside ContentRoot)
```

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/steampipe?size=50&padding=5&bots=false)](https://github.com/CM2Walki/steampipe/graphs/contributors)
