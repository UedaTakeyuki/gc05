#pip
sudo apt-get install python-pip

# ipython
sudo pip install ipython

#nkf
sudo apt-get install nkf

# python libraries
pip install paho-mqtt

# NGINX, php5-fpm
sudo apt-get install nginx
sudo apt-get install php5-fpm
sudo sed -i 's|index index.html index.htm|index index.php index.html index.htm|g' /etc/nginx/sites-enabled/default
sudo sed -i 's|#location ~ \\\.php$ {|location ~ \\\.php$ {|' /etc/nginx/sites-enabled/default
sudo sed -i 's|#\tinclude snippets/fastcgi-php.conf|\tinclude snippets/fastcgi-php.conf|g' /etc/nginx/sites-enabled/default
sudo sed -i 's|#\t# With php5-fpm:|\t# With php5-fpm:|g' /etc/nginx/sites-enabled/default
sudo sed -i 's|#\tfastcgi_pass unix:/var/run/php5-fpm\.sock;|\tfastcgi_pass unix:/var/run/php5-fpm\.sock; }|g' /etc/nginx/sites-enabled/default
# sudo sed -i 's|#\tfastcgi_index index\.php;|\tfastcgi_index index\.php;|g' /etc/nginx/sites-enabled/default
# sudo sed -i 's|#\tinclude fastcgi_params;|\tinclude fastcgi_params; }|g' /etc/nginx/sites-enabled/default

# xrdp No GUI
#sudo apt-get install xrdp

# gparted
# sudo apt-get install gparted


