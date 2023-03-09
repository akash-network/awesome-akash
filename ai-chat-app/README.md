Open Source, Self-Hosted Chat GPT app

[![ai-chat-app](https://raw.githubusercontent.com/imagegenius/templates/main/unraid/img/ai-chat-app.png)](https://github.com/bitswired/ai-chat-app)

## Application Setup

The WebUI can be accessed at `http://your-ip:3000`, you must specify an OpenAI API Key in settings before using, go to `http://your-ip:3000/settings`, enter the API key, and press save.

This app is brand new, hence it is buggy. I need to create a new chat via the `Templates`, then I can start to make other chats.

## Variables

To configure the container, pass variables at runtime using the format `<external>:<internal>`. For instance, `-p 8080:80` exposes port `80` inside the container, making it accessible outside the container via the host's IP on port `8080`.

| Variable | Description |
| :----: | --- |
| `-p 3000` | WebUI Port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Etc/UTC` | specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| `-v /config` | Contains the database |

## Umask for running applications

All of our images allow overriding the default umask setting for services started within the containers using the optional -e UMASK=022 option. Note that umask works differently than chmod and subtracts permissions based on its value, not adding. For more information, please refer to the Wikipedia article on umask [here](https://en.wikipedia.org/wiki/Umask).

## User / Group Identifiers

To avoid permissions issues when using volumes (`-v` flags) between the host OS and the container, you can specify the user (`PUID`) and group (`PGID`). Make sure that the volume directories on the host are owned by the same user you specify, and the issues will disappear.

Example: `PUID=1000` and `PGID=1000`. To find your PUID and PGID, run `id user`.

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Updating the Container

Most of our images are static, versioned, and require an image update and container recreation to update the app. We do not recommend or support updating apps inside the container. Check the [Application Setup](#application-setup) section for recommendations for the specific image.

Instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull ai-chat-app`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d ai-chat-app`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/imagegenius/ai-chat-app:latest`
* Stop the running container: `docker stop ai-chat-app`
* Delete the container: `docker rm ai-chat-app`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

## Versions

* **05.03.23:** - Initial Release.
