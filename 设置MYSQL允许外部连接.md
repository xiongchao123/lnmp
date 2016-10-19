mysql默认情况下，只允许localhost连接，如果需要外部IP连接到mysql，需要向mysql数据库里的“user”表里添加相关授权。

1. 改表法。可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%"
 
```sh
mysql -u root -pvmware
```

```sh
mysql>use mysql;
mysql>update user set host = '%' where user = 'root';
mysql>select host, user from user;
```

2. 授权法。
例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;
```

如果你想允许用户myuser从ip为192.168.1.3的主机连接到mysql服务器，并使用mypassword作为密码

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;
```

这是我在网上找到的资料，但是都试过了没有效果，只能退而求其次，在user表里面加一条记录host指定为空间的IP。测试通过。只是还是不能任意外部连接。
