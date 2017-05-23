###centos7搭建安装lnmp环境

软件源码包都放在`/data/software/`目录下，所以一开始要执行
```sh
mkdir -p /data/software/
groupadd www
useradd -g www -s /sbin/nologin -M www
```

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
wget https://curl.haxx.se/download/curl-7.54.0.tar.gz
tar zxvf curl-7.54.0.tar.gz
cd curl-7.54.0/
./configure --prefix=/usr/local/curl
make && make install
```

php
```sh

yum -y install gcc gcc-c++ make autoconf automake ncurses-devel zlib-devel libxml2-devel libcurl-devel libpng-devel libmcrypt perl iconv libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel xmlrpc curl openssl openssl-devel unzip

wget http://cn.php.net/distributions/php-7.1.4.tar.gz
tar zxvf php-7.1.4.tar.gz
cd php-7.1.4

./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt=/usr/local/libmcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
make && make install

echo "export PATH=/usr/local/php/bin:$PATH" >> /etc/profile
#
source /etc/profile
cp /data/software/php-7.1.4/php.ini-development /usr/local/php/etc/php.ini
cd /usr/local/php/etc
cp php-fpm.conf.default php-fpm.conf
cd /usr/local/php/etc/php-fpm.d
cp www.conf.default www.conf
vi /usr/local/php/etc/php-fpm.d/www.conf
#setting
user = www
group = www
#setting
vi /usr/local/php/etc/php-fpm.conf
pid=run/php-fpm.pid

/usr/local/php/sbin/php-fpm
cp /data/software/php-7.1.4/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
#启动
systemctl start php-fpm
#开机启动
systemctl enable php-fpm.service
#更改相应选项
vi /usr/local/php/etc/php.ini
    disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname
    date.timezone=PRC
    #短标记语法
    expose_php=Off
#记得启动php-fpm服务
systemctl restart php-fpm

cd /data/software/
yum install git -y
```

htop:
```sh
git clone --depth=1 -v https://github.com/hishamhm/htop /data/software/htop
cd /data/software/htop && ./autogen.sh && ./configure && make && make install
```


装扩展：
xdebug:
```sh
git clone --depth=1 -v https://github.com/xdebug/xdebug.git /data/software/xdebug-ext
cd /data/software/xdebug-ext && phpize && ./configure --enable-xdebug && make && make install
```

mongodb:
```sh
git clone --depth=1 -v https://github.com/mongodb/mongo-php-driver.git /data/software/mongodb-ext
cd /data/software/mongodb-ext
git submodule sync && git submodule update --init
phpize && ./configure && make all -j 5 && make install
```

memcached：
```sh
wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz -O /data/software/libmemcached-1.0.18.tar.gz
cd /data/software/
tar zxvf /data/software/libmemcached-1.0.18.tar.gz
cd libmemcached-1.0.18
./configure --prefix=/usr/local/libmemcached && make && make install
```
```sh
#yum install libmemcached -y
git clone --depth=1 -v https://github.com/php-memcached-dev/php-memcached.git /data/software/memcached-ext
cd /data/software/memcached-ext && phpize && ./configure --with-libmemcached-dir=/usr/local/libmemcached --disable-memcached-sasl && make && make install
```

phalcon:
克隆后替换部分字符：
```sh
git clone --depth=1 -v https://github.com/phalcon/cphalcon.git /data/software/phalcon-ext
vi /data/software/phalcon-ext/build/install
#由于安装问题需要替换掉源码包中php的某些路径：
phpize  >>  /usr/local/php/bin/phpize
php-config  >>  /usr/local/php/bin/php-config
#如果提示You will need re2c 0.13.4，则执行
yum -y install re2c

cd /data/software/phalcon-ext/build && sudo ./install
```

phpredis:
```sh
git clone --depth=1 -v https://github.com/phpredis/phpredis.git /data/software/phpredis-ext
cd /data/software/phpredis-ext && phpize && ./configure && make && make install
```

swoole:
```sh
git clone --depth=1 https://git.oschina.net/swoole/swoole.git /data/software/swoole-ext
cd /data/software/swoole-ext && phpize && ./configure && make && make install
```

runkit:
```sh
git clone --depth=1 -v https://github.com/runkit7/runkit7.git /data/software/runkit-ext
cd /data/software/runkit-ext && phpize && ./configure && make && make install
```

```sh
vi /usr/local/php/etc/php.ini
912行加入：
zend_extension=xdebug.so
extension=memcached.so
extension=mongodb.so
extension=phalcon.so
extension=redis.so
extension=swoole.so
extension=runkit.so
```

```sh
#查找进程号
ps -aux | grep php-fpm
#关闭php-fpm
kill -SIGINT `cat /usr/local/php/var/run/php-fpm.pid`
#重启
kill -SIGUSR2 `cat /usr/local/php/var/run/php-fpm.pid`
```

composer全局安装：
```sh
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
#修改 composer 的全局配置文件
composer config -g repo.packagist composer https://packagist.phpcomposer.com
#修改当前项目的 composer.json 配置文件：
#打开命令行窗口（windows用户）或控制台（Linux、Mac 用户），进入你的项目的根目录（也就是 composer.json 文件所在目录），执行如下命令：
composer config repo.packagist composer https://packagist.phpcomposer.com
```

nginx
```sh
wget http://nginx.org/download/nginx-1.13.0.tar.gz
tar zxvf nginx-1.13.0.tar.gz 
cd nginx-1.13.0/
yum install -y libpcre3 libpcre3-dev openssl libssl-dev
./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-http_gzip_static_module
make && make install
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf

vi /usr/local/nginx/conf/nginx.conf

##input and replace
#include vhosts conf file, server setting
include ./vhosts/*.conf;

mkdir -p /usr/local/nginx/conf/vhosts/
cp /mnt/hgfs/website/lnmp/nginx/vhosts/suofeiya_wx.conf /usr/local/nginx/conf/vhosts/

```

###7.
```sh
/usr/local/nginx/sbin/nginx -h
/usr/local/nginx/sbin/nginx -s stop
/usr/local/nginx/sbin/nginx -s quit
/usr/local/nginx/sbin/nginx -s reopen
/usr/local/nginx/sbin/nginx -s reload
```
