FROM node:20

ARG VERSION

WORKDIR /var/app
RUN git config --global init.defaultBranch master; \
  npx tiged https://codeberg.org/nitropage/nitropage/packages/starter#nitropage@${VERSION} /var/app
COPY run.sh run.sh
RUN npm install --legacy-peer-deps && npm run build

CMD [ "bash", "/var/app/run.sh" ]
