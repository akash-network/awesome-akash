# Создание ключей валидатора Ethereum 2.0
1. Перейдите на страницу с релизами и скопируйте ссылку [актуальной версии](https://github.com/ethereum/staking-deposit-cli/releases).

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203358990-13b99c9f-1c02-4cd1-897f-39652d6861a6.png" width=70% </p>
  
2. Выполните в терминале `Linux`:
``` 
mkdir /tmp/deposit/ && \
wget -O /tmp/deposit.tar.gz https://github.com/ethereum/staking-deposit-cli/releases/download/v2.1.0/staking_deposit-cli-ce8cbb6-linux-amd64.tar.gz && \
tar -C /tmp/deposit/ -xf "/tmp/deposit.tar.gz" --strip-components 2 && \
deposit=/tmp/deposit/`ls /tmp/deposit` && \
rm /tmp/deposit.tar.gz
```
3. После установки проверьте работу командой `$deposit --help` ответ можете увидеть на скриншоте ниже:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203371388-d5f96ab6-2eec-440b-9d4f-6327bcfac431.png" width=70% </p>

4. Создайте аккаунт командой ниже, обратите внимание на флаги: `--num_validators` укажите сколько валидаторов хотите запустить, а так же `--chain`-укажите сеть
```
$deposit new-mnemonic --num_validators 2 --chain goerli
```
5. Выберите язык:
![image](https://user-images.githubusercontent.com/23629420/203832796-9ca02eca-aced-4167-a05c-4e6e0259edd8.png)
6. Установите необходимую сеть (mainnet/testnet):
![image](https://user-images.githubusercontent.com/23629420/203833326-98dd2593-8203-4046-95c9-aa1f942835d1.png)
7. Выберите язык мнемоник фразы: 
![image](https://user-images.githubusercontent.com/23629420/203833627-39061785-6d17-4dee-ad73-9cd71566efcf.png)
8. Установите пароль для хранилища ключей (**ВНИМАНИЕ, ПАРОЛЬ ОТ ЗРАНИЛИЩА КЛЮЧЕЙ ПОНАДОБИТСЯ ПРИ РАЗВЕРТЫВАНИИ НОДЫ! СОХРАНИТЕ ЕГО!**)
![image](https://user-images.githubusercontent.com/23629420/203833893-a3799ee4-0bd9-4a1f-bc7b-6584b8f317a6.png)
9. На этом шаге будет показана мнемоник фраза, для резервного доступа к аккаунту(**ВНИМАНИЕ,СОХРАНИТЕ МНЕМОНИК В НАДЕЖНОМ МЕСТЕ И ИСКЛЮЧИТЕ ДОСТУП ТЕРИТЬИХ ЛИЦ!**)
![image](https://user-images.githubusercontent.com/23629420/203834258-5026d800-93b3-44c5-8480-87c6f5e80d76.png)
Подтвердите что вы сохранили мнемоник повторным вводом фразы.
10. Ключи валидатора были успешно созданы по указанному адресу.

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203834770-96129c55-13f4-4653-a771-f703025ecda3.png" width=70% </p>

## Шифрование JSON файлов

Для передачи `deposit_data_xxxxxxx.json` и `keystore_xxxxx.json` внутрь контейнера, нам необходимо получить зашифорованную строку этих файлов.
Перейдите в папку с ключами из **п.10** (для меня это `/home/dimokus/validator_keys` ) и выполните команды:
```
cat имя_файла_deposit.json | openssl base64 -A
cat имя_файла_keystore.json | openssl base64 -A
```
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/203850724-df0813cd-ff75-4bd9-a4e0-eba273da5bd9.png" width=100% </p>

Внимательно скопируйте и сохраните выводы команд в текстовый файл, также скопируйте имена файлов, так как они понадобятся при заполнении файла `deploy.yml`.
