apt-get update
apt-get install nginx -y
apt-get install php php-fpm -y
 
mkdir /var/www/jarkom
 
apt-get install wget -y
apt-get install unzip -y
 
# Serve arjuna.d17.com

wget -O /var/www/jarkom/arjuna.yyy.com.zip "https://drive.google.com/u/0/uc?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX&export=download"
 
unzip -d /var/www/jarkom /var/www/jarkom/arjuna.yyy.com.zip && rm /var/www/jarkom/arjuna.yyy.com.zip
 
mv /var/www/jarkom/arjuna.yyy.com/index.php /var/www/jarkom
 
rm -r /var/www/jarkom/arjuna.yyy.com
 
echo '
server {
 
    	listen 8002;
 
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

# domain abimanyu.d17.com
 
apt-get install apache2
apt-get install libapache2-mod-php7.0
service apache2 start
 
wget -O /var/www/abimanyu.d17/abimanyu.yyy.com.zip "https://drive.google.com/u/0/uc?id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc&export=download"

unzip -d /var/www/abimanyu.d17 /var/www/abimanyu.d17/abimanyu.yyy.com.zip && rm /var/www/abimanyu.d17/abimanyu.yyy.com.zip

mv /var/www/abimanyu.d17/abimanyu.yyy.com/index.php /var/www/abimanyu.d17/

mv /var/www/abimanyu.d17/abimanyu.yyy.com/home.html /var/www/abimanyu.d17/

mv /var/www/abimanyu.d17/abimanyu.yyy.com/abimanyu.webp /var/www/abimanyu.d17/

rm -r /var/www/abimanyu.d17/abimanyu.yyy.com/

echo '
<VirtualHost *:80>
    	ServerAdmin webmaster@localhost
    	DocumentRoot /var/www/abimanyu.d17
	ServerName abimanyu.d17.com
	ServerAlias www.abimanyu.d17.com
 	ServerAlias 10.30.3.3

	<Directory /var/www/abimanyu.d17>
		Options +FollowSymLinks -Multiviews
		AllowOverride All
	</Directory>

    	ErrorLog ${APACHE_LOG_DIR}/error.log
    	CustomLog ${APACHE_LOG_DIR}/access.log combined
 
   </VirtualHost>
' > /etc/apache2/sites-available/abimanyu.d17.com.conf

mkdir /var/www/abimanyu.d17
a2ensite abimanyu.d17.com

a2enmod rewrite

echo '
RewriteEngine On

RewriteCond %{REQUEST_FILENAME} !-d

RewriteRule ^([^\.]+)$ index.php/$1 [NC,L]
' > /var/www/abimanyu.d17/.htaccess

# Domain parikesit.abimanyu.d17.com

wget -O /var/www/parikesit.abimanyu.d17.zip "https://drive.google.com/u/0/uc?id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS&export=download"

unzip -d /var/www /var/www/parikesit.abimanyu.d17.zip && rm /var/www/parikesit.abimanyu.d17.zip

mv /var/www/parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.d17

mkdir /var/www/parikesit.abimanyu.d17/secret

echo '
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Ini Secret</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>
    <script src='main.js'></script>
</head>
<body>
    <p>ssshhhh...ini secret bang</p>
</body>
</html>
' > /var/www/parikesit.abimanyu.d17/secret/secret.html

echo '
<VirtualHost *:80>
    	ServerAdmin webmaster@localhost
    	DocumentRoot /var/www/parikesit.abimanyu.d17
	ServerName parikesit.abimanyu.d17.com
	ServerAlias www.parikesit.abimanyu.d17.com
 	
	<Directory /var/www/parikesit.abimanyu.d17/public/images>
		AllowOverride All
	</Directory>

	<Directory /var/www/parikesit.abimanyu.d17/secret>
                Options -Indexes
        </Directory>
	
	Alias "/js" "/var/www/parikesit.abimanyu.d17/public/js"

    	ErrorLog ${APACHE_LOG_DIR}/error.log
    	CustomLog ${APACHE_LOG_DIR}/access.log combined
	ErrorDocument 404 /error/404.html
    	ErrorDocument 403 /error/403.html
 
</VirtualHost>
' > /etc/apache2/sites-available/parikesit.abimanyu.d17.com.conf

echo '
RewriteEngine On

RewriteCond %{REQUEST_URI} /public/images/
RewriteCond %{REQUEST_URI} (abimanyu.*\.(jpg|png)) [NC]
RewriteRule (.*) /public/images/abimanyu.png [L,R=302]
' > /var/www/parikesit.abimanyu.d17/public/images/.htaccess

a2ensite parikesit.abimanyu.d17.com

# domain rjp.baratayuda.abimanyu.d17.com

wget -O /var/www/rjp.baratayuda.abimanyu.d17.zip "https://drive.google.com/u/0/uc?id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6&export=download"

unzip -d /var/www /var/www/rjp.baratayuda.abimanyu.d17.zip && rm /var/www/rjp.baratayuda.abimanyu.d17.zip

mv /var/www/rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.d17

echo '
<VirtualHost *:14000>
    	ServerAdmin webmaster@localhost
    	DocumentRoot /var/www/rjp.baratayuda.abimanyu.d17
	ServerName rjp.baratayuda.abimanyu.d17.com
	ServerAlias www.rjp.baratayuda.abimanyu.d17.com
 	
	<Directory /var/www/rjp.baratayuda.abimanyu.d17>
                Options +Indexes
                AllowOverride All
                Require all granted
        </Directory>

    	ErrorLog ${APACHE_LOG_DIR}/error.log
    	CustomLog ${APACHE_LOG_DIR}/access.log combined
	
 
</VirtualHost>
<VirtualHost *:14400>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.d17
        ServerName rjp.baratayuda.abimanyu.d17.com
        ServerAlias www.rjp.baratayuda.abimanyu.d17.com
        
	<Directory /var/www/rjp.baratayuda.abimanyu.d17>
    		Options +Indexes
    		AllowOverride All
    		Require all granted
	</Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
                      
 
</VirtualHost>
' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.d17.com.conf

echo '
Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
' > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.d17.com

echo '
Wayang:$apr1$hEKgPW6z$ez8I8SzzzSlXVFPUgg67G1
' > /var/www/rjp.baratayuda.abimanyu.d17/.htpasswd

echo '
AuthType Basic
AuthName "Authentication Required"
AuthUserFile /var/www/rjp.baratayuda.abimanyu.d17/.htpasswd
Require valid-user
' > /var/www/rjp.baratayuda.abimanyu.d17/.htaccess

service apache2 restart
service php7.0-fpm start
service php7.0-fpm restart


