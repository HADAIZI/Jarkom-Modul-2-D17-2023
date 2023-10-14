apt-get update
apt-get install bind9 -y

echo '
zone "arjuna.d17.com" {
    type slave;
    masters { 10.30.2.2; }; 
    file "/var/lib/bind/arjuna.d17.com";
};

zone "abimanyu.d17.com" {
    type slave;
    masters { 10.30.2.2; }; 
    file "/var/lib/bind/abimanyu.d17.com";
};
' > /etc/bind/named.conf.local

service bind9 restart

echo '
options {
    	directory "/var/cache/bind";

    	allow-query{any;};
    	auth-nxdomain no;	# conform to RFC1035
    	listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

echo '
zone "arjuna.d17.com" {
	type slave;
	masters { 10.30.2.2; };
	file "/var/lib/bind/arjuna.d17.com";
};

zone "abimanyu.d17.com" {
	type slave;
	masters { 10.30.2.2; };
	file "/var/lib/bind/abimanyu.d17.com";
};

zone "baratayuda.abimanyu.d17.com" {
	type master;
	file "/etc/bind/baratayuda/baratayuda.abimanyu.d17.com";
};
' > /etc/bind/named.conf.local

mkdir /etc/bind/baratayuda

cp /etc/bind/db.local /etc/bind/baratayuda/baratayuda.abimanyu.d17.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.d17.com. root.baratayuda.abimanyu.d17.com. (
                        2022100601      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.d17.com.
@       IN      A       10.30.3.3
rjp     IN      A       10.30.3.3
www     IN      CNAME   baratayuda.abimanyu.d17.com.
www.rjp IN      CNAME   rjp
' > /etc/bind/baratayuda/baratayuda.abimanyu.d17.com

service bind9 restart
