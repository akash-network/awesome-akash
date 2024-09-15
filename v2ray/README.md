# Deploy V2RAY vpn server on Akash Network
# Развертка сервера V2RAY в Akash Network
___
Product documentation. | Документация по продукту. 

| [Site V2RAY](https://www.v2fly.org/en_US) | [GitHub V2RAY](https://github.com/v2fly) | 

[Инструкция на русском языке.](./README.md#%D0%B8%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F-%D0%BD%D0%B0-%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%BE%D0%BC-%D1%8F%D0%B7%D1%8B%D0%BA%D0%B5)

## Step 1 (Create and share your config.json)

You can use default `config.json`, included in container. Set the `ID`, in the SDL, use ( [generator UUID](https://www.uuidgenerator.net/) ) , or or leave it unchanged.

Or create your own `config.json` by going to the[ documentation](https://www.v2fly.org/en_US/guide/start.html). Place your `config.json` file on any platform where direct download will be available (github, google drive, etc.).

## Step 2 (Deploy on Akash Network)

Deploy [deploy.yml](./deploy.yml) file on Akash Network.
![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/9a72129d-080a-4cec-8fb9-2e257e0d3bcb)

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/28c10d71-6cfd-4977-86e4-65278fda11ea)

## Step 3 (Usage)

You can use the **v2ray** as a `socks` proxy for your browser or application. And in the role of a VPN connection. 

For the browser - set the settings - `socks`, your provider's address and forwarded port from the **LEASES** tab.

<img src=https://github.com/DecloudNodesLab/Projects/assets/23629420/862dca25-b57c-424f-8a3a-b394aabc558e width=50%>

For example, for Android, there is an [application](https://play.google.com/store/apps/details?id=com.v2ray.ang) **v2ray NG** .
In **v2ray NG** - create a new profile, where specify the provider's address, the `vmess` forwarded port and the `UUID` specified in `config.toml`.
Profile setup example:

<img src=https://github.com/DecloudNodesLab/Projects/assets/23629420/047ef1a7-f219-4b97-9315-b68d9f79e867 width=20%>

More client's application in [v2ray github](https://github.com/v2fly/v2ray-core/releases) and use [v2ray docs](https://www.v2fly.org/en_US/guide/start.html#client) .

**Do you have any questions? Answer on our [Discord](https://discord.gg/rPENzerwZ8)!**

### Инструкция на русском языке.

## Шаг 1 (Создайте и разместите свой config.json)

Вы можете использовать `config.json` по-умолчанию включенный в контейнер, заменив `ID` в SDL ( [сгенерировав уникальный](https://www.uuidgenerator.net/) ) , или оставить значение переменной `ID` как есть.
Или создайте свой собственный `config.json`, перейдя в [документацию](https://www.v2fly.org/en_US/guide/start.html). Разместите файл `config.json` на любой платформе, где будет доступна прямая загрузка (github, Google Drive и т.д.).

## Шаг 2 (развертывание в сети Akash)

Разверните файл [deploy.yml](./deploy.yml) в Akash Network . При необходимости замените значение переменной `CONFIG_LINK` своей ссылкой . Выберите провайдера и дождитесь завершения развертывания.
![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/f32076a4-fc11-4bb1-96a7-8ee812657f10)

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/ee285e15-9127-41da-8ea3-e61c00153409)

## Шаг 3 (Использование)

Вы можете использовать **v2ray** в качестве прокси-сервера типа `socks` для вашего браузера или приложения. Так и в роли VPN-соединения.
Для браузера - установите настройки - `socks`, адрес вашего провайдера и переадресованный порт из вкладки **LEASES**.

<img src=https://github.com/DecloudNodesLab/Projects/assets/23629420/862dca25-b57c-424f-8a3a-b394aabc558e width=50%>

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/26dba7bd-b87c-487c-86d8-072ec1ec72c7)

В Android, выступает [приложение](https://play.google.com/store/apps/details?id=com.v2ray.ang) **v2ray NG**.
Для приложения **v2ray NG** - создайте новый профиль, где укажите адрес провайдера, переадресованный порт `vmess` и `UUID` указанный в `config.toml`.
Пример настройки профиля:

<img src=https://github.com/DecloudNodesLab/Projects/assets/23629420/047ef1a7-f219-4b97-9315-b68d9f79e867 width=20%>

Больше клиентских приложений можно найти в [v2ray github](https://github.com/v2fly/v2ray-core/releases) и использовать [v2ray docs](https://www.v2fly.org/en_US/guide/start.html#client) .

**Остались вопросы? Ответим в нашем [Discord](https://discord.gg/rPENzerwZ8)!**
