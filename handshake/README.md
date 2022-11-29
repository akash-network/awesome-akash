# handshake-full-listening-node-akash

This is an SDL file that will deploy a full listening handshake node onto akash.

[Link to Akash SDL File](https://github.com/FliKites/handshake-node-akash/blob/main/deploy.yaml)

Deploy using CloudMOS: https://cloudmos.io/cloud-deploy

Open Cloudmos and click "Deploy" 
<br>

Step 0: Choose the "Empty" option and paste the [SDL](https://github.com/FliKites/handshake-node-akash/blob/main/deploy.yaml) file.
<br>

Step 1: Create a unique name under```endpoints:``` You will be changing line 4. Leave the colon.
<br>

Step 2: Use the same name to replace line 14. Leave ip: only change the name.
<br>

Step 3: Wait until the blockchain has synced (check the "logs" tab to see chain height) then edit the --public-host environment variable to reflect the instances public/static IP address. (Check the "Leases" tab for the IP) Once changed, click "Update Deployment"

<br>

More information related to handshake node configuration types: https://hsd-dev.org/guides/config.html

# Full Node that allows inbound connections from other full and light clients like hnsd
<IP address> MUST be your external IP address, publicly accessible by the internet.

hsd \
--bip37=true   \
--listen=true   \
--public-host=<IP address>
--public-port=12038  \
--max-inbound=100	




