#【cmake安装】，MySQL安装需要
cd $SOFTPATH
tar -zxvf $SOFTPATH/$CMAKE.tar.gz
cd $SOFTPATH/$CMAKE
./bootstrap
make
make install > $LOGPATH/$CMAKE.install.log


#【安装MariaDB】
tar zxvf mariadb-10.1.4.tar.gz
groupadd -r mysql
mkdir -p /data/mysql
useradd -g mysql -r -d /data/mysql -s /sbin/nologin -c "MariaDB user" mysql
cd mariadb-10.1.4
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=3306
make
make install

chown -R mysql:mysql /data/mysql
chown -R mysql:mysql /usr/local/mysql
cp /usr/local/mysql/support-files/my-large.cnf /etc/my.cnf
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --level 345 mysqld on
/usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql/
vi /etc/init.d/mysqld
#编辑mariadbd,配置正确选项
[code]
basedir=/usr/local/mysql
datadir=/data/mysql
[/code]

echo "export PATH=/usr/local/mysql/bin:$PATH" >> /etc/profile
source /etc/profile

#启动MariaDB，并登陆
mysql
#登陆成功，可以看到我们现在使用的为MariaDB  
#可以用以下命令查看当前数据库的全局变量和会话变量

MariaDB [(none)]> show global variables\G;
MariaDB [(none)]> show session variables\G;

1.删除所有匿名用户
drop user ''@'localhost';
drop user ''@'bogon';


#给所有的root用户设定密码
#第一种方法
set password for 'root'@'localhost' = password('123456');
#第二张方法
update user set password=password('wangfeng7399')where user='root' and host='127.0.0.1';
第三种方式
mysqladmin -u root -h localhost password '123456' -p
mysqladmin -u root -h localhost -p flush-privileges

#【远程登陆】
开启防火墙
firewall-cmd --permanent --zone=public --add-service=mysql
#登陆管理界面
mysql -u root -p

select host,user from user;
 grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;
 flush privileges;