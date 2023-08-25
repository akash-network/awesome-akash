# Pocket Network <!-- omit in toc -->

Pocket Network (POKT) tackles the RPC Trilemma by enabling an open protocol that empowers developers with Reliable, Performant, and Cost-Effective RPC access to the open internet.

- [Resources](#resources)
- [Развертка ноды POKT Network на Akash Network](#развертка-ноды-pokt-network-на-akash-network)
  - [Ресурсы](#ресурсы)

<!-- TODO(@Olshansk, @kdas): Move over the notes related to testing & TLS from https://www.notion.so/pocketnetwork/Akash-Pocket-Network-9e63cc6c1275448f914c14ed31886d9e?pvs=4 -->

Fill in the variables in the [SDL file](/pokt_network/deploy.yml):

|     Variable     |                                                         Description                                                         |
| :--------------: | :-------------------------------------------------------------------------------------------------------------------------: |
|    `SSH_PASS`    |                                    Password to connect to the node via SSH (root user).                                     |
|    `VERSION`     |                                              Set actual version POKT Network.                                               |
|     `CHAIN`      |                                         Set POKT chain, **mainnet** or **testnet**.                                         |
| `KEYFILE_BASE64` |                                  Encrypted contents of the keyfile.json file using BASE64.                                  |
|    `KEY_PASS`    |                                                  Password to keyfile.json.                                                  |
|    `ADDRESS`     |                                                      Account address.                                                       |
|  `CHAINS_LINK`   | Link to download chains.json file, or use CHAINS_BASE64 to transfer the contents of the chains.json file in encrypted form. |
|     `SEEDS`      |                                Set seeds [address](https://docs.pokt.network/node/seeds/) .                                 |

## Resources

- If you want use **ephimeral** storage (_WARNING! Data will be lost when the container is restarted!_):

```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4.0
        memory:
          size: 24Gi
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

## Развертка ноды POKT Network на Akash Network

Заполните переменные в [SDL файле](/pokt_network/deploy.yml):

|    Переменная    |                                                                                  Описание                                                                                   |
| :--------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|    `SSH_PASS`    |                                                 Пароль, для подключения к контейнеру по протоколу SSH (пользователь root).                                                  |
|    `VERSION`     |                                                                 Установите актуальную версию POKT Network.                                                                  |
|     `CHAIN`      |                                                           Установите нужную цепочку, **mainnet** или **testnet**.                                                           |
| `KEYFILE_BASE64` |                                                        Зашифрованное содержимое файла keyfile.json с помощью BASE64.                                                        |
|    `KEY_PASS`    |                                                                           Пароль от keyfile.json.                                                                           |
|    `ADDRESS`     |                                                                               Адрес аккаунта.                                                                               |
|  `CHAINS_LINK`   | Ссылка для скачивания файла chains.json file, или используйте CHAINS_BASE64 для доставки содержимого chains.json внутрь контейнера в зашифрованном ввиде с помощью BASE64 . |
|     `SEEDS`      |                                          Установите перечени SEED нод, [доступно на сайте](https://docs.pokt.network/node/seeds/).                                          |

### Ресурсы

- Если вы хотите использовать **эфимерное** хранилище (_ПРЕДУПРЕЖДЕНИЕ! При перезагрузке контейнера данные будут сброщшены!_):

```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 8
        memory:
          size: 24Gi
        storage:
          - size: 300Gi
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
          size: 24Gi
        storage:
          size: 10Gi
          - name: data
            size: 500Gi
            attributes:
              persistent: true
              class: beta3
```
