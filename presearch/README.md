# Presearch-Akash

1. Go to https://nodes.presearch.org to learn more about nodes and create an account.  
2. Go go https://nodes.presearch.org/ to grab your registration code.  
3. Replace <YOUR_REGISTRATION_CODE_HERE> in your [deploy.yaml](./deploy.yaml) file.  


## Notes

You can leverage the persistent storage for `/app/node` mount point.  
When migrating the node, make sure to copy `/app/node/.keys` directory over to the new one.

## Refs.

- https://hub.docker.com/r/presearch/node
- https://docs.presearch.org/nodes/setup#hardware-specification
- https://docs.presearch.org/nodes/vps-setup/linux-vps
- https://discord.com/channels/747885925232672829/771909909335506955/960640579992191016

