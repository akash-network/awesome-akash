# Why use Akash?

Welcome [Chia](https://www.chia.net/) community! We are excited to announce support for Chia on the [Akash](https://akash.network) network!  You can now run farmers and plotters on our marketplace of compute.  Below you will find details on how to configure your deployment for different use cases.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

### Providers

For the following providers who are participating in the sale, expect to see these prices in Akashlytics! Each provider has been benchmarked and tested to create a $0.10/plot. &#x20;

| On-Sale Providers      | BladeBit Price / Month   | MadMax Price  / Month  |
| ---------------------- | ------------------------ | ---------------------- |
| bigtractorplotting.com | $556 \| 8 Minute Plots   | $59 \| 71 Minute Plots |
| xch.computer           | $363 \| 12 Minute Plots  | $44 \| 95 Minute Plots |
| akash.world            | $174  \| 24 Minute Plots | $42 \| 99 Minute Plots |

Copy and Paste the Following SDL :

[Bladebit Summer Sale SDL](#bladebit-summer-sale-sdl)

[MadMax Summer Sale SDL](#madmax-summer-sale-sdl)

For a complete guide on how to customize the SDL, including configuring rclone and ssh destinations please see [Chia on Akash](https://docs.akash.network/integrations/chia-on-akash/)

# MadMax Summer Sale SDL
Copy and Paste this after you click Deploy.  Be sure to update your contract and farmer key!
```
---
version: "2.0"

services:
  chia:
    image: cryptoandcoffee/akash-chia:200
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true
    env:
    #############################REQUIRED##############################
      - VERSION=1.3.5
     #Always check https://github.com/Chia-Network/chia-blockchain/releases
      - CONTRACT=
      - FARMERKEY=
      - PLOTTER=madmax
     #Choose your plotter software - madmax, bladebit, bladebit-disk
      - FINAL_LOCATION=local
     #Set to "local" to access finished plots through web interface.
     #Set to "upload" and finished plots will be uploaded to a SSH destination like user@ip:/home/user/plots
      - CPU_UNITS=8
      - MEMORY_UNITS=6Gi
      - STORAGE_UNITS=815Gi
     #Must match CPU/Memory/Storage units defined in resources.
    #############################OPTIONAL##############################
     #Uncomment the variables below when set FINAL_LOCATION=upload to enable remote uploading
      #- REMOTE_HOST=changeme.com #SSH upload host
      #- REMOTE_LOCATION=changeme #SSH upload location like /root/plots
      #- REMOTE_PORT=22 #SSH upload port
      #- REMOTE_USER=changeme #SSH upload user
      #- REMOTE_PASS=changme #SSH upload password
      #- UPLOAD_BACKGROUND=true
     #Change to true to enable multiple background uploading of plots, this is the best option to use use 100% of your bandwidth.
      #- RAMCACHE=32G
      #Used only for PLOTTER=bladebit-disk, you must increase the memory resources requested below with this additional cache size.
      #- RCLONE=false
     #When true must also update JSON_RCLONE and add any destination in same format.
      #- TOTAL_UPLOADS=1000
     #Set the total number of parallel uploads allowed to an rclone destination
      #- ENDPOINT_LOCATION=
     #Only used for RCLONE=true
      #- ENDPOINT_DIR=
     #Only used for RCLONE=true
      #- JSON_RCLONE=
      #  [storj]\n
      #  type = storj\n
      #  api_key = replaceme\n
      #  passphrase = replaceme\n
      #  satellite_address = x@us-central-1.tardigrade.io:7777\n
      #  access_grant = replaceme
     #Example of STORJ config for RCLONE=true.  If you want to use your own endpoint please escape each line with a backslash n, like in the example.
profiles:
  compute:
    chia:
      resources:
        cpu:
          units: 8.0
        memory:
          size: 6Gi
        storage:
          size: 815Gi
  placement:
    akash:
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      attributes:
        chia-plotting: "true"
      pricing:
        chia:
          denom: uakt
          amount: 100000
deployment:
  chia:
    akash:
      profile: chia
      count: 1
```
