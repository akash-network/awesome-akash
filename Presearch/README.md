# Presearch-Akash
Go to https://nodes.presearch.org to learn more about nodes and create an account.
Go go https://nodes.presearch.org/ to grab your registration code
replace <YOUR_REGISTRATION_CODE_HERE> in your deploy.yaml file:
deploy.yaml:
---
version: "2.0"

services:
  presearch:
    image: presearch/node:1.0.2
    env:
      - 'REGISTRATION_CODE=<YOUR_REGISTRATION_CODE_HERE>'
    # need to expose at least 1 port otherwise "Error: invalid manifest: zero global services"
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true

profiles:
  compute:
    presearch:
      resources:
        cpu:
          units: 1.0
        memory:
          size: 512Mi
        storage:
          size: 1Gi
  placement:
    akash:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      pricing:
        presearch:
          denom: uakt
          amount: 100

deployment:
  presearch:
    akash:
      profile: presearch
      count: 1
Refs.

https://hub.docker.com/r/presearch/node
https://docs.presearch.org/nodes/setup#hardware-specification
https://docs.presearch.org/nodes/vps-setup/linux-vps
https://discord.com/channels/747885925232672829/771909909335506955/960640579992191016
When akash v0.15 gets released, you can leverage the persistent storage for /app/node mount point.

When migrating the node, make sure to copy /app/node/.keys directory over to the new one.

