#################################################
#
# Pip and others
#
# start
#################################################

#pip
sudo apt-get install python-pip

# ipython
# sudo pip install ipython

# python libraries
sudo pip install paho-mqtt

#################################################
#
# mosquitto 1.4.2 with websocket
#
# start
#################################################
sudo apt-get update

## Step 1. preparing the build system# 
sudo apt-get install build-essential
sudo apt-get install libssl-dev
sudo apt-get install cmake
sudo apt-get install libc-ares-dev
sudo apt-get install uuid-dev
sudo apt-get install daemon
sudo apt-get install libssl-dev

## Step 2. libwebsocket
wget http://git.libwebsockets.org/cgi-bin/cgit/libwebsockets/snapshot/libwebsockets-1.4-chrome43-firefox-36.tar.gz
tar zxvf libwebsockets-1.4-chrome43-firefox-36.tar.gz
cd libwebsockets-1.4-chrome43-firefox-36
mkdir build
cd build
sudo cmake ..
sudo make install
sudo ldconfig
cd ../..

Step 3. Download and build mosquitto 1.4.2
wget http://mosquitto.org/files/source/mosquitto-1.4.2.tar.gz
tar zxvf mosquitto-1.4.2.tar.gz
cd mosquitto-1.4.2
sed -i 's/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/' config.mk

make
sudo make install
sudo cp mosquitto.conf /etc/mosquitto
echo "port 1883" | sudo tee -a /etc/mosquitto/mosquitto.conf
echo "listener 9001" | sudo tee -a /etc/mosquitto/mosquitto.conf
echo "protocol websockets" | sudo tee -a sudo /etc/mosquitto/mosquitto.conf
cd ..

# useradd mosquitto
sudo useradd mosquitto

# add to rc.local
sudo sed -i '$i\mosquitto -c /etc/mosquitto/mosquitto.conf > /dev/null 2>\&1 \&' /etc/rc.local

# mosquitto_pub, mosquit_sub
sudo apt-get install mosquitto-clients

#################################################
#
# NGINX and php
#
# start
#################################################

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
sudo chmod a+w /var/www/html

#################################################
#
# Others
#
# start
#################################################

# xrdp No GUI
#sudo apt-get install xrdp

# gparted
# sudo apt-get install gparted

#nkf
sudo apt-get install nkf

#################################################
#
# gc05 
#
# start
#################################################

#hostname
sudo sh -c "echo gc05 > /etc/hostname"

# SCRIPT
script_path=/home/pi/SCRIPT
if [ -e $script_path ]; then :
else
  mkdir $script_path
  cp SCRIPT/* $script_path
fi
sudo sed -i '$i\python /home/pi/SCRIPT/pub.py  > /dev/null 2>&1 &' /etc/rc.local

# www
www_path=/var/www/html
#if [ -e $www_path ]; then :
#else
#  mkdir $www_path
  cp www/* $www_path
#fi

# Chart.js
wget -P $www_path https://raw.githubusercontent.com/nnnick/Chart.js/master/Chart.js

# browserMqtt
# http://lealog.hateblo.jp/entry/2015/07/24/205838
wget -P $www_path https://gist.githubusercontent.com/leader22/87350894dbe552f4c94a/raw/be5d4f3c803f3f3695553920d2d945dc2d62ad85/browserMqtt-1.3.5.js

####################
#                  #
# For Each Sensor. #
#                  #
####################

#max31855
wget https://github.com/Tuckie/max31855/archive/master.zip
unzip -d $script_path master.zip
rm master.zip
