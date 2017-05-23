#PHP慢脚本日志和Mysql的慢查询日志

###1、PHP慢脚本日志
间歇性的502，是后端 PHP-FPM 不可用造成的，间歇性的502一般认为是由于 PHP-FPM 进程重启造成的。
在 PHP-FPM 的子进程数目超过的配置中的数量时候，会出现间歇性的502错误，如果在配置中设置了max_requests的话，超过数量也会出现502错误，而max_requests的设置，正是为了防止不安全的第三方library脚本的 内存泄露 ，当然你自己编写的脚本存在 死锁 的话，也会出现502现象。

如果你发现mysql负载并不高，但是php-fpm的进程数和内存占用过高的话，恭喜你，大多数情况下是因为脚本存在死锁。

###2. 既然找到了是php的问题，如何去定位php脚本呢？
开启php慢查询日志：

```sh
$ sudo vi /usr/local/php/etc/php-fpm.d/www.conf
; Default Value: 0
request_slowlog_timeout = 1s
; The log file for slow requests
; Default Value: /usr/local/php/log/php-fpm.log.slow
slowlog = /usr/local/php/log/php-fpm.log.slow
```

默认的 request_slowlog_timeout 是0，php的慢脚本日志是关闭的，因此设置为大于0的n，表示执行时间超过n的脚本将记录进入slowlog里。
然后监测到网站存在问题的时候查看下slowlog即可发现慢脚本，对脚本进行检查处理即可。

###3. 2、Mysql的慢查询日志
mysql慢查询日志对于跟踪有问题的查询非常有用,可以分析出当前程序里有很耗费资源的sql语句,那如何打开mysql的慢查询日志记录呢?

其实打开mysql的慢查询日志很简单,只需要在mysql的配置文件里(windows系统是my.ini,linux系统是my.cnf)的[mysqld]下面加上如下代码：

```sh
log-slow-queries=/var/lib/mysql/slowquery.log
long_query_time=2
long_query_time=2中的2表示查询超过两秒才记录.
```

如果日志内容很多，用眼睛一条一条去看会累死，mysql自带了分析的工具，使用方法如下：

```sh
$ cd /usr/local/mysql/bin
$ mysqldumpslow –help
-s，是order的顺序，主要有c,t,l,r和ac,at,al,ar，分别是按照query次数，时间，lock的时间和返回的记录数来排序，前面加了a的时倒叙
-t，是top n的意思，即为返回前面多少条的数据
-g，后边可以写一个正则匹配模式，大小写不敏感的
$ mysqldumpslow -s c -t 20 host-slow.log #访问次数最多的20个sql语句
$ mysqldumpslow -s r -t 20 host-slow.log #返回记录集最多的20个sql
$ mysqldumpslow -t 10 -s t -g “left join” host-slow.log #按照时间返回前10条里面含有左连接的sql语句
```

[mysql慢查询日志查询手册](https://dev.mysql.com/doc/refman/5.7/en/mysqldumpslow.html)