iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.30.0.0/16
cat /etc/resolv.conf
nano /root/.bashrc
