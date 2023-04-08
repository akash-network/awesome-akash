# Generate Ethereum 2.0 validator keys
1. Go to the releases page and copy the [current version](https://github.com/ethereum/staking-deposit-cli/releases) link.

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203358990-13b99c9f-1c02-4cd1-897f-39652d6861a6.png" width=70% </p>
  
2. Run in the `Linux` terminal:
```
mkdir /tmp/deposit/ && \
wget -O /tmp/deposit.tar.gz https://github.com/ethereum/staking-deposit-cli/releases/download/v2.1.0/staking_deposit-cli-ce8cbb6-linux-amd64.tar.gz && \
tar -C /tmp/deposit/ -xf "/tmp/deposit.tar.gz" --strip-components 2 && \
deposit=/tmp/deposit/`ls /tmp/deposit` && \
rm /tmp/deposit.tar.gz
```
3. After installation, check the operation with the `$deposit --help` command, you can see the answer in the screenshot below:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203371388-d5f96ab6-2eec-440b-9d4f-6327bcfac431.png" width=70% </p>

4. Create an account with the command below, pay attention to the flags: `--num_validators` specify how many validators you want to run, as well as `--chain`-specify the network
```
$deposit new-mnemonic --num_validators 2 --chain goerli
```
5. Choose a language:
![image](https://user-images.githubusercontent.com/23629420/203832796-9ca02eca-aced-4167-a05c-4e6e0259edd8.png)
6. Install the required network (mainnet/testnet):
![image](https://user-images.githubusercontent.com/23629420/203833326-98dd2593-8203-4046-95c9-aa1f942835d1.png)
7. Select the language of the phrase mnemonics:
![image](https://user-images.githubusercontent.com/23629420/203833627-39061785-6d17-4dee-ad73-9cd71566efcf.png)
8. Set a password for the keystore (**ATTENTION, THE PASSWORD FOR THE KEYSTORAGE WILL BE REQUIRED WHEN DEPLOYING A NODE! SAVE IT!**)
![image](https://user-images.githubusercontent.com/23629420/203833893-a3799ee4-0bd9-4a1f-bc7b-6584b8f317a6.png)
9. At this step, a mnemonic phrase will be shown for backup access to the account (**ATTENTION, SAVE THE mnemonic IN A SAFE PLACE AND EXCLUDE ACCESS TO LOSSED PERSONS!**)
![image](https://user-images.githubusercontent.com/23629420/203834258-5026d800-93b3-44c5-8480-87c6f5e80d76.png)
Confirm that you have saved the mnemonic by re-entering the phrase.
10. Validator keys have been successfully generated at the specified address.

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203834770-96129c55-13f4-4653-a771-f703025ecda3.png" width=70% </p>

## Encrypt JSON files

To pass `deposit_data_xxxxxxx.json` and `keystore_xxxxx.json` inside the container, we need to get the encrypted string of these files.
Go to the folder with the keys from **p.10** (for me it's `/home/dimokus/validator_keys` ) and run the commands:
```
cat filename_deposit.json | openssl base64 -A
cat filename_keystore.json | openssl base64 -A
```
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203850724-df0813cd-ff75-4bd9-a4e0-eba273da5bd9.png" width=100%</p>

Carefully copy and save the output of the commands to a text file, also copy the file names as you will need them when filling out the deploy.yml file.
