<div align="center"> 

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/219872517-2adc32b1-5f64-4d48-9a81-1e2ef6b01a53.png" width=90% </p>

# Нода Sentinel dVPN в Akash Network

</div>

___

<div align="center">
  
| [Twitter Decloud Nodes Lab](https://twitter.com/NodesLab) | [Discord Decloud Nodes Lab](https://discord.gg/rPENzerwZ8) |
|:--:|:--:|

| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | [Sentinel](https://sentinel.co/) |
|:--:|:--:|:--:|
___

Наши новостные каналы и русскоязычная техническая поддержка:

| [Discord Akash Network](https://discord.akash.network/) | [Telegram Akash Network EN](https://t.me/AkashNW) | [Telegram Akash Network RU](https://t.me/akash_ru) | [Twitter Akash Network](https://twitter.com/akashnet_) 
|:--:|:--:|:--:|:--:|
  
  
| [Discord Sentinel](https://discord.gg/HPW52yQuQJ) | [Telegram Sentinel dVPN](https://t.me/SentinelNodeNetwork) | [Twitter Sentinel](https://twitter.com/Sentinel_co)
|:--:|:--:|:--:|

| [English guide](/Sentinel-dVPN-node/README.md) | 
|:--:|  
</div>

___


### О ноде и Sentinel dVPN

> Всеобщая декларация прав человека, статья 19 : "Каждый человек имеет право ... искать, получать и распространять информацию и идеи любыми средствами и независимо от государственных границ." 

*Сегодня, множество государств пытются скрыть от пользователей "неугодную" по их мнению информацию. К сожалению, от такой политики, люди лишаются важнейшей части прав и свобод. Право на поиск, потребление и распространение информации сегодня - это вопрос не только развлекательного контетнта, но и вопрос образования, свободы мысли и конечно же безопасности.*

*Sentinel dVPN предлагает пользователям развернуть dVPN сервера по всему миру, объеденившись в децентрализованную сеть. Владельцы dVPN нод получают вознаграждение в токенах dvpn за каждый гигабайт прошедший через их ноду. Пользователи клиентской части Sentinel dVPN, могут выбирать среди нод - к какой они могут подключится, которая их устроит в скрости передачи информации, географическому положению и конечно цене.
В этой инструкции рассматривается запуск серверной части - ноды Sentinel dVPN.*

___

## Подготовка


#### Внимание! Cloudmos теперь используется как Akash Console! Привычный интрефейс с новым названием!

> Для разверки ноды, в этой инструкции, я воспользуюсь [WEB интерфейсом Akash Console](https://console.akash.network/). О том, как с ним работать, [описано в этом документе](https://github.com/DecloudNodesLab/Guides/blob/main/Russian/Cloudmos.md).

1. Создайте в `Keplr` отдельный аккаунт для dVPN ноды.
2. Зашифруйте мнемоник фразу нового аккаунта с помощью `BASE64`, это можно сделать, как с помощью приложения [Notepad++](https://notepad-plus-plus.org/downloads/) (*Плагины-MIME Tools-Base64 Encode*), так и с помощью любого **безопасного** онлайн шифратора Base64.
3. Пополните счет созданного dVPN аккаунта не менее, чем на `1500dvpn` для оплаты газа. Приобрести dvpn вы можете на биржах, например `OSMOSIS` или `KUCOIN`.

## Развертка ноды
Откройте [WEB интерфейс](https://console.akash.network/) `Console`.

Убедитесь, что на вашем балансе есть **более 0.5 АКТ** и **присутсвует сертификат** (если нет, то обратитесь к [инструкции по использованию Console](https://github.com/DecloudNodesLab/Guides/blob/main/Russian/Cloudmos.md#%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B0%D0%BA%D0%BA%D0%B0%D1%83%D0%BD%D1%82%D0%B0-%D0%B8-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B0-%D0%BA-%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B5)). Далее, нажмите кнопку `DEPLOY`, выберите пустой темплейт `Empty` и скопируйте туда содержимое [deploy.yml](/Sentinel-dVPN-node/deploy.yml).
___

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221607947-cdc2b2e6-cc96-4709-9278-e15369bb62bf.gif" width=70% </p>
  
___
Нода `Sentinel dVPN` требует **выделенного IP адреса и статических внешних портов**, для этого необходимо внести небольшие изменения в манифест (deploy.yml),
а именно, замените `your_endpoint_name` в разделах `endpoints` и `expose` на уникальное имя (**только латинские символы нижнего регистра!**)

Также, заполните переменные своими данными:
* `MNEMONIC_BASE64` - Мнемоник фраза от ранее созданного аккаунта sentinel, защифрованная с помощью BASE64
* `MONIKER` - Имя Вашей ноды, сделайте его уникальным.
* `IPV4_ADDRESS` - пока оставьте пустым.
> Если Вы захотите сменить `LISTEN_PORT` или `REMOTE_PORT` - не забудьте также внести изменения в соответвующих пунктах раздела `EXPOSE`.
Также, для продвинутых пользоветелей, [создан перечень доступных переменных](/Sentinel-dVPN-node/VARIABLES_RU.md) с коротким описанием.
  
Обратите внимание на правильность заполнения переменных, они должны находится ВНУТРИ кавычек, например: <br/> `"MONIKER=dVPN on Akash Network v2RAY"`
    



<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221614307-09813671-ed36-4db3-86d8-5836245f05f1.gif" width=70% </p>

До начала развертывания, мы не можем знать какой **IPv4** адрес нам будет назначен, поэтому мы начнем развертку с пустым `IPV4_ADDRESS`. Мы заполним его, как только получим адрес **IPv4** от провайдера и обновим наш деплой. <br/> 
Пришло время запросить текущие предложения на рынке вычислительных мощностей. Нажимаем `CREATE DEPLOYMENT`, подтверждаем транзакцию (будет заморожено **0.5 АКТ**) и дожидаемся появления предложений от провайдеров.
  
<br/> 
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221620076-7829428a-5832-4ff9-ab91-215875651d5a.gif" width=70% </p>
  
<br/> 
  
Как Вы смогли заметить, всего было доступно **3 провайдера**, готовых предоставить вычислительные мощности **с функцией статического IP**. Я выбрал самого дешевого и продолжил разветывание.<br/> 
В логах мы можем увидеть назначенный нам **IPv4** адрес. Он также отображается на владке `LEASES` нашего развертывания.
Все что нам остается - это скопировать его, вставить в наш манифест (deploy.yml) на странице `UPDATE` и обновить развертывание. <br/> 
Вот как это выглядит:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/221625686-4efca4c2-a3a0-4ebf-9933-09637b16d575.gif" width=70% </p>

**Развертывание занимает около 2-х минут.** После чего начнется работа ноды dVPN.<br/> <br/> 
Пример корректных рабочих логов:<br/> 
![image](https://user-images.githubusercontent.com/23629420/221644766-0b182d4b-813e-41ef-ab31-22cd55059583.png)<br/> 
Также, если открыть Ваш адрес sentinel в [Explorer](https://www.mintscan.io/sentinel), Вы можете увидеть наличие транзакций обновления статуса Вашей dVPN ноды.<br/>
На этом установка завершена!<br/> <br/> 
Спасибо что воспользовались **Akash Network**!
