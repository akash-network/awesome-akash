# Sovryn Node

Check out the [Project site](https://github.com/DistributedCollective/Sovryn-Node):

The `deploy.yaml` uses an [unofficial Docker image](https://hub.docker.com/r/nrm55/sovryn-node) at-the-moment. Please read below for tips on deploying to Akash. There is a video of me running through this process [here](https://youtu.be/Iinsjgolmu8).

### First: Setup environment variables first, edit deploy.yaml's env block:
Your `env:` block in `deploy.yaml` should look much like this. Addresses need to be properly checksummed, and wallets are web3keyfiles.
```
      - WHICHNET=test
      - KEYPW=T3stS0vryn
      - LIQUIDATOR_ADDRESS=0xg7c2222222222222222222222222222222D82356
      - LIQUIDATOR_PRIVATE_KEY={"version":3,"id":"02222222-5f38-4e77-adca-222222222222","address":"2722222222222222222222222222222222222226","crypto":{"ciphertext":"243be5c5b6f222222222222222222222222222222222222222222829b5d90990","cipherparams":{"iv":"0afc22222222222222222222222222cf"},"cipher":"aes-128-ctr","kdf":"scrypt","kdfparams":{"dklen":32,"salt":"9d022222222222222222222222222222222222222222222222222222e8edbb6d","n":8192,"r":8,"p":1},"mac":"f780ecb94573fbdf22222222222222222222222222222222222222222261b7b0"}}
      - ROLLOVER_ADDRESS=0x2722222222222222222222222222222222222356
      - ROLLOVER_PRIVATE_KEY={"version":3,"id":"05e4bf24-5f38-4e77-adca-222222222226","address":"27c2222222222222222222222222222222222226","crypto":{"ciphertext":"2432222222222222222222222222222222222222222222b98483d829b5d90990","cipherparams":{"iv":"0afcf2222222222222222222222227cf"},"cipher":"aes-128-ctr","kdf":"scrypt","kdfparams":{"dklen":32,"salt":"9d22222222222222222222222222222222222222222222222222222228edbb6d","n":8192,"r":8,"p":1},"mac":"f780ecb94573fbdff2222222222222222222222222222222222222222221b7b0"}}
      - ARBITRAGE_ADDRESS=0x2222222222222222222222222222222222222356
      - ARBITRAGE_PRIVATE_KEY={"version":3,"id":"05e4bf24-5f38-4e77-adca-222222222226","address":"27c2222222222222222222222222222222222256","crypto":{"ciphertext":"243be22222222222222222222222222222222222222222222222d829b5d90990","cipherparams":{"iv":"0afc22222222222222222222222227cf"},"cipher":"aes-128-ctr","kdf":"scrypt","kdfparams":{"dklen":32,"salt":"9d04522222222222222222222222222222222222222222222222222ae8edbb6d","n":8192,"r":8,"p":1},"mac":"f780ec222222222222222222222222222222222222222222222222222221b7b0"}}
      - TELEGRAM_BOT_KEY=
```

### Second: Deploy to Akash:
Please watch the video if any of these steps are confusing. Refer to Akash for missing stuff, you'll need to create your cert, get some environment variables setup (AKASH_NODE, AKASH_CHAIN_ID, KEY_NAME, KEY_BACKEND, ...)
1. create deployment, get DSEQ into $DSEQ
```
akash tx deployment create akash-deploy.yaml --from $KEY_NAME --keyring-backend $KEYRING_BACKEND --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID -y --fees 5000uakt
```
2. check bids
```
akash query market bid list --owner=$ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ
```
3. accept a bid by creating lease, get provider into $PROVIDER
```
akash tx market lease create --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --owner $ACCOUNT_ADDRESS --dseq $DSEQ --gseq $GSEQ --oseq $OSEQ --provider $PROVIDER --from $KEY_NAME --fees 5000uakt --keyring-backend $KEYRING_BACKEND
```
4. check lease status
```
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ
```
5. upload our manifest, wait for spinup
```
akash provider send-manifest akash-deploy.yaml --keyring-backend $KEYRING_BACKEND --node $AKASH_NODE --from=$KEY_NAME --provider=$PROVIDER --dseq $DSEQ --log_level=info --home ~/.akash
```
6. check the lease status
```
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $DSEQ --from $KEY_NAME --provider $PROVIDER --keyring-backend $KEYRING_BACKEND
```
7. Optional but super helpful: Check logs
```
akash provider lease-logs --dseq=$DSEQ --from=$ACCOUNT_ADDRESS --provider=$PROVIDER
```
