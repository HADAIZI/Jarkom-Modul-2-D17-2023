apt-get update
apt-get install nginx -y

service nginx start

echo '
# Default menggunakan Round Robin
upstream myweb  {
 	server 10.30.3.2:8001; # IP Prabukusuma
	server 10.30.3.3:8002; # IP Abimanyu
	server 10.30.3.4:8003; # IP Wisanggeni
}

server {
 	listen 80;
 	server_name arjuna.d17.com;

 	location / {
 	proxy_pass http://myweb;
 	}
}
' > /etc/nginx/sites-available/lb-jarkom

ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
