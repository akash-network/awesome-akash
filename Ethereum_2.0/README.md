## Ethereum 2.0 node deployment

>If you don't have validator keys, go to [how to create one](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_en(Linux).md)).

Fill in the variables in the [SDL file](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/deploy_alternarive.yml):

`"- DEPOSIT_JSON_BASE64="` - encrypted **deposit_data_xxxxxxx.json** with base64 ([Generation instruction](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_en(Linux).md#encrypt-json-files))</br>

`- "DEPOSIT_FILE_NAME="` - Full name of deposit_data file with json extension, </br>for example: `- "DEPOSIT_FILE_NAME=deposit_data-1679338505.json"`</br>

`- "KEYSTORE_JSON_BASE64="`- encrypted **keystore_xxxxx.json** with base64 ([Generation instruction](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_en(Linux).md#encrypt-json-files))</br>

`- "KEYSTORE_FILE_NAME="` - Full name of the keystore file with json extension, </br>for example: `- "KEYSTORE_FILE_NAME=keystore-m_12381_3600_0_0_0-1679338504.json"`</br>

`- "ACCOUNT_ETH_PASS="` - password from the validator keys from ([point 8 of the instruction](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_en(Linux).md))
      
`- "RECEPIENT="` - recipient of rewards.

## Развертка ноды Ethereum 2.0

>Если у вас нет ключей валидатора, перейдите [к инструкции по их созданию](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_ru(Linux).md).

Заполните переменные в [SDL файл](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/deploy_alternarive.yml):

`- "DEPOSIT_JSON_BASE64="` - зашифрованный **deposit_data_xxxxxxx.json** с помощью base64 ([Инструкция по генерации](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_ru(Linux).md#%D1%88%D0%B8%D1%84%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-json-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2))</br>

`- "DEPOSIT_FILE_NAME="` - Полное имя файла deposit_data с расширением json, </br>например: `- "DEPOSIT_FILE_NAME=deposit_data-1679338505.json"`</br> 

`- "KEYSTORE_JSON_BASE64="`- зашифрованный **keystore_xxxxx.json** с помощью base64 ([Инструкция по генерации](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_ru(Linux).md#%D1%88%D0%B8%D1%84%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-json-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2))</br>

`- "KEYSTORE_FILE_NAME=` - Полное имя файла keystore с расширением json, </br>например: `- "KEYSTORE_FILE_NAME=keystore-m_12381_3600_0_0_0-1679338504.json"`</br> 

`- "ACCOUNT_ETH_PASS="` - пароль от ключей валидатора из [п.8 инструкции](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Active_testnets/Ethereum2/create_validator_key_ru(Linux).md)
      
`- "RECEPIENT="` - получатель вознаграждений.
