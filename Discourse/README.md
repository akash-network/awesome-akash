# akash-discourse
This will deploy a Discourse forum on Akash

***Note: this is still a Work in Progress***

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

## Install Ruby and Ruby Version Manager

```
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
```
```
command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
```
```
curl -sSL https://get.rvm.io | bash -s stable
```
```
echo 'gem: --no-document' >> ~/.gemrc
```
```
source /usr/local/rvm/scripts/rvm
```
```
rvm --version
```

## Upgrade Ruby, set default version & install

```
rvm install 2.6.2
```
```
rvm --default use 2.6.2
```
```
gem install bundler mailcatcher rake
```

## Start Postgresql server and setup database

```
service postgresql start
```

### login to postgres cli

```
sudo -u postgres -i
```
### create database, create user and make them a superuser

```
psql template1
```
```
CREATE USER youruser WITH PASSWORD 'yourpassword';
```
```
CREATE DATABASE discourse_development;
```
```
GRANT ALL PRIVILEGES ON DATABASE discourse_development to youruser;
```
```
ALTER USER youruser WITH SUPERUSER;
```

### confirm and exit

```
\du
```
```
q
```
```
exit
```
```
exit
```

## Install NVM & Node

### NVM

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
```

### Setup path

```
export NVM_DIR="$HOME/.nvm"
```

### Check path works

```
nvm --version
```
### Install Node & set default version

```
nvm install node
```
```
nvm alias default node
```
```
npm install -g svgo
```

# Install Discourse

```
git clone https://github.com/discourse/discourse.git ~/discourse
```
```
cd ~/discourse
```
```
apt-get install libpq-dev
```
```
bundle install
```
If you get an error just run bundle install again

### Check postgres server status

```
service postgresql status
```
### If it is not running, start it

```
service postgresql start
```

### Run Redis Server in the background

```
redis-server --daemonize yes
```

### Create the database and run migrations

```
bundle exec rake db:create
```
```
bundle exec rake db:migrate
```
```
RAILS_ENV=test bundle exec rake db:create db:migrate
```

###Create an admin account with:

```
bundle exec rake admin:create
```
#### Follow the steps for setting up admin email and password

## FINALLY

### Launch Discourse on Akash

```
bundle exec rails s -b 0.0.0.0 
```
### Discourse on Akash

Find your host and ports in your Akash lease status

```
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
```

open browser on http://host:3000 and you should see Discourse  ***note: currently this seems to run, but having problems with ports. Work in Progress
