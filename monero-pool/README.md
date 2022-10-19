# Run a Private Monero Mining Pool

Step 1 : Setup your Monero wallet - you will need the seed phrase and another wallet for the fee recipient.

Step 2 : Update the env: variables with your information, be sure NOT to use quotes for the seed phrase.

Step 3 : Deploy and wait.  Be patient - deploying a pool takes at least 24 hours to be ready.  Be sure to fund your deployment with enough AKT!

Step 4 : Click the URI link.  You should now see the web interface.

# Security of your private keys

You should assume this deployment is the equivalent of a hot wallet.  Do not use this wallet for long term storage of coins.
Do not remove the signing attribute from this deployment.

# A Monero mining pool server written in C.

Design decisions are focused on performance and efficiency, hence the use of
libevent and LMDB.  Currently it uses only *two* threads under normal operation
(one for the stratum clients and one for the web UI clients). It gets away with
this thanks to the efficiency of both LMDB and libevent (for the stratum
clients) and some sensible proxying/caching being placed in front of the [web
UI](#web-ui).

Configuration is extremely flexible, now allowing for the pool to run in a
variety of setups, such as highly available and redundant configurations.
Discussed further below in: [Interconnected pools](#Interconnected-pools).

This pool was the *first* pool to support RandomX and is currently the *only*
pool which supports the RandomX fast/full-memory mode.

The single payout mechanism is PPLNS, which favors loyal pool miners, and there
are no plans to add any other payout mechanisms or other coins. Work should stay
focussed on performance, efficiency and stability.

The pool also supports an optional method of mining whereby miners select their
*own* block template to mine on. Further information can be found in the
document: [Stratum mode self-select](./sss.md).

For testing, a reference mainnet pool can be found at
[monerop.com](http://monerop.com).

## Help / Contact

If you need help setting up your own pool, you can find
me (jtgrassie) on IRC in [#monero-pool](irc://chat.freenode.net/#monero-pool)
and many of the other Monero channels.

## Supporting the project

This mining pool has **no built-in developer donation** (like *other* mining
pool software has), so if you use it and want to donate, XMR donations to:

```
451ytzQg1vUVkuAW73VsQ72G96FUjASi4WNQse3v8ALfjiR5vLzGQ2hMUdYhG38Fi15eJ5FJ1ZL4EV1SFVi228muGX4f3SV
```

would be very much appreciated.
