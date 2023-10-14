apt-get update
apt-get install bind9 -y

echo '
zone "arjuna.d17.com" {
	type master;
	file "/etc/bind/jarkom/arjuna.d17.com";
};

zone "abimanyu.d17.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.d17.com";
};

' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/arjuna.d17.com
cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.d17.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.d17.com. root.arjuna.d17.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.d17.com.
@       IN      A       10.30.3.5
www	IN	CNAME	arjuna.d17.com.
@       IN      AAAA    ::1
' > /etc/bind/jarkom/arjuna.d17.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d17.com. root.abimanyu.d17.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.d17.com.
@       IN      A       10.30.3.3
@       IN      AAAA    ::1
' > /etc/bind/jarkom/abimanyu.d17.com

service bind9 restart

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d17.com. root.abimanyu.d17.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.d17.com.
@       IN      A       10.30.3.3       ; IP Abimanyu
www     IN      CNAME   abimanyu.d17.com.
parikesit IN    A       10.30.3.3       ; IP Abimanyu
@       IN      AAAA    ::1
' > /etc/bind/jarkom/abimanyu.d17.com

service bind9 restart

echo '
zone "3.30.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.30.10.in-addr.arpa";
};
' >> /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/3.30.10.in-addr.arpa

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d17.com. root.abimanyu.d17.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
3.30.10.in-addr.arpa.   IN      NS      abimanyu.d17.com.
3                       IN      PTR     abimanyu.d17.com.  ; Byte ke-4 Abimanyu
' > /etc/bind/jarkom/3.30.10.in-addr.arpa

service bind9 restart

echo '
zone "arjuna.d17.com" {
        type master;
	notify yes;
	also-notify { 10.30.2.3; }; // IP werkudara slave
	allow-transfer { 10.30.2.3; }; // IP werkudara slave
        file "/etc/bind/jarkom/arjuna.d17.com";
};

zone "abimanyu.d17.com" {
        type master;
	notify yes;
        also-notify { 10.30.2.3; }; // IP werkudara slave
        allow-transfer { 10.30.2.3; }; // IP werkudara slave
        file "/etc/bind/jarkom/abimanyu.d17.com";
};

zone "3.30.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.30.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

service bind9 restart

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d17.com. root.abimanyu.d17.com. (
                    2022100601          ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      abimanyu.d17.com.
@       IN      A       10.30.3.3       ; IP Abimanyu
www     IN      CNAME   abimanyu.d17.com.
parikesit IN    A       10.30.3.3       ; IP Abimanyu
www.parikesit	IN	CNAME	parikesit
ns1     IN      A       10.30.2.3       ; IP Werkudara
baratayuda IN   NS      ns1
@       IN      AAAA    ::1
' > /etc/bind/jarkom/abimanyu.d17.com

echo '
options {
    	directory "/var/cache/bind";

    	allow-query{any;};
    	auth-nxdomain no;	# conform to RFC1035
    	listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

service bind9 restart
