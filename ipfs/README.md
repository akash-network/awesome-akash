# IPFS - InterPlanetary File System
The InterPlanetary File System (IPFS) is a protocol and peer-to-peer network for storing and sharing data in a distributed file system. IPFS uses content-addressing to uniquely identify each file in a global namespace connecting all computing devices. 
(Source: [Wikipedia](https://en.wikipedia.org/wiki/InterPlanetary_File_System))


## Setup
After deploying the container the web ui will be accessible at port 80. However you will need to enter the IPFS API URL there to make it work. The IPFS API runs on port 5001, but AKASH publishes a random port and then forwards it to port 5001. With the lease-status command you have to look which port is forwarded under "forwarded_ports". Then enter the following as IPFS API URL `http://host:port` (ex: http://cluster.ews1p0.mainnet.akashian.io:30328).