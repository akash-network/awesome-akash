FROM node:lts-alpine

WORKDIR /app

RUN apk add --no-cache git

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

#FROM node:lts-alpine as production

#WORKDIR /app

EXPOSE 3000

ENV NODE_ENV=production \
  BASE_URL=http://localhost:3000 \
  OPENAI_API_KEY="" \
  OPENAI_API_ENDPOINT="https://api.openai.com" \
  DATABASE_URL="" \
  NEXTAUTH_URL="" \
  NEXTAUTH_SECRET="" \
  EMAIL_HOST="" \
  EMAIL_PORT="" \
  EMAIL_USERNAME="" \
  EMAIL_PASSWORD="" \
  EMAIL_FORM=""

#CMD ["yarn", "start"]
