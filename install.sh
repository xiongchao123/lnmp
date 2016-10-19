#!/bin/sh
#this script is to install LNMP
#在开始之前请配置全局变量，以便安装的时候能找到目录
#源码包目录
SOFTPATH="/root/lnmp"
#安装日志目录
LOGPATH="/root/lnmp/log"
#libmcrypt版本名称
LIBMCRYPT="libmcrypt-2.5.7"
#cmake版本名称
CMAKE="cmake-3.4.1"
#pcre版本名称，nginx不支持pcre2,所以还是得安装pcre低版本的
PCRE="pcre-8.38"
#nginx版本信息
NGINX="nginx-1.9.9"
#MySQL版本信息
MYSQL="mysql-5.7.9"
#PHP版本信息
PHP="php-7.0.0"


#首先安装make、gcc、gcc-c++
yum -y install gcc gcc-c++ make autoconf automake ncurses-devel zlib-devel libxml2-devel libcurl-devel libpng-devel libmcrypt perl iconv libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel xmlrpc curl openssl openssl-devel unzip
#yum -y install make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap diffutils

mkdir -p $LOGPATH

#【pcre安装】，安装nginx需要,nginx不支持pcre2,所以还是得安装pcre低版本的
cd $SOFTPATH
tar -zxvf $SOFTPATH/$PCRE.tar.gz
cd $SOFTPATH/$PCRE
./configure --prefix=/usr/local/pcre --enable-utf --enable-unicode-properties
make
make install > $LOGPATH/$PCRE.install.log


#【安装ngnix】
groupadd www
useradd -g www -s /sbin/nologin -M www
cd $SOFTPATH
tar -zxvf $SOFTPATH/$NGINX.tar.gz
cd $SOFTPATH/$NGINX
#注意:--with-pcre=/usr/local/src/pcre-8.31指向的是源码包解压的路径，而不是安装的路径，否则会报错
./configure --prefix=/usr/local/nginx --without-http_memcached_module --user=www --group=www --with-http_stub_status_module --with-openssl=/usr/ --with-pcre=$SOFTPATH/$PCRE
make
make install > $LOGPATH/$NGINX.install.log

#【cmake安装】，MySQL安装需要
cd $SOFTPATH
tar -zxvf $SOFTPATH/$CMAKE.tar.gz
cd $SOFTPATH/$CMAKE
./bootstrap
make
make install > $LOGPATH/$CMAKE.install.log


#【安装MySQL】
groupadd mysql
mkdir -p /data/mysql
useradd -g mysql -s /sbin/nologin -c "MySQL user" mysql
chown -R mysql:mysql /data/mysql
mkdir -p /usr/local/mysql
cd $SOFTPATH
tar -zxvf $SOFTPATH/$MYSQL.tar.gz
cd $SOFTPATH/$MYSQL
#cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=3306
#安装5.7系列时会出现问题，解决方案地址http://kongzi68.blog.51cto.com/1432619/1629390，用第一个方式，简单粗暴
#也可以自行下载，记得不要解压，直接丢到对应的目录就行
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DMYSQL_TCP_PORT=3306 -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost
make
make install > $LOGPATH/$MYSQL.install.log


#【安装libmcrypt】安装php需要
cd $SOFTPATH
tar -zxvf $SOFTPATH/$LIBMCRYPT.tar.gz
cd $SOFTPATH/$LIBMCRYPT
./configure
make
make install > $LOGPATH/$LIBMCRYPT.install.log

#【安装php】
cd $SOFTPATH
tar -zxvf $SOFTPATH/$PHP.tar.gz
cd $SOFTPATH/$PHP
#./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-pdo-mysql=/usr/local/mysql --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
#另外一种数据库驱动
./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
make
make install > $LOGPATH/$PHP.install.log
