# Nitropage

Visit [https://nitropage.com/](https://nitropage.com/) for more information about `Nitropage`.  
  
This repository contains an example deployment for the `Nitropage Starter` project.  
It uses a SQLite database and is intended for demo purpose only.  
  
This Akash template can be deployed as is using the pre-built Docker image or re-built and customized using [this repository](https://github.com/0x1d/nitropage-akash).

## Getting Started

- deploy this template with your favorite deployment tool for Akash (e.g. [Akash Console](https://console.akash.network/))
    - change `NITRO_AUTH_SALT` and `NP_AUTH_IRON_PASSWORD`
- when the deployment is up and running, visit http://your-deployment-url/admin to create an admin account
- after first login you can now create a Nitropage project
    - set the domain name to your Akash deployment domain, in case you intend to create multiple projects
- now you're ready to create your website

## Build your own Docker image

To build the Docker image, run following command:

```
docker build -t myorg/nitropage:0.54.1 --build-arg VERSION=0.54.1 .
```

The build argument is the version of Nitropage you'd like to build, in this case `0.54.1`

And of course, push the image to the Docker registry:

```
docker push myorg/nitropage:0.54.1
```

## About

From [Nitropage](https://codeberg.org/nitropage/nitropage)

Nitropage is a completely free, open-source, self-hostable alternative to premium, visual drag-and-drop website builders such as [Squarespace](https://www.squarespace.com/) and [Wix](https://www.wix.com/). Write your own building blocks with [SolidJS](https://www.solidjs.com/) and enjoy the power of HMR!

## Features

- [x] Publishing Workflow with Page Revisions
- [x] Element Setting Presets
- [x] Multiple Websites on a single instance
- [x] Custom Page Elements with [SolidJS](https://www.solidjs.com/)
- [x] Powerful Developer Architecture with [Vite](https://vitejs.dev/)
- [x] Automatic sitemap.xml and Atom-feed handling 
- [ ] And [many more to come](https://nitropage.com/#roadmap)
