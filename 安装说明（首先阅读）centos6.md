前期部分
vi /etc/sysconfig/iptables
#在-A INPUT -j REJECT --reject-with icmp-host-prohibited上面一行加入，否则无效过
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT   
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
#重启防火墙使配置生效
service iptables restart

vi /etc/selinux/config
#SELINUX=enforcing #注释掉
#SELINUXTYPE=targeted #注释掉
SELINUX=disabled #增加
保存关闭后重启电脑

然后配置install.sh中的变量，包括源码包目录、安装日志目录、源码包版本信息，以防止安装时出错，然后执行sh install.sh,解压安装所有对应的源码包


配置部分：

NGINX

第一步：
#启动nginx
/usr/local/nginx/sbin/nginx
设置nginx开机启动
vi /etc/rc.d/init.d/nginx
将文件夹nginx中的nginx文件中的内容添加进去，
然后保存退出
#赋予文件执行权限
chmod 775 /etc/rc.d/init.d/nginx
#设置开机启动
chkconfig nginx on
#重启或service nginx restart
/etc/rc.d/init.d/nginx restart

第三步：
等配置文件生成/usr/local/nginx/conf/nginx.conf
将其中的配置选项添加如下几行，但事先要在此目录建立extra/vhosts目录,
mkdir -p /usr/local/nginx/conf/vhosts/

#include vhosts conf file, server setting
include ./vhosts/*.conf;
这样就可以将不同的网站配置文件分开，便于管理查看和备份


MySQL


chown -R mysql:mysql /usr/local/mysql
\cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
\cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --level 345 mysqld on
/usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql/ --defaults-file
vi /etc/init.d/mysqld
#编辑mysqld,配置正确选项
[code]
basedir=/usr/local/mysql
datadir=/data/mysql
[/code]

service mysqld start
#环境变量设置
echo "export PATH=/usr/local/mysql/bin:$PATH" >> /etc/profile
source /etc/profile
#ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql/(32位)
ln -s /usr/local/mysql/lib/mysql /usr/lib64/mysql/ #（64位）
ln -s /usr/local/mysql/include/mysql /usr/include/mysql

mysqladmin -u root -p password "新密码"#回车之后会提示输入原始密码
service mysqld restart
【新情况，不知道为何旧方法不能修改默认密码，提供以下方法修改初始密码】
用 service mysqld stop
mysqld_safe --skip-grant-tables &
输入 mysql -uroot -p 回车进入
>use mysql;
> update user set password=PASSWORD("newpass") where user="root";
 更改密码为 newpassord
> flush privileges; 更新权限
> quit 退出
service mysqld restart
mysql -uroot -p新密码进入
【新情况结束】

PHP

#拷贝配置文件
cp /software/php-5.6.3/php.ini-production /usr/local/php-5.6.3/etc/php.ini
#删除系统自带配置文件
rm -rf /etc/php.ini
ln -s /usr/local/php-5.6.3/etc/php.ini /etc/php-5.6.3.ini
cp /usr/local/php-5.6.3/etc/php-fpm.conf.default /usr/local/php-5.6.3/etc/php-fpm.conf
#编辑配置文件
vi /usr/local/php-5.6.3/etc/php-fpm.conf
	user=www   	#设置php-fpm运行账号为www
    group=www   #设置php-fpm运行组为www
    pid=run/php-fpm.pid #取消前面的分号


cp /software/php-5.6.3/sapi/fpm/init.d.php-fpm /etc/init.d/php-5.6.3-fpm
chmod +x /etc/init.d/php-5.6.3-fpm 
chkconfig php-5.6.3-fpm on
#更改相应选项
vi /etc/php-5.6.3.ini

	disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname
	date.timezone=PRC
	#短标记语法
	expose_php=Off
#记得启动php-fpm服务
/etc/init.d/php-5.6.3-fpm start
【端口问题】http://my.oschina.net/zhichi2011/blog/118807
	
	
配置nginx支持php
网站部署，整个网站目录在/data/www-data/目录下
然后不同的网站建立不同的子目录。
如wordpress则目录是/data/www-data/wordpress/
然后在其目录下载分别建立www、log、

vi /usr/local/nginx/conf/nginx.conf
	user www www; #首行user去掉注释,修改Nginx运行组为www www；必须与/usr/local/php5/etc/php-fpm.conf中的user,group配置相同，否则php运行出错
	
	index index.php index.html index.htm; #添加index.php
	......
	
	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	#
	location ~ \.php$ {
	root html;
	fastcgi_pass 127.0.0.1:9000;
	fastcgi_index index.php;
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	include fastcgi_params;
	}
#取消FastCGI server部分location的注释,并要注意fastcgi_param行的参数,改为$document_root$fastcgi_script_name,或者使用绝对路径

切割日志脚本
cut_nginx_log.sh
授予网站的执行权限
mkdir /data/www-data/
setfacl -m u:www:rwx -R /data/www-data/
setfacl -m d:u:www:rwx -R /data/www-data/

该案例采用了虚拟主机配置文件分离，便于管理和操作，另外codeigniter 的php框架和普通程序框架不同，所以fastcgi的配置和普通配置也不一致，注意区分
mkdir /usr/local/nginx/conf/fastcgi /usr/local/nginx/conf/vhosts

另外可以使用不同的php版本，区分侦听端口号既可，
vi /usr/local/php-5.5.0/etc/php-fpm.conf
修改对应的端口好，然后启动服务。
listen = 127.0.0.1:9001
然后在虚拟主机配置文件中也要修改相应的端口好，否则没有效果。

#原著网页
http://itchenyi.blog.51cto.com/4745638/1085230
