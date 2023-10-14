echo "nameserver 10.30.2.2 # IP Yudhistira" > /etc/resolv.conf

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install dnsutils -y
apt-get install lynx -y

echo "nameserver 10.30.2.2" > /etc/resolv.conf
echo "nameserver 10.30.2.3" >> /etc/resolv.conf
