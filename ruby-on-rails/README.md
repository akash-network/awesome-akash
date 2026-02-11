# Ruby on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ruby-on-rails)


[Ruby](https://rubyonrails.org/) is a dynamic, reflective, object-oriented, general-purpose, open-source programming language.

This template is a demonstration of the Ruby web framework on Akash. Check out [Ruby on Docker Hub](https://hub.docker.com/_/ruby) to learn how to Dockerize your project.

## About this template

The SDL configuration from this repository uses the `nomorelies/rubyonakash:0.4` image, which is based on the official Ruby image `ruby:3.5-rc-alpine3.22`. Ruby is used to run the `server.rb` script, which uses the `webrick` library to serve a static site on port 8000.
