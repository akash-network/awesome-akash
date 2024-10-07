With RAIRprotocol open deployment layer, developers can #buidl and scale new dApps 10x faster. Our philosophy is that by building an open source deployment layer, we can 10x the speed of innovation in the Web3 space. Devs + Integrations + Open DevOps = 1000x more dApps :rocket:)





# Open Deployment Layer

Dozens of out-of-the-box configurations available today, thousands more tomorrow with your help!



* Web3 integration partners (Alchemy, Web3Auth, Akash Network, Filebase ++)

* Blockspace partners (Soneium, Base, Root Network, CoreDAO ++)

* Web2 partners (GCP, MongoDB, REDIS ++) 



Simply replace environment variables referenced in your docker compose files to deploy your own fully open source self sovereign dApps. 



# Deployment Overview



This Akash SDL is preconfigured with everything you'll need to run our deployment layer. Simply click the deployment button and you'll have successfully deployed your first dApp!



* Level 1: Our default docker images. In level 1 all you need to do is click the deploy button! This will run our default app with our default API keys. 

* Level 2: Your own rair-front frontend docker image. To get your app to work properly (such as allow users to login with their socials) you'll need to build your own frontend image with your own API keys. 

* Level 3: Your own backend images, your own smart contracts. Once you get the hang of Docker, the sky is the limit for building production grade dApps.  



Everything you need to deploy RAIRprotocol is available directly in our Github github.com/rairprotocol 



# Admin credentials



To login to the administrator area of our default dApp, you'll need a free NFT license credential. You can mint one at https://rairlicense.org or https://rair.market 



# Your own dApp



Our dApp isn't your dApp. As an example, Ww provide default Alchemy and Web3Auth API keys. For RAIRprotocol to be your dApp, you'll need to build your own rair-front Docker image with your own Alchemy and Web3Auth keys. 



Once you have edited your docker compose file with your own API keys, make a new docker image by using this command



`sudo docker build -t rair-front:latest -f rair-front/Dockerfile.prod rair-front`



Finally, replace the rair-front image hash in the default Akash configuration with your own rair-front image. 



> Don't forget to whitelist your Akash URL in Web3Auth for social logins to work!



# Go Deeper



To learn how to deploy your own custom backend, syncing, DRM media services, solidity, new integrations, and much more visit our Github to submit your first issue!



We are unveiling a points system soon to reward developers who help us so stay tuned and get stated today @ github.com/rairprotocol (Follow, star, fork, and earn)
