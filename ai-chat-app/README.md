Self-Hosted ChatGPT  

![](https://raw.githubusercontent.com/88plug/awesome-akash/ai/ai-chat-app/screenshots/welcome.png)

## Requirements

To use this app, you need a ChatGPT API key. [Get your key from OpenAI API Keys.](https://platform.openai.com/account/api-keys)

## Setting up the App

By default, the server runs on port 3000 and is assigned an ephemeral port by the provider. Once deployed, access the web interface by clicking on "Forwarded Ports" in Cloudmos.

![image](https://user-images.githubusercontent.com/19512127/224119623-47c80369-75c9-412d-a4fd-66d98c2cb778.png)

To use the OpenAI API, you must provide your API key in the app settings. Simply navigate to your Settings, enter the API Key, and click "Save".

![](https://raw.githubusercontent.com/88plug/awesome-akash/ai/ai-chat-app/screenshots/api-key.png)

Now you can start a new chat.

## Templates

Templates are available to be imported
![](https://raw.githubusercontent.com/88plug/awesome-akash/ai/ai-chat-app/screenshots/templates.png)

## Chat Interface

![](https://raw.githubusercontent.com/88plug/awesome-akash/ai/ai-chat-app/screenshots/interface.png)

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
