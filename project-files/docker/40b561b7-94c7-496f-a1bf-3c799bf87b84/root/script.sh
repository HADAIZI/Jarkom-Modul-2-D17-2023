apt-get update
apt-get install nginx -y
apt-get install php php-fpm -y

mkdir /var/www/jarkom

apt-get install wget -y
apt-get install unzip -y

wget -O /var/www/jarkom/arjuna.yyy.com.zip "https://drive.google.com/u/0/uc?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX&export=download"

unzip -d /var/www/jarkom /var/www/jarkom/arjuna.yyy.com.zip && rm /var/www/jarkom/arjuna.yyy.com.zip 

mv /var/www/jarkom/arjuna.yyy.com/index.php /var/www/jarkom

rm -r /var/www/jarkom/arjuna.yyy.com

echo '
server {

        listen 8001;

        root /var/www/jarkom;

        index index.php index.html index.htm;
        server_name arjuna.d17.com;

        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                        deny all;
        }

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
}
' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled
 
rm -rf /etc/nginx/sites-enabled/default
 
service nginx restart
service php7.0-fpm start
service php7.0-fpm restart
 

