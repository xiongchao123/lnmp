#PHP性能分析

###Xdebug安装

```sh
git clone --depth=1 -v https://github.com/xdebug/xdebug.git /tmp/xdebug-ext
cd /tmp/xdebug-ext && phpize && ./configure --enable-xdebug && sudo make && sudo make install
sudo subl /usr/local/php/etc/php.ini
#912行加入：
#------------------------------------
extension=xdebug.so
;xdebug配置
[Xdebug]
;开启自动跟踪
xdebug.auto_trace = 1
;开启异常跟踪
xdebug.show_exception_trace = 1
;开启远程调试自动启动
xdebug.remote_autostart = 1
;开启远程调试
xdebug.remote_enable = 1
;收集变量
xdebug.collect_vars = 1
;收集返回值
xdebug.collect_return = 1
;收集参数
xdebug.collect_params = 1
;性能监控
xdebug.profiler_enable = 1
xdebug.trace_output_dir="/tmp/xdebug"
;用来存放性能分析文件,可自由定义目录
xdebug.profiler_output_dir = "/tmp/xdebug"
xdebug.profiler_output_name = "cachegrind.out.%s"
#------------------------------------

#重启
sudo kill -SIGUSR2 `cat /usr/local/php/var/run/php-fpm.pid`
```
####参数意义
|符号 | 含义 | 配置样例  |  样例文件名 |
| :----: | :----:  | :----:  | :----:  |
|%c | 当前工作目录的crc32校验值 | trace.%c  |  trace.1258863198.xt|
|%p | 当前服务器进程的pid | trace.%p  |  trace.5174.xt|
|%r | 随机数 | trace.%r  |  trace.072db0.xt|
|%s | 脚本文件名(注)  |  cachegrind.out.%s  | cachegrind.out._home_httpd_html_test_xdebug_test_php|
|%t | Unix时间戳(秒) | trace.%t  |  trace.1179434742.xt|
|%u | Unix时间戳(微秒) | trace.%u   | trace.1179434749_642382.xt|
|%H | $_SERVER['HTTP_HOST']  | trace.%H   | trace.kossu.xt |
|%R | $_SERVER['REQUEST_URI'] | trace.%R  |  trace._test_xdebug_test_php_var=1_var2=2.xt |
|%S | session_id (来自$_COOKIE 如果设置了的话) | trace.%S    trace.c70c1ec2375af58f74b390bbdd2a679d.xt|
|%% | %字符| trace.%%  |  trace.%.xt|
|注 此项不适用于trace file的文件名 |

比如，我想针对每个文件生成一个输出文件。
那么我可以用：
```sh
xdebug.profiler_output_name = cachegrind.out.%s
```
多个域名的话，也可以组合使用
```sh
xdebug.profiler_output_name = cachegrind.out.%H.%u.%s
```


###分析工具
官方文档：https://xdebug.org/docs/profiler
KCachegrind（Linux）：https://kcachegrind.github.io/html/Home.html
WinCacheGrind（Windows）：http://ceefour.github.io/wincachegrind/


###KCachegrind安装使用
```sh
git clone git://anongit.kde.org/kcachegrind
```