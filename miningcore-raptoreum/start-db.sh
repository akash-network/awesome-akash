#!/bin/bash
echo "Startup"
cp postgresql.conf /etc/postgresql/12/main/postgresql.conf
cp pg_hba.conf /etc/postgresql/12/main/pg_hba.conf
service postgresql start
sudo -u postgres psql -c "CREATE ROLE miningcore WITH LOGIN ENCRYPTED PASSWORD '$POSTGRES_PASSWORD'"
sudo -u postgres psql -c "CREATE DATABASE miningcore OWNER miningcore"
wget https://raw.githubusercontent.com/oliverw/miningcore/master/src/Miningcore/Persistence/Postgres/Scripts/createdb.sql
sudo -u postgres psql -d miningcore -f createdb.sql
tail -f /dev/null
