# 1. Get sifchain-ui source code
##
FROM alpine/git as source
ARG REPO=https://github.com/Sifchain/sifchain-ui.git
ARG BRANCH=master
ARG COMMIT
RUN cd /root; set -x; git clone -c advice.detachedHead=false -b $BRANCH $REPO
WORKDIR /root/sifchain-ui
RUN git checkout ${COMMIT:-$BRANCH}
RUN sed -i -e 's/\(const defaultNetworkEnv = \)\(.*\)/\1NetworkEnv.MAINNET;/' ui/core/src/config/getEnv.tsx

# 2. Build sifchain-ui
##
FROM node:17-alpine as build
ARG BRANCH=master
ARG COMMIT
COPY --from=source /root/sifchain-ui /root/sifchain-ui
WORKDIR /root/sifchain-ui
COPY setenv .
RUN apk update && apk add git jq && sh ./setenv && cat .githubenv
RUN set -a && . .githubenv && cd ./ui && \
    yarn install --frozen-lockfile --silent

# Fixed in the master 168db086, but gonna keep commented just in case.
## WORKAROUND: fix RewardSection.tsx
#RUN set -a && . .githubenv && cd ./ui && \
#    yarn prettier -w --config .prettierrc -c 'app/src/views/RewardsPage/components/RewardSection.tsx'

RUN set -a && . .githubenv && cd ./ui && \
    yarn build --tag $BRANCH_NAME --no-setup

# 3. Copy build artifacts to nginx container
##
FROM nginx:stable-alpine
COPY --from=build /root/sifchain-ui/ui/app/dist/ /usr/share/nginx/html/
EXPOSE 80

# 4. (OPTIONAL) Enable TLS port
##
RUN apk update && apk add openssl
RUN openssl req -x509 -nodes -days 3650 -subj "/CN=" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
#RUN openssl req -x509 -nodes -days 3650 -subj "/CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 443

# Labels
ARG DATE
ARG REPO=https://github.com/Sifchain/sifchain-ui.git
ARG BRANCH=master
ARG COMMIT
LABEL org.opencontainers.image.title="sifchain-ui"
LABEL org.opencontainers.image.description="Sifchain is the omni-chain decentralized exchange (DEX), unlocking liquidity in various chains to free people from egregious fees and inefficient trades."
LABEL org.opencontainers.image.authors="andrey.arapov@nixaid.com"
LABEL org.opencontainers.image.created=$DATE
LABEL org.opencontainers.image.source=$REPO
LABEL org.opencontainers.image.version=${COMMIT:-$BRANCH}
# Ref. https://github.com/opencontainers/image-spec/blob/main/annotations.md
