##ubuntu install php


###一、下载PHP7的最新版源码
http://php.net/get/php-7.0.12.tar.gz/from/a/mirror
###三、安装相关依赖库
```sh
sudo apt-get update
sudo apt-get install libxml2-dev build-essential openssl libssl-dev make curl libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline6 libreadline6-dev 
#安装gcc
sudo apt-get install build-essential
sudo apt-get install openssl 
sudo apt-get install libssl-dev 
sudo apt-get install make
sudo apt-get install curl
sudo apt-get install libcurl4-gnutls-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libpng-dev
sudo apt-get install libmcrypt-dev
sudo apt-get install libreadline6 libreadline6-dev
```
merge
```sh
sudo apt-get update && sudo apt-get install libxml2-dev build-essential openssl libssl-dev make curl libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline6 libreadline6-dev libfreetype6-dev
```
###四、编译：（编译参数2个中选择一个，第一段大部分机器即可编译，第二段参数推荐64位x86系统编译）
```
tar zxvf php-7.0.12.tar.gz
cd php-7.0.12/
#part 1
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo --enable-maintainer-zts
#part 2
./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
```
###五、执行make 和 sudo make install 安装
```sh
make && sudo make install
echo "export PATH=/usr/local/php/bin:$PATH" >> /etc/profile
#
source /etc/profile
```
###六、配置php-fpm
如果www用户不存在，那么先添加www用户
```sh
sudo groupadd www
sudo useradd -g www www
```

```sh
sudo cp /software/php/php.ini-development /usr/local/php/etc/php.ini
cd /usr/local/php/etc
sudo cp php-fpm.conf.default php-fpm.conf
cd /usr/local/php/etc/php-fpm.d
sudo cp www.conf.default www.conf

sudo gedit /usr/local/php/etc/php-fpm.d/www.conf
#setting
user = www
group = www
#setting
sudo gedit /usr/local/php/etc/php-fpm.conf
pid=run/php-fpm.pid
```

###七、验证PHP
```
/usr/local/php/bin/php -v
```
###八、启动php-fpm
```sh
sudo /usr/local/php/sbin/php-fpm
```