## Bitcoin node on Akash Network

|Variable|Description|
| :-------: | :-------: |
|`"PASS_SSH="`| Password to connect to the node via SSH (root user).|
|`"LINK_BINARY="`|  The download address of the binary file.|
|`"SNAPSHOT="`|  Link to `lz4` node snapshot (disable if you want to sync the full node).|
|`"PRUNE="`|  Blockchain pruning, indicates the number of megabytes available for node storage (disable if you want to synchronize the full node).|

### Resources

- If you want use **ephimeral** storage  (*WARNING! Data will be lost when the container is restarted!*):
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 2.0
        memory:
          size: 2Gi
        storage:
          size: 600Gi
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
          units: 2.0
        memory:
          size: 2Gi
        storage:
          size: 10Gi 
          - name: data
            size: 600Gi
            attributes:
              persistent: true
              class: beta3
```

## Развертка Bitcoin ноды на Akash Network

|Переменная|Описание|
| :-------: | :-------: |
|`"PASS_SSH="`| Пароль, для подключения к контейнеру по протоколу SSH (пользователь root).|
|`"LINK_BINARY="`|  Ссылка на скачивание архива бинарного файла.|
|`"SNAPSHOT="`|  Сслыка на `lz4` снепшот ноды (отключите, если хотите загрузить полную историю блокчейна).|
|`"PRUNE="`|  Обрезка блокчейна, указывается максимальный объем пространства в мегабайтах который будет занимать нода (отключите если хотите иметь полный архив блокчейна).|

### Resources

- Если вы хотите использовать **эфимерное** хранилище  (*ПРЕДУПРЕЖДЕНИЕ! При перезагрузке контейнера данные будут сброщшены!*):
```yaml
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 2.0
        memory:
          size: 2Gi
        storage:
          size: 600Gi
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
          units: 2.0
        memory:
          size: 2Gi
        storage:
          size: 10Gi 
          - name: data
            size: 600Gi
            attributes:
              persistent: true
              class: beta3
```

