#Linux下nginx日志分析工具

###Nginx access.log日志分析shell命令 

通过日志查看当天访问页面排前10的url:
```sh
cat access.log | grep "24/Mar/2011" | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10
```

通过日志查看当天ip连接数,统计ip地址的总连接数
```sh
cat access.log | grep "24/Mar/2011" | awk '{print $1}' | sort | uniq -c | sort –nr
     38 112.97.192.16
     20 117.136.31.145
     19 112.97.192.31
       3 61.156.31.20
       2 209.213.40.6
       1 222.76.85.28
```

通过日志查看当天访问次数最多的10个IP ,只需要在上一个命令后加上head命令
```sh
cat access.log | grep "24/Mar/2011" |awk '{print $3}'|sort |uniq -c|sort -nr|head –n 10
     38 112.97.192.16
     20 117.136.31.145
     19 112.97.192.31
       3 61.156.31.20
       2 209.213.40.6
       1 222.76.85.28
```

通过日志查看当天访问次数最多的10个IP
```sh
awk '{print $1}' access.log |sort |uniq -c|sort -nr|head
  10680 10.0.21.17
    1702 10.0.20.167
      823 10.0.20.51
      504 10.0.20.255
      215 58.60.188.61
      192 183.17.161.216
        38 112.97.192.16
        20 117.136.31.145
        19 112.97.192.31
          6 113.106.88.10
```

通过日志查看当天指定ip访问次数过的url和访问次数:
```sh
cat access.log | grep "10.0.21.17" | awk '{print $7}' | sort | uniq -c | sort –nr
    224 /test/themes/default/img/logo_index.gif
    224 /test/themes/default/img/bg_index_head.jpg
    224 /test/themes/default/img/bg_index.gif
    219 /test/vc.php
    219 /
    213 /misc/js/global.js
    211 /misc/jsext/popup.ext.js
    211 /misc/js/common.js
    210 /sladmin/home
    197 /misc/js/flib.js
```

通过日志查看当天访问次数最多的时间段
```sh
awk '{print $4}' access.log | grep "24/Mar/2011" |cut -c 14-18|sort|uniq -c|sort -nr|head
     24 16:49
     19 16:17
     16 16:51
     11 16:48
       4 16:50
       3 16:52
       1 20:09
       1 20:05
       1 20:03
       1 19:55
```


Linux系统下Nginx 日志可以查看系统运行记录和出错说明，对Nginx 日志的分析可以了解系统运行的状态。那么Linux系统Nginx日志怎么分析呢？
　　Nginx 日志相关配置有 2 个地方：access_log 和 log_format 。
　　默认的格式：
```sh
log_format  access_log_format  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
```

相信大部分用过 Nginx 的人对默认 Nginx 日志格式配置都很熟悉，对日志的内容也很熟悉。但是默认配置和格式虽然可读，但是难以计算。
　　Nginx 日志刷盘相关策略可配置：
　　比如，设置 buffer，buffer 满 32k 才刷盘；假如 buffer 不满 5s 钟强制刷盘的配置如下：
　　access_log /data/logs/nginx-access.log buffer=32k flush=5s;
　　这决定了是否实时看到日志以及日志对磁盘 IO 的影响。
　　Nginx 日志能够记录的变量还有很多没出现在默认配置中：
　　比如：
　　请求数据大小：$request_length
　　返回数据大小：$bytes_sent
　　请求耗时：$request_time
　　所用连接序号：$connection
　　当前连接发生请求数：$connection_requests
　　Nginx 的默认格式不可计算，需要想办法转换成可计算格式，比如用控制字符 ^A （Mac 下 ctrl+v ctrl+a 打出）分割每个字段。
　　log_format 的格式可以变成这样：
```sh
　　log_format new '$remote_addr^A$http_x_forwarded_for^A$host^A$time_local^A$status^A'
　　'$request_time^A$request_length^A$bytes_sent^A$http_referer^A$request^A$http_user_agent';
```

　　这样之后就通过常见的 Linux 命令行工具进行分析了：
　　查找访问频率最高的 URL 和次数：
```sh
cat access.log | awk -F ‘^A’ ‘{print $10}’ | sort | uniq -c
```
　　查找当前日志文件 500 错误的访问：
```sh
cat access.log | awk -F '^A' '{if（$5 == 500） print $0}'
```

查找当前日志文件 500 错误的数量：
```sh
cat access.log | awk -F '^A' '{if（$5 == 500） print $0}' | wc -l
```

　　查找某一分钟内 500 错误访问的数量：
```sh
cat access.log | awk -F '^A' '{if（$5 == 500） print $0}' | grep '09:00' | wc-l
```

查找耗时超过 1s 的慢请求：
```sh
tail -f access.log | awk -F '^A' '{if（$6》1） print $0}'
```

假如只想查看某些位：
```sh
tail -f access.log | awk -F '^A' '{if（$6》1） print $3″|”$4}'
```

查找 502 错误最多的 URL：
```sh
cat access.log | awk -F '^A' '{if（$5==502） print $11}' | sort | uniq -c
```

查找 200 空白页
```sh
cat access.log | awk -F '^A' '{if（$5==200 && $8 《 100） print $3″|”$4″|”$11″|”$6}'
```

查看实时日志数据流
```sh
tail -f access.log | cat -e
```

或者
```sh
tail -f access.log | tr '^A' '|'
```
照着这个思路可以做很多其他分析，比如 UA 最多的访问；访问频率最高的 IP；请求耗时分析；请求返回包大小分析；等等。
这就是一个大型 Web 日志分析系统的原型，这样的格式也是非常方便进行后续大规模 batching 和 streaming 计算。
以上就是Linux系统Nginx日志怎么分析的全部内容了，可以看出来Nginx日志还是有很强大的作用的。