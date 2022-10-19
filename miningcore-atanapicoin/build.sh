#Get depends


#apt-get update ; apt-get install -y wget ; wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
#dpkg -i packages-microsoft-prod.deb
#apt-get update -y ; apt-get install apt-transport-https -y
#apt-get -y install dotnet-sdk-2.2 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev autoconf automake pkg-config
#apt-get -y install libunwind-dev libbsd-dev

# add dotnet repo
# install dev-dependencies

apt-get update ; apt-get -y install wget

wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb ; dpkg -i packages-microsoft-prod.deb ; rm packages-microsoft-prod.deb

apt-get update ; apt-get -y install dotnet-sdk-6.0 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev libzmq5-dev

git clone https://github.com/oliverw/miningcore ; cd miningcore/src/Miningcore ; cp /coins.json coins.json ; dotnet publish -c Release --framework net6.0 -o ../../build

#git clone https://github.com/cryptoandcoffee/miningcore ; cd miningcore/src/Miningcore ; dotnet publish -c Release --framework net6.0 -o ../../build


#(cd src/Miningcore && \
#BUILDIR=${1:-../../build} && \
#echo "Building into $BUILDIR" && \
#dotnet publish -c Release --framework net6.0 -o $BUILDIR)

#wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
#dpkg -i packages-microsoft-prod.deb
#apt-get update
#apt-get install -y apt-transport-https
#apt-get update
#apt-get -y install dotnet-sdk-6.0 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev libzmq5
#git clone https://github.com/coinfoundry/miningcore
#cd miningcore/src/Miningcore
#dotnet publish -c Release --framework net5.0  -o ../../build

#apt-get update ; apt-get install -y dotnet-sdk-2.2 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev autoconf automake pkg-config apt-transport-https
#wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

#Install miningcore
#git clone https://github.com/cryptoandcoffee/miningcore
#cd miningcore/src/Miningcore
#CMD dotnet /miningcore/build/Miningcore.dll -c /config.json
#dotnet publish -c Release --framework net6.0 -o $BUILDIR)
#dotnet publish -c Release --framework netcoreapp2.2  -o ../../build

#Install ZMQ
#The default package for libzmq5 is not working by default, replaced with build of latest ZMQ.
#wget https://github.com/zeromq/libzmq/archive/v4.3.4.tar.gz
#tar zxvf v4.3.4.tar.gz
#cd libzmq-4.3.4/
#./autogen.sh
#./configure --prefix=/usr
#make
#make install
