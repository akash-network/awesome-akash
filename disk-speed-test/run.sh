echo "Welcome to the Akash disk speed test!"
echo "The first benchmark will test a small file..."
dd if=/dev/zero of=/root/testfile bs=512 count=1000 oflag=direct
echo "The second benchmark will test a large file..."
dd if=/dev/zero of=/root/testfile bs=1G count=1 oflag=direct
