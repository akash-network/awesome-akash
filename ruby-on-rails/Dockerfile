FROM ruby:3.5-rc-alpine3.22
WORKDIR /usr/src/app
COPY . .
RUN gem install webrick
EXPOSE 8000
CMD ["ruby", "server.rb"]
