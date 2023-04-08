# SoftEther VPN in Akash

## What is SoftEther

SoftEther VPN is one of the world’s most powerful and easy-to-use multi-protocol VPN software, made by the good folks at the University of Tsukuba, Japan. It runs on Windows, Linux, Mac, FreeBSD and Solaris and is freeware and open-source. You can use SoftEther for any personal or commercial use free of charge.

### What works

- OpenVPN over a mapped 443/tcp port;
- SoftEther over a mapped 443/tcp (or 992, 5555 tcp) ports;

### What does not

- L2TP/IPsec is not currently working due to the current Akash direct (1:1) port mapping limitation.

## Ports

Since Akash does not support direct (1:1) port mapping yet, you will have to check the mapped ports (`akash provider lease-status`).  
Your best bet would be to use OpenVPN via 443/tcp since this will work out-of-a-box in Akash.

### L2TP/IPSec

> Not working without 1:1 port mapping support.

- "500:500/udp"
- "4500:4500/udp"

### OpenVPN/SSTP/SoftEther VPN

> Check the mapped port (`akash provider lease-status`) and use that port.

- "443:443/tcp"

### OpenVPN

> Not working without 1:1 port mapping support.

- "1194:1194/udp"

### SoftEther VPN

- "5555:5555/tcp"
- "992:992/tcp"

## Notes

## L2TP/IPSec

### Android 12

Android 12 [no longer](https://github.com/SoftEtherVPN/SoftEtherVPN/issues/13#issuecomment-873617246) allows legacy VPN such as L2TP/IPSec.

SoftEther does not support IKEv2/IPSec [yet](https://github.com/SoftEtherVPN/SoftEtherVPN/issues/1373)

### Ubuntu

You can use L2TP/IPSec in Ubuntu:

```
sudo apt-get -y install network-manager-l2tp-gnome
```

Now you can add the L2TP VPN profile in Gnome Network settings.

Make sure to enable the following options:

**L2TP IPSec Options**

```
Phase 1 Algorithms: aes128-sha1-modp2048
Phase 2 Algorithms: aes128-sha1
```

## OpenVPN

### OpenVPN for Android

AUTHENTICATION/ENCRYPTION -> Encryption -> Enter data encryption methods:

```
AES-256-CBC
```

### Microsoft SSTP

It's supported by the SoftEther, though, I've kept it disabled for now.

Feel free to enable it and submit a PR!

## SoftEther VPN Client

Download SoftEther VPN Client software from https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases

Get VPN credentials from "Username & Password for VPN authentication" after deployment starts.

```
ACCOUNT=<your vpn username>
PASSWORD=<your vpn password>
```

Connect to your SoftEther instance running in Akash.

Make sure to change `d3akash.cloud:32505` to yours, mapped to `443/tcp` port.

```
cd vpnclient
sudo ./vpnclient start

./vpncmd /CLIENT 127.0.0.1 /CMD NicCreate 1
./vpncmd /CLIENT 127.0.0.1 /CMD AccountCreate $ACCOUNT /SERVER:d3akash.cloud:32505 /HUB:DEFAULT /USERNAME:$ACCOUNT /NICNAME:1
./vpncmd /CLIENT 127.0.0.1 /CMD AccountPassword $ACCOUNT /TYPE:standard /PASSWORD:$PASSWORD
./vpncmd /CLIENT 127.0.0.1 /CMD AccountConnect $ACCOUNT

./vpncmd /CLIENT 127.0.0.1 /CMD AccountStatusGet $ACCOUNT
```

> `81.6.58.121` is the IP address of `d3akash.cloud` (yours will be different should you chose another Akash provider)

Find default network device and pass the route for your SoftEther deployment over it:

```
$ ip route | grep default
default via 10.1.0.1 dev wlo1 proto dhcp metric 600

$ sudo ip route add 81.6.58.121 via default dev wlo1
```

Only now you can run the `dhclient` over your SoftEther VPN network interface card:

```
sudo dhclient -d vpn_1
```

Now your VPN connection should be working!

Tearing down:

```
sudo pkill dhclient
./vpncmd /CLIENT 127.0.0.1 /CMD AccountDisconnect $ACCOUNT
./vpncmd /CLIENT 127.0.0.1 /CMD AccountDelete $ACCOUNT
./vpncmd /CLIENT 127.0.0.1 /CMD NicDelete 1

sudo ip route del 81.6.58.121 via default dev wlo1
```

## References

- https://www.softether.org
- https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases
- https://www.digitalocean.com/community/tutorials/how-to-setup-a-multi-protocol-vpn-server-using-softether
- https://github.com/SoftEtherVPN/SoftEtherVPN/issues/1373
- https://github.com/SoftEtherVPN/SoftEtherVPN/issues/13#issuecomment-873617246
