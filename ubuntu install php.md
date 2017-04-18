##ubuntu install php


###一、下载PHP7的最新版源码
http://php.net/get/php-7.1.4.tar.gz/from/a/mirror
###二、安装相关依赖库
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
sudo apt-get install libreadline6 libreadline6-dev autoconf
```
merge
```sh
sudo apt-get update && sudo apt-get install libxml2-dev build-essential openssl libssl-dev make curl libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline6 libreadline6-dev libfreetype6-dev autoconf -y
```
###三、编译：（编译参数2个中选择一个，第一段大部分机器即可编译，第二段参数推荐64位x86系统编译）
```
tar zxvf php-7.1.4.tar.gz
cd php-7.1.4/
#part 1
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo --enable-maintainer-zts
#part 2
./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
```
###四、执行make 和 sudo make install 安装
```sh
make && sudo make install
echo "export PATH=/usr/local/php/bin:$PATH" >> /etc/profile
#
source /etc/profile
```
###五、配置php-fpm
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

###六、验证PHP
```
/usr/local/php/bin/php -v
```
###七、启动php-fpm
```sh
sudo /usr/local/php/sbin/php-fpm
```
###7.将编译目录下的文件拷贝只系统目录，这样操作fpm更加方便
```sh
sudo cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
sudo chmod +x /etc/init.d/php-fpm
#启动
sudo systemctl start php-fpm
#开机启动
sudo systemctl enable php-fpm.service
#更改相应选项
vi /etc/php.ini
	disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname
	date.timezone=PRC
	#短标记语法
	expose_php=Off
#记得启动php-fpm服务
sudo systemctl restart php-fpm
```
###fpm操作
自php5.3.3开始，php源码中包含了php-fpm，不需要单独通过补丁的方式安装php-fpm，在源码安装的时候直接 configure 中增加参数 –enable-fpm 即可。
所以启动、关闭和重新加载的方式和以前不同，需要使用信号控制：
php-fpm master 进程可以理解一下信号：
```sh
SIGINT, SIGTERM 立刻终止
SIGQUIT 平滑终止
SIGUSR1 重新打开日志文件
SIGUSR2 平滑重载所有worker进程并重新载入配置和二进制模块
```
```sh
#查找进程号
ps -aux | grep php-fpm
#关闭php-fpm
sudo kill -SIGINT `cat /usr/local/php/var/run/php-fpm.pid`
#重启
sudo kill -SIGUSR2 `cat /usr/local/php/var/run/php-fpm.pid`
```
注意：/usr/local/php/var/run/php-fpm.pid 指存储master进程号的文件，这里是默认地址，在配置中可以修改，另外可以使用ps命令找到master的进程号，然后使用 kill 信号 进程号 的方式。


装扩展：
xdebug:
```sh
git clone --depth=1 -v https://github.com/xdebug/xdebug.git /tmp/xdebug-ext
cd /tmp/xdebug-ext && phpize && ./configure --enable-xdebug && sudo make && sudo make install
```

mongodb:
```sh
git clone --depth=1 -v https://github.com/mongodb/mongo-php-driver.git /tmp/mongodb-ext
cd /tmp/mongodb-ext
git submodule sync && git submodule update --init
phpize && ./configure && make all -j 5 && sudo make install
```

memcached：
```sh
sudo apt-get install libmemcached-dev
git clone --depth=1 -v https://github.com/php-memcached-dev/php-memcached.git /tmp/memcached-ext
cd /tmp/memcached-ext && phpize && ./configure && sudo make && sudo make install
```

phalcon:
克隆后替换部分字符：
>php-config  >>  /usr/local/php/bin/php-config
>phpize  >>  /usr/local/php/bin/phpize

```sh
git clone --depth=1 -v https://github.com/phalcon/cphalcon.git /tmp/phalcon-ext
sudo gedit /tmp/phalcon-ext/build/install
cd /tmp/phalcon-ext/build && sudo ./install
```

phpredis:
```sh
git clone --depth=1 -v https://github.com/phpredis/phpredis.git /tmp/phpredis-ext
cd /tmp/phpredis-ext && phpize && ./configure && sudo make && sudo make install
```

swoole:
```sh
git clone --depth=1 git@git.oschina.net:swoole/swoole.git /tmp/swoole-ext
cd /tmp/swoole-ext && phpize && ./configure && sudo make && sudo make install
```

runkit:
```sh
git clone --depth=1 -v git@github.com:runkit7/runkit7.git /tmp/runkit-ext
cd /tmp/runkit-ext && phpize && ./configure && sudo make && sudo make install
```

```sh
sudo subl /usr/local/php/etc/php.ini
912行加入：
zend_extension=xdebug.so
extension=memcached.so
extension=mongodb.so
extension=phalcon.so
extension=redis.so
extension=swoole.so
extension=runkit.so
```

composer全局安装：
```sh
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
#修改 composer 的全局配置文件
composer config -g repo.packagist composer https://packagist.phpcomposer.com
#修改当前项目的 composer.json 配置文件：
#打开命令行窗口（windows用户）或控制台（Linux、Mac 用户），进入你的项目的根目录（也就是 composer.json 文件所在目录），执行如下命令：
composer config repo.packagist composer https://packagist.phpcomposer.com
```