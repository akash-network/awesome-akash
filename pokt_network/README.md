# POKT Network node on Akash Network

Fill in the variables in the [SDL file](/pokt_network/deploy.yml):

|Variable|Description|
| :-------: | :-------: |
|`SSH_PASS`| Password to connect to the node via SSH (root user).|
|`VERSION`| Set actual version POKT Network.|
|`CHAIN`| Set POKT chain, **mainnet** or **testnet**.|
|`KEYFILE_BASE64`| Encrypted contents of the keyfile.json file using BASE64.|
|`KEY_PASS`| Password to keyfile.json.|
|`ADDRESS`| Account address.|
|`CHAINS_LINK`| Link to download chains.json file, or use CHAINS_BASE64 to transfer the contents of the chains.json file in encrypted form.|
|`LINK_SNAPSHOT`| Link to network [snapshot](https://docs.pokt.network/node/setup/#download-snapshot) .|
|`SEEDS`| Set seeds [address](https://docs.pokt.network/node/seeds/) .|

### Resources

- If you want use **ephimeral** storage  (*WARNING! Data will be lost when the container is restarted!*):
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4.0
        memory:
          size: 16Gi
        storage:
          size: 500Gi
```

- If you want use **persistens** storage:

1. Uncomment in `app` section:
```yaml
    params:
      storage:
        data:
          mount: /root/
```
2. Uncomment in `profiles` section:
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4.0
        memory:
          size: 16Gi
        storage:
          size: 10Gi 
          - name: data
            size: 500Gi
            attributes:
              persistent: true
              class: beta3
```

# Развертка ноды POKT Network на Akash Network

Заполните переменные в [SDL файле](/pokt_network/deploy.yml):

|Переменная|Описание|
| :-------: | :-------: |
|`SSH_PASS`|  Пароль, для подключения к контейнеру по протоколу SSH (пользователь root).|
|`VERSION`| Установите актуальную версию POKT Network.|
|`CHAIN`| Установите нужную цепочку, **mainnet** или **testnet**.|
|`KEYFILE_BASE64`| Зашифрованное содержимое файла keyfile.json с помощью BASE64.|
|`KEY_PASS`| Пароль от keyfile.json.|
|`ADDRESS`| Адрес аккаунта.|
|`CHAINS_LINK`| Ссылка для скачивания файла chains.json file, или используйте CHAINS_BASE64 для доставки содержимого chains.json внутрь контейнера в зашифрованном ввиде с помощью BASE64 .|
|`LINK_SNAPSHOT`| Ссылка на скачивание [снепшота](https://docs.pokt.network/node/setup/#download-snapshot) сети.|
|`SEEDS`| Установите перечени SEED нод, [доступно на сайте](https://docs.pokt.network/node/seeds/).|

### Ресурсы

- Если вы хотите использовать **эфимерное** хранилище  (*ПРЕДУПРЕЖДЕНИЕ! При перезагрузке контейнера данные будут сброщшены!*):
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4.0
        memory:
          size: 16Gi
        storage:
          size: 500Gi
```

- Если вы хотите использовать **постоянное** хранилище:

1. Раскомментируйте в секции `app`:
```yaml
    params:
      storage:
        data:
          mount: /root/
```
2. Раскомментируйте в секции `profiles`:
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4.0
        memory:
          size: 16Gi
        storage:
          size: 10Gi 
          - name: data
            size: 500Gi
            attributes:
              persistent: true
              class: beta3
```
