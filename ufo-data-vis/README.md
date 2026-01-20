# UFO Sightings Data Visualization

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ufo-data-vis)


This data visualization project showcases a tool for exploring over 80K reports of UFO sightings around the world collected from 1906 - 2014. The original project page is [here](https://github.com/wlouie1/UFO-Sightings). 

![ufosightings](https://raw.githubusercontent.com/wlouie1/UFO-Sightings/master/resources/images/a4ufo_small.gif)

The project was built using vanilla JS/HTML/CSS, and a [docker image](https://hub.docker.com/r/wlouie1/ufo-data-vis) was created to bundle a simple Nginx server to serve the static files. The `deploy.yaml` uses this docker image to very easily deploy the app on Akash.
