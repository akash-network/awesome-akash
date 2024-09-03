<div align="center">

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/219872517-2adc32b1-5f64-4d48-9a81-1e2ef6b01a53.png" width=90% </p>

# Sentinel dVPN node on Akash Network

</div>

___

<div align="center">
  
| [Twitter Decloud Nodes Lab](https://twitter.com/NodesLab) | [Discord Decloud Nodes Lab](https://discord.gg/rPENzerwZ8) |
|:--:|:--:|

| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | [Sentinel](https://sentinel.co/) |
|:--:|:--:|:--:|
___

Our news channels and technical support:

| [Discord Akash Network](https://discord.akash.network/) | [Telegram Akash Network](https://t.me/AkashNW) |  [Twitter Akash Network](https://twitter.com/akashnet_)
|:--:|:--:|:--:|
  
  
| [Discord Sentinel](https://discord.gg/HPW52yQuQJ) | [Telegram Sentinel dVPN](https://t.me/SentinelNodeNetwork) | [Twitter Sentinel](https://twitter.com/Sentinel_co)
|:--:|:--:|:--:|

| [Инструкция на русском](/Sentinel-dVPN-node/README_RU.md) |
|:--:|
</div>

___


### About Node and Sentinel dVPN

> Universal Declaration of Human Rights, Article 19: "Everyone has the right ... to seek, receive and 
> impart information and ideas through any media and regardless of frontiers."

*Today, many states are trying to hide from users "objectionable" information in their opinion. Unfortunately, 
from such a policy, people are deprived of the most important part 
of their rights and freedoms. The right to seek, consume and disseminate information today is not only a 
matter of entertainment content, but also a matter of education, freedom of thought and, of course, security.*

*Sentinel dVPN offers users to deploy dVPN servers around the world, united in a decentralized network. 
dVPN node owners are rewarded in dvpn tokens for every gigabyte passed through their node. Users of the Sentinel dVPN client side 
can choose among the nodes - which one they can connect to, which suits them in terms of information transfer speed, geographic location and, of course, price.
This instruction covers the launch of the server part - Sentinel dVPN nodes.*

___

## Preparation

#### Attention! Cloudmos is now used as Akash Console! The usual interface with a new name!

> To deploy a node, in this tutorial, I will use the [Akash Console Web interface](https://console.akash.network/).
How to work with it is [described in this document](https://github.com/DecloudNodesLab/Guides/blob/main/English/Cloudmos.md).
1. Create a separate account in `Keplr` for the dVPN node.
2. Encrypt the mnemonic phrase of the new account using `BASE64`, this can be done using the application [Notepad++](https://notepad-plus-plus.org/downloads/) (*Plugins-MIME Tools-Base64 Encode* ) or any **secure** online Base64 encoder.
3. Top up your created dVPN account with at least `1500dvpn` to pay for gas. You can buy dvpn on exchanges like `OSMOSIS` or `KUCOIN`.

## Node deployment
Open [WEB interface](https://console.akash.network/) `Akash Console`.

Make sure you have **more than 0.5 AKT** on your balance and **certificate present** (if not, refer to [Console instructions](https://github.com/DecloudNodesLab/Guides/blob/main/English/Cloudmos.md#create-certificate)). Next, click the `DEPLOY` button, select the empty `Empty` template and copy the contents of [deploy.yml](/Sentinel-dVPN-node//deploy.yml) there .
___

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221607947-cdc2b2e6-cc96-4709-9278-e15369bb62bf.gif" width=70% </p>
  
___
The `Sentinel dVPN` node requires a **dedicated IP address and static external ports**, for this you need to make small changes to the manifest (deploy.yml),
namely, replace `your_endpoint_name` in the `endpoints` and `expose` sections with a unique name (**Latin lowercase characters only!**)

Also, fill in the variables with your data:
* `MNEMONIC_BASE64` - Mnemonic phrase from a previously created sentinel account, encrypted with BASE64
* `MONIKER` - The name of your node, make it unique.
* `IPV4_ADDRESS` - leave blank for now.
> If you want to change `LISTEN_PORT` or `REMOTE_PORT` - don't forget to make the changes in the corresponding paragraphs of the `EXPOSE` section as well.
Also, for advanced users, [created a list of available variables](/Sentinel-dVPN-node/VARIABLES.md) with a short description.
  
Pay attention to the correct filling of the variables, they must be INSIDE the quotes, for example: <br/> `"MONIKER=dVPN on Akash Network v2RAY"`

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221614307-09813671-ed36-4db3-86d8-5836245f05f1.gif" width=70%</p>

We don't know what **IPv4** address we'll be assigned before we start the deployment, so we'll start the deployment with an empty `IPV4_ADDRESS`. We will fill it in as soon as we get the **IPv4** address from the provider and update our deployment. <br/>
It's time to ask for current offerings in the computing power market. We press `CREATE DEPLOYMENT`, confirm the transaction (**0.5 AKT** will be frozen) and wait for offers from providers.
  
<br/>
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221620076-7829428a-5832-4ff9-ab91-215875651d5a.gif" width=70% </p>
  
<br/>
  
As you can see, there were **3 providers** available in total, ready to provide computing power **with the static IP function**. I chose the cheapest one and continued deploy.<br/>
In the logs, we can see the **IPv4** address assigned to us. It also appears on the `LEASES` tab of our deployment.
All we have to do is copy it, paste it into our manifest (deploy.yml) on the `UPDATE` page and update the deployment. <br/>
Here's what it looks like:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221625686-4efca4c2-a3a0-4ebf-9933-09637b16d575.gif" width=70% </p>

**Deployment takes about 2 minutes.** Then the dVPN node will start working.<br/> <br/>
Example of correct working logs:<br/>
![image](https://user-images.githubusercontent.com/23629420/221644766-0b182d4b-813e-41ef-ab31-22cd55059583.png)<br/>
Also, if you open your sentinel address in [Explorer](https://www.mintscan.io/sentinel), you can see that there are transactions to update the status of your dVPN node.<br/>
This completes the installation!<br/> <br/>
Thank you for using **Akash Network**!
