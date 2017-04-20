###centos7搭建安装lnmp环境

libmcrypt
```sh
#使用wget可以通过以下路径下载
wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/attic/libmcrypt/libmcrypt-2.5.7.tar.gz
 
#解压
tar -zxvf libmcrypt-2.5.7.tar.gz 
 
#进入目录
cd libmcrypt-2.5.7
 
#编译（默认安装到/usr/local/lib/）
./configure --prefix=/usr/local/libmcrypt
 
#执行安装
make && make install
```

curl
```sh
tar zxvf curl-7.53.1.tar.gz
cd curl-7.53.1/
./configure --prefix=/usr/local/curl
make && sudo make install
```

php
```sh
yum -y install gcc gcc-c++ make autoconf automake ncurses-devel zlib-devel libxml2-devel libcurl-devel libpng-devel libmcrypt perl iconv libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel xmlrpc curl openssl openssl-devel unzip

./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt=/usr/local/libmcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
make && make install
```
