#!/usr/bin/env bash

DB_FILE=/srv/db/dev.db
MEDIA_DIR=/srv/media

if [ -d "$MEDIA_DIR" ] && [ -L "$MEDIA_DIR" ]; then
	echo "Directory $MEDIA_DIR exists." 
else
	mkdir -p $MEDIA_DIR
	ln -s $MEDIA_DIR /var/app/public/media
fi

if [ ! -f "$DB_FILE" ]; then
	echo "$DB_FILE does not exist - initialize database"
	mkdir -p /srv/db/
	npx prisma migrate dev --name nitro
	if [[ $NP_DEMO -eq 1 ]]; then
	echo "Apply demo seed"
		npx nitropage seed-demo
	fi
else
	echo "$DB_FILE exist - update database"
	npx prisma migrate deploy
fi

npm start
