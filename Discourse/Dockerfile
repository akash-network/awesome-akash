from ubuntu:latest

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt-get -yqq install software-properties-common vim curl expect debconf-utils git-core build-essential zlib1g-dev libssl-dev openssl libcurl4-openssl-dev libreadline6-dev libpcre3 libpcre3-dev imagemagick redis-server advancecomp jhead jpegoptim libjpeg-turbo-progs optipng pngcrush pngquant gnupg2 wget postgresql postgresql-contrib sudo nano -y
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-get -yqq update
RUN apt install curl ca-certificates gnupg
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN apt-get update -y
RUN apt-get upgrade -y
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /
RUN apt-get update -y && apt-get -y install openssh-server
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
ADD services.d/ssh /root/ssh.sh
RUN chmod 755 /root/ssh.sh
ENTRYPOINT ["/root/ssh.sh"]




#ENTRYPOINT /root/ssh.sh
#RUN apt-get update && \
#    apt-get upgrade && \
#    apt-get install -y nginx && \
#    echo "daemon off;" >> /etc/nginx/nginx.conf
#ENTRYPOINT ["/init"]
#CMD ["ssh"]
