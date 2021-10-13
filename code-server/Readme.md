# Akash Code-Server

Launch a [Code-Server](https://coder.com/) server on the Akash blockchain. Run VS Code on any machine anywhere and access it in the browser.  Visit the [code-server](https://github.com/cdr/code-server) github repo to learn more.



## Requirements

Linux machine with WebSockets enabled, 1 GB RAM, and 2 CPUs. 
## Environment Variables

Information about the Environment Variables for this docker image can be found in the [linuxserver/docker-code-server](https://github.com/linuxserver/docker-code-server) github repo.
### Required Variables

```yaml
  - PUID=1000
  - PGID=1000
  - PASSWORD=password 
  - SUDO_PASSWORD=password
```

### Optional Variables

```yaml
  - TZ=Europe/London
  - HASHED_PASSWORD= #optional
  - SUDO_PASSWORD_HASH= #optional
  - PROXY_DOMAIN=code-server.my.domain #optional
```