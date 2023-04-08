#!/bin/bash
get_opsy() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}


io_test() {
    (LANG=en_US dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' | sed 's/^[ \t]*//;s/[ \t]*$//'
}

if  [ -e '/usr/bin/wget' ]; then
    cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
    freq=$( awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    tram=$( free -m | awk '/Mem/ {print $2}' )
    swap=$( free -m | awk '/Swap/ {print $2}' )
    up=$( awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60;d=$1%60} {printf("%ddays, %d:%d:%d\n",a,b,c,d)}' /proc/uptime )
    load=$( w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//' )
    opsy=$( get_opsy )
    arch=$( uname -m )
    lbit=$( getconf LONG_BIT )
    host=$( hostname )
    kern=$( uname -r )
    ipv6=$( wget -qO- -t1 -T2 ipv6.icanhazip.com )

    clear
    next
    echo "CPU model            : $cname"
    echo "Number of cores      : $cores"
    echo "CPU frequency        : $freq MHz"
    echo "Total amount of ram  : $tram MB"
    echo "Total amount of swap : $swap MB"
    echo "System uptime        : $up"
    echo "Load average         : $load"
    echo "OS                   : $opsy"
    echo "Arch                 : $arch ($lbit Bit)"
    echo "Kernel               : $kern"
    next

else
    echo "Error: wget command not found. You must be install wget command at first."
    exit 1
fi

io1=$( io_test )
echo "I/O speed(1st run) : $io1"
io2=$( io_test )
echo "I/O speed(2nd run) : $io2"
io3=$( io_test )
echo "I/O speed(3rd run) : $io3"
ioraw1=$( echo $io1 | awk 'NR==1 {print $1}' )
[ "`echo $io1 | awk 'NR==1 {print $2}'`" == "GB/s" ] && ioraw1=$( awk 'BEGIN{print '$ioraw1' * 1024}' )
ioraw2=$( echo $io2 | awk 'NR==1 {print $1}' )
[ "`echo $io2 | awk 'NR==1 {print $2}'`" == "GB/s" ] && ioraw2=$( awk 'BEGIN{print '$ioraw2' * 1024}' )
ioraw3=$( echo $io3 | awk 'NR==1 {print $1}' )
[ "`echo $io3 | awk 'NR==1 {print $2}'`" == "GB/s" ] && ioraw3=$( awk 'BEGIN{print '$ioraw3' * 1024}' )
ioall=$( awk 'BEGIN{print '$ioraw1' + '$ioraw2' + '$ioraw3'}' )
ioavg=$( awk 'BEGIN{print '$ioall'/3}' )
echo "Average I/O speed  : $ioavg MB/s"
echo


speed_test() {
    speedtest=$(wget -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    ipaddress=$(ping -c1 -n `awk -F'/' '{print $3}' <<< $1` | awk -F'[()]' '{print $2;exit}')
    nodeName=$2
    if   [ "${#nodeName}" -lt "8" ]; then
        echo -e "\e[33m$2\e[0m\t\t\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -lt "13" ]; then
        echo -e "\e[33m$2\e[0m\t\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -lt "24" ]; then
        echo -e "\e[33m$2\e[0m\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -ge "24" ]; then
        echo -e "\e[33m$2\e[0m\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    fi
}

speed_test_v6() {
    speedtest=$(wget -6O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    ipaddress=$(ping6 -c1 -n `awk -F'/' '{print $3}' <<< $1` | awk -F'[()]' '{print $2;exit}')
    nodeName=$2
    if   [ "${#nodeName}" -lt "8" -a "${#ipaddress}" -eq "13" ]; then
        echo -e "\e[33m$2\e[0m\t\t\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -lt "13" -a "${#ipaddress}" -eq "13" ]; then
        echo -e "\e[33m$2\e[0m\t\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -lt "24" -a "${#ipaddress}" -eq "13" ]; then
        echo -e "\e[33m$2\e[0m\t\t\e[32m$ipaddress\e[0m\t\t\e[31m$speedtest\e[0m"
    elif [ "${#nodeName}" -lt "24" -a "${#ipaddress}" -gt "13" ]; then
        echo -e "\e[33m$2\e[0m\t\t\e[32m$ipaddress\e[0m\t\e[31m$speedtest\e[0m"
    fi
}

speed() {
    speed_test 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
    speed_test 'https://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Tokyo, JP'
    speed_test 'http://speedtest.tokyo2.linode.com/100MB-tokyo2.bin' 'Linode, Tokyo, JP'
    speed_test 'http://speedtest-blr1.digitalocean.com/100mb.test' 'DO, Bangalore, IN'
    speed_test 'http://speedtest.mumbai1.linode.com/100MB-mumbai1.bin' 'Linode, Mumbai, IN'
    speed_test 'http://speedtest.che01.softlayer.com/downloads/test100.zip' 'Softlayer, Chennai, IN'
    speed_test 'https://sgp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Singapore, SG'
    speed_test 'http://speedtest-sgp1.digitalocean.com/100mb.test' 'DO, Singapore, SG'
    speed_test 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
    speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
    speed_test 'http://mirror.sg.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Singapore, SG'
    speed_test 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HongKong, CN'
    speed_test 'http://mirror.hk.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, HongKong, CN'
    speed_test 'https://syd-au-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Sydney, AUS'
    speed_test 'http://speedtest.syd01.softlayer.com/downloads/test100.zip' 'Softlayer, Sydney, AUS'
    speed_test 'http://bck-speedtest-1.tele2.net/100MB.zip' 'Tele2, Gothenberg, SE'
    speed_test 'http://kst5-speedtest-1.tele2.net/100MB.zip' 'Tele2, Kista, SE'
    speed_test 'http://speedtest.mil01.softlayer.com/downloads/test100.zip' 'Softlayer, Milan, IT'
    speed_test 'http://lg-milano.prometeus.net/100MB.test' 'Prometeus, Milan, IT'
    speed_test 'http://bks-speedtest-1.tele2.net/100MB.zip' 'Tele2, Riga, LV'
    speed_test 'http://vln038-speedtest-1.tele2.net/100MB.zip' 'Tele2, Vilnius, LT'
    speed_test 'http://speedtest.as5577.net/1000mb.bin' 'Server.LU, Luxembourg, LU'
    speed_test 'http://fra36-speedtest-1.tele2.net/100MB.zip' 'Tele2, Frankfurt, DE'
    speed_test 'https://fra-de-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Frankfurt, DE'
    speed_test 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
    speed_test 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
    speed_test 'http://mirror.de.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Frankfurt, DE'
    speed_test 'http://speedtest-fra1.digitalocean.com/100mb.test' 'DO, Frankfurt, DE'
    speed_test 'https://par-fr-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Paris, FR'
    speed_test 'http://gra.proof.ovh.net/files/100Mb.dat' 'OVH, Gravelines, FR'
    speed_test 'http://sbg.proof.ovh.net/files/100Mb.dat' 'OVH, Strasbourg, FR'
    speed_test 'http://rbx.proof.ovh.net/files/100Mb.dat' 'OVH, Roubaix, FR'
    speed_test 'http://ping.online.net/100Mo.dat' 'Online.Net, Paris, FR'
    speed_test 'http://ams-speedtest-1.tele2.net/100MB.zip' 'Tele2, Amsterdam, NL'
    speed_test 'https://ams-nl-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Amsterdam, NL'
    speed_test 'http://speedtest-ams2.digitalocean.com/100mb.test' 'DO 2, Amsterdam, NL'
    speed_test 'http://speedtest-ams3.digitalocean.com/100mb.test' 'DO 3, Amsterdam, NL'
    speed_test 'http://mirror.nl.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Amsterdam, NL'
    speed_test 'http://mirror.i3d.net/100mb.bin' 'i3d, Amsterdam, NL'
    speed_test 'https://lon-gb-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, London, UK'
    speed_test 'http://speedtest-lon1.digitalocean.com/100mb.test' 'DO, London, UK'
    speed_test 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
    speed_test 'http://speedtest.lon02.softlayer.com/downloads/test100.zip' 'Softlayer, London, UK'
    speed_test 'http://speedtest.mex01.softlayer.com/downloads/test100.zip' 'Softlayer, Mexico, MX'
    speed_test 'http://speedtest.sao01.softlayer.com/downloads/test100.zip' 'Softlayer, Brazil, BR'
    speed_test 'http://speedtest-nyc1.digitalocean.com/100mb.test' 'DO 1, NYC, USA'
    speed_test 'http://speedtest-nyc2.digitalocean.com/100mb.test' 'DO 2, NYC, USA'
    speed_test 'http://speedtest-nyc3.digitalocean.com/100mb.test' 'DO 3, NYC, USA'
    speed_test 'https://nj-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, New Jersey, USA'
    speed_test 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, USA'
    speed_test 'https://il-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Illinois, USA'
    speed_test 'https://ga-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Atlanta, USA'
    speed_test 'http://speedtest.atlanta.linode.com/100MB-atlanta.bin' 'Linode, Atlanta, USA'
    speed_test 'https://fl-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Miami, USA'
    speed_test 'https://wa-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Washington, USA'
    speed_test 'http://mirror.wdc1.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Washington, USA'
    speed_test 'https://tx-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Dallas, USA'
    speed_test 'http://speedtest.dallas.linode.com/100MB-dallas.bin' 'Linode, Dallas, USA'
    speed_test 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, USA'
    speed_test 'http://mirror.dal10.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Dallas, USA'
    speed_test 'https://lax-ca-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Los Angeles, USA'
    speed_test 'http://speedtest-sfo2.digitalocean.com/100mb.test' 'DO, San Francisco, USA'
    speed_test 'http://speedtest-sfo1.digitalocean.com/100mb.test' 'DO, San Francisco, USA'
    speed_test 'http://speedtest.fremont.linode.com/100MB-fremont.bin' 'Linode, Fremont, USA'
    speed_test 'http://mirror.sfo12.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, San Francisco, USA'
    speed_test 'http://speedtest-tor1.digitalocean.com/100mb.test' 'DO, Toronto, CA'
    speed_test 'http://bhs.proof.ovh.net/files/100Mb.dat' 'OVH, Beauharnois, CA'
    speed_test 'http://speedtest2.eastlink.ca/superlarge.bin' 'EastLink, Canada, CA'
    speed_test 'http://speedtest.toronto1.linode.com/100MB-toronto1.bin' 'Linode, Toronto, CA'
    speed_test 'http://speedtest.mon01.softlayer.com/downloads/test100.zip' 'Softlayer, Montreal, CA'
}

speed_v6() {
    speed_test_v6 'http://speedtest.atlanta.linode.com/100MB-atlanta.bin' 'Linode, Atlanta, GA'
    speed_test_v6 'http://speedtest.dallas.linode.com/100MB-dallas.bin' 'Linode, Dallas, TX'
    speed_test_v6 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, NJ'
    speed_test_v6 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
    speed_test_v6 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
    speed_test_v6 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
    speed_test_v6 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
    speed_test_v6 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
}

echo -e "Node Name\t\t\tIPv4 address\t\tDownload Speed"
speed && next
if [[ "$ipv6" != "" ]]; then
    echo -e "Node Name\t\t\tIPv6 address\t\tDownload Speed"
    speed_v6 && next
fi
