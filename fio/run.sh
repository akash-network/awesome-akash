#!/usr/bin/env sh
if [[ $TEST == "custom" ]]; then
fio $COMMAND
else
echo "Starting to test with defaults / ArsTechnica recommended tests"
echo "https://arstechnica.com/gadgets/2020/02/how-fast-are-your-disks-find-out-the-open-source-way-with-fio/"
echo "---------------------------------------"
echo "Single 4KiB random write process"
echo "This is a single process doing random 4K writes. This is where the pain really, really lives; it\'s basically the worst possible thing you can ask a disk to do. Where this happens most frequently in real life: copying home directories and dotfiles, manipulating email stuff, some database operations, source code trees."
fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based --end_fsync=1
echo "---------------------------------------"
echo "16 parallel 64KiB random write processes"
echo "This is a pretty decent approximation of a significantly busy system. It\'s not doing any one particularly nasty thing—like running a database engine or copying tons of dotfiles from a user\'s home directory—but it is coping with a bunch of applications doing moderately demanding stuff all at once."
fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=64k --size=256m --numjobs=16 --iodepth=16 --runtime=60 --time_based --end_fsync=1
echo "---------------------------------------"
echo "Single 1MiB random write process"
echo "This is pretty close to the best-case scenario for a real-world system doing real-world things. No, it\'s not quite as fast as a single, truly contiguous write... but the 1MiB blocksize is large enough that it\'s quite close. Besides, if literally any other disk activity is requested simultaneously with a contiguous write, the "contiguous" write devolves to this level of performance pretty much instantly, so this is a much more realistic test of the upper end of storage performance on a typical system."
fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=1m --size=16g --numjobs=1 --iodepth=1 --runtime=60 --time_based --end_fsync=1
echo "---------------------------------------"
echo "All Tests Complete - sleeping for 15 minutes before restarting the test."
sleep 900
exit
fi
