# Nextcloud on Akash

### This will deploy Nextcloud on Akash

## Setup an "ssh" ubuntu image on [ Akash ](https://akash.network)  

## Optional : build custom Docker image (recommended)
Update Dockerfile with your needs.
```
# Note you can also use the prebuilt image at moonbys/moonubu:super1
$ docker build -t $your_dockerhub_user/ubuntu:1 .
```
Update deploy.yaml with your newly built docker image. ( or keep the prebuilt image)
## Buy me a coffee to keep the work going

| | |
--- | --- 
|akash:|`akash178d5wcg95z2jc5au608a9scshvwy3stwt3cgmq`|

### Buy Coffeeroaster a coffee to keep his work going and for https://github.com/coffeeroaster/akash-ubuntu

| | |
--- | --- 
|akash:|`akash1k07dv0wcjej4e4a5z9dg3c6yvvf9mcnz0sacp9`|
|monero:| `88z2xaJaRPVc5VXtE3CArxeAkqSQV8aA4EhswR8pqfY3CghQfaD7nYsLvmcnXuHj1TYDeJaGvyyyW9XyX6ka7BLzQ7ypmqJ`|

## Prepare your ssh session

On your workstation setup an ssh public/private key pair.
```
$ssh-keygen -t rsa
# (a password is optional. But in most cases you don't need one).
# Note that $HOME/.ssh/id_rsa.pub is now created
```

## Update deploy.yaml

Copy and paste the contents of `$HOME/.ssh/id_rsa.pub` and paste them into deploy.yaml (env -> pubkey). (deploy.yaml : line 8).

NOTE: Make sure that you do not use any `"` around the pubkey as this will cause problems.


### Update resources as needed. Set the amount of RAM / CPU / diskspace as needed.

## Deploy to Akash
* This assumes that you have installed akash in `$HOME/bin/akash`
* Read through https://docs.akash.network & https://github.com/tombeynon/akash-deploy. Thanks for the excellent guides!
* Broadly speaking you will need to:

###  Create an akash address 
``` 
make address
echo "export AKASH_ADDRESS=**address** " >> env.sh
``` 

** Fund `AKASH_ADDRESS` with at least 5 AKT
** create a deployment (you can use deploy.yaml) as an example
```
# Need to do this once
make create_certificate
```
```
make create_deployment
make list_bid
```
### accept a bid
```
make create_lease PROVIDER=**provider** DSEQ=**dseq**
```
### push the manifest
```
make send_manifest PROVIDER=**provider** DSEQ=**dseq**
```
### Read logs
```
make lease_logs PROVIDER=**provider** DSEQ=**dseq**
```

## Most importantly -- how do you interact with this?

```
make lease_status PROVIDER=**provider** DSEQ=**dseq**
```

Take a note of the URL and exposed random port. That is your ssh port to access.

```
ssh -p $RANDOMPORT root@URL
```

### Debug

If things are still not working you can set "debug=true" in the environment variable section of deploy.yaml. This will cause sshd to run with debug mode to get additional info. As a side effect as soon as you close your session it will kill the SSH session.


# Preparing your Ubuntu install

### Note: If your server says that it can be unminimize, enter that command

## Install the web and database servers

```
apt-get install apache2 mysql-server -y
```

## Start and enable the servers

```
service apache2 start
```
```
service mysql start
```

## Confirm servers are running

```
service apache2 status
```
```
service mysql status
```

## Install the remaining dependencies

```
apt-get install php zip libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip php-mysql php-bcmath php-gmp zip -y
```

## Secure your MySQL server and create your database

```
mysql_secure_installation
```

### Give the MySQL admin user a strong/unique password and answer the remaining questions with y

Log into the MySQL console with:

```
mysql -u root -p
```
Create the new database with the command:

```
CREATE DATABASE nextcloud;
```

Create a new user with the command:

```
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'PASSWORD';
```

Give the new user the necessary permissions with the command:

```
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
```

Flush the privileges and exit the console with the commands:

```
FLUSH PRIVILEGES;
```

```
exit
```

## Download and unzip Nextcloud

Download the latest version of Nextcloud https://download.nextcloud.com/server/releases

For this I used the following command:

```
wget https://download.nextcloud.com/server/releases/nextcloud-22.1.1.zip
```

## Unzip the downloaded file:

```
unzip nextcloud-22.1.1.zip
```

## Move the newly created nextcloud directory to the Apache document root:

```
mv nextcloud /var/www/html/
```

## Give the Nextcloud folder the necessary ownership:

```
chown -R www-data:www-data /var/www/html/nextcloud
```

## Configure Apache for Nextcloud

## Create an Apache .conf file for Nextcloud with the command:

```
nano /etc/apache2/sites-available/nextcloud.conf
```

## In that file, paste the following:

```
Alias /nextcloud "/var/www/html/nextcloud/"
<Directory /var/www/html/nextcloud/>
    Options +FollowSymlinks
    AllowOverride All
      <IfModule mod_dav.c>
        Dav off
      </IfModule>     
     SetEnv HOME /var/www/html/nextcloud
    SetEnv HTTP_HOME /var/www/html/nextcloud
</Directory>
```

Save and close the file.

## Enable the new site with the command:

```
a2ensite nextcloud
```

## Enable the necessary Apache modules:

```
a2enmod rewrite headers env dir mime
```

## Change the PHP memory limit:

```
sed -i '/^memory_limit =/s/=.*/= 512M/' /etc/php/7.4/apache2/php.ini
```

*** Note: If your version of PHP is a different release than 7.4, you'll need to alter the above command accordingly.

## Restart Apache:

```
service apache2 restart
```

## Complete the installation

Open a web browser and point it to http://SERVER/nextcloud (where SERVER is the IP address or domain of the hosting server in your data center or what you specify in your deploy.yaml file). In the browser, create an admin user and fill out the required information:

    Database user: nextcloud
    Database password: The password that you created for the nextcloud database user
    Database name: nextcloud
    
Click Finish Setup to complete the installation and you should be able to log in as admin to your Nextcloud instance.  

## Finally

Customize to your needs and you now have your own cloud powered by the unstoppable cloud
