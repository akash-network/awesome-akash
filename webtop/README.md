# Webtop on Akash Network
___

Open [WEB interface](https://console.akash.network/) `Akash Console`.

Make sure you have **more than 0.6 AKT** on your balance and **certificate present** (if not, refer to [Akash Console instructions](https://github.com/DecloudNodesLab/Guides/blob/main/English/Cloudmos.md)).

Next, press the `DEPLOY` button, select the empty `Empty` template and copy the content of [deploy.yml](https://github.com/DecloudNodesLab/Projects/blob/main/Software/Webtop/deploy.yml).

___

`Webtop` - **Alpine**, **Ubuntu**, **Fedora**, and **Arch** based containers containing full desktop environments in officially supported flavors accessible via any modern web browser.

Supported Architectures
We utilise the docker manifest for multi-platform awareness. More information is available from docker here and our announcement here.

Simply pulling lscr.io/linuxserver/webtop:latest should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

### Version Tags

This image provides various versions that are available via tags. Please read the descriptions carefully and exercise caution when using unstable or development tags.

| Tag |	Available	| Description|
| :-----: | :-----: |  :-----: |   
|`latest`|✅| XFCE Alpine |
|`ubuntu-xfce`|	✅|	XFCE Ubuntu |
|`fedora-xfce`|	✅|	XFCE Fedora |
|`arch-xfce`|	✅|	XFCE Arch |
|`alpine-kde`|	✅|	KDE Alpine |
|`ubuntu-kde`|	✅|	KDE Ubuntu |
|`fedora-kde`|	✅	|KDE Fedora |
|`arch-kde`|	✅	|KDE Arch <br/>
|`alpine-mate`|	✅	|MATE Alpine <br/>
|`ubuntu-mate`|	✅|	MATE Ubuntu <br/>
|`fedora-mate`|	✅|	MATE Fedora <br/>
|`arch-mate`|	✅|	MATE Arch <br/>
|`alpine-i3`|	✅|	i3 Alpine <br/>
|`ubuntu-i3`|	✅	|i3 Ubuntu <br/>
|`fedora-i3`|	✅	|i3 Fedora <br/>
|`arch-i3`|	✅	|i3 Arch <br/>
|`alpine-openbox`|	✅|	Openbox Alpine <br/>
|`ubuntu-openbox`|	✅|	Openbox Ubuntu <br/>
|`fedora-openbox`|	✅|	Openbox Fedora <br/>
|`arch-openbox`|	✅|	Openbox Arch <br/>
|`alpine-icewm`|	✅|	IceWM Alpine <br/>
|`ubuntu-icewm`|	✅|	IceWM Ubuntu <br/>
|`fedora-icewm`|	✅|	IceWM Fedora <br/>
|`arch-icewm`|	✅|	IceWM Arch <br/> 

A detailed description of the contents of the image, its variables and settings is available at:

https://hub.docker.com/r/linuxserver/webtop

___

Thank you for using **Akash Network**!
