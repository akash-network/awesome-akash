#cleanup wallet before start, cannot support wallet already exists
sudo rm -rf data/wallet
sudo docker build -t cryptoandcoffee/akash-monero-pool .
sudo docker run -itd --net host -v $(pwd)/data:/data cryptoandcoffee/akash-monero-pool

