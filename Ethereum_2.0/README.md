## Ethereum 2.0 node deployment

>If you don't have validator keys, go to [how to create one](/Ethereum_2.0/create_validator_key_en(Linux).md)).

Fill in the variables in the [SDL file](/Ethereum_2.0/deploy.yml):

|Variable|Description|
| :-------: | :-------: |
| `DEPOSIT_JSON_BASE64` | Encrypted **deposit_data_xxxxxxx.json** with base64 ([Generation instruction](/Ethereum_2.0/create_validator_key_en(Linux).md#encrypt-json-files)) |
| `DEPOSIT_FILE_NAME` | Full name of deposit_data file with json extension, for example:</br> `- "DEPOSIT_FILE_NAME=deposit_data-1679338505.json"`|
|`KEYSTORE_JSON_BASE64`| Encrypted **keystore_xxxxx.json** with base64 ([Generation instruction](/Ethereum_2.0/create_validator_key_en(Linux).md#encrypt-json-files))|
|`KEYSTORE_FILE_NAME`| Full name of the keystore file with json extension, for example:</br>`- "KEYSTORE_FILE_NAME=keystore-m_12381_3600_0_0_0-1679338504.json"`|
|`ACCOUNT_ETH_PASS`| Password from the validator keys from ([point 8 of the instruction](/Ethereum_2.0/create_validator_key_en(Linux).md))|      
|`RECEPIENT`|Recipient of rewards.|
|`SNAP_URL`| State sync address, for goerli network will look like this: </br>`- "SNAP_URL=https://prater-checkpoint-sync.stakely.io"`.|

### Resources

Choose resources according to your tasks, since for example, disk usage with `state sync` enabled in the `goerli` network will be about **300GB**, while the full archive of the Ethereum main network blockchain will require up to **1.5TB** hard drive. Use `state sync` if your application does not care about historical network data. Helps save hard drive space.

```
       resources:
         cpu:
           units: 4.0
         memory:
           size: 9Gi
         storage:
           - size: 300Gi
```

## Развертка ноды Ethereum 2.0

>Если у вас нет ключей валидатора, перейдите [к инструкции по их созданию](/Ethereum_2.0/create_validator_key_ru(Linux).md).

Заполните переменные в [SDL файле](/Ethereum_2.0/deploy.yml):

|Переменная|Описание|
| :-------: | :-------: |
|`DEPOSIT_JSON_BASE64`| Зашифрованный **deposit_data_xxxxxxx.json** с помощью base64 ([Инструкция по генерации](/Ethereum_2.0/create_validator_key_ru(Linux).md#%D1%88%D0%B8%D1%84%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-json-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2))|
|`DEPOSIT_FILE_NAME`| Полное имя файла deposit_data с расширением json, например: </br>`- "DEPOSIT_FILE_NAME=deposit_data-1679338505.json"`|
|`KEYSTORE_JSON_BASE64`| Зашифрованный **keystore_xxxxx.json** с помощью base64 ([Инструкция по генерации](/Ethereum_2.0/create_validator_key_ru(Linux).md#%D1%88%D0%B8%D1%84%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-json-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2))|
|`KEYSTORE_FILE_NAME`|Полное имя файла keystore с расширением json, например: </br>`- "KEYSTORE_FILE_NAME=keystore-m_12381_3600_0_0_0-1679338504.json"`|
|`ACCOUNT_ETH_PASS`|Пароль от ключей валидатора из [п.8 инструкции](/Ethereum_2.0/create_validator_key_ru(Linux).md)|      
|`RECEPIENT`|Получатель вознаграждений.|
|`SNAP_URL`|Адрес синхронизации state sync, для goerli сети будет иметь вид:</br> `- "SNAP_URL=https://prater-checkpoint-sync.stakely.io"`.|
 
### Ресурсы

Выбирайте ресурсы под свои задачи, так как например, использование диска при включенном `state sync` в сети `goerli` будет около **300GB**, тогда как полный архив блокчейна основной сети Ethereum потребует до **1,5TB** жесткого диска. Используйте `state sync` если вашему приложению неважны исторические данные сети. Помогает съекономить место на жестком диске.

```
      resources:
        cpu:
          units: 4.0
        memory:
          size: 9Gi
        storage:
          - size: 300Gi
```
