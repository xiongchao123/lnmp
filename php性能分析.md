#PHP性能分析

##一、OneAPM(收费)
http://www.oneapm.com/index.html

##二、xhprof分析性能（Facebook）
http://blog.csdn.net/lvchengbo/article/details/52849179

PECL上提供的最新扩展并不支持php7版本
如果想为php7使用xhprof进行性能分析的话请参考https://github.com/Yaoguais/phpng-xhprof所介绍的方法进行编译安装。
https://github.com/Yaoguais/phpng-xhprof

```sh
git clone git@github.com:Yaoguais/phpng-xhprof.git /tmp/xhprof-ext
cd /tmp/xhprof-ext && phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make clean && make && make test && sudo make install
sudo subl /usr/local/php/etc/php.ini
#------------------------------------
[xhprof]
extension=phpng_xhprof.so
xhprof.output_dir=/tmp/xhprof
#------------------------------------
```

###重启
sudo kill -SIGUSR2 `cat /usr/local/php/var/run/php-fpm.pid`
sudo mkdir -p /tmp/xhprof
sudo chmod 777 /tmp/xhprof
```
####对PHP进行性能分析
在XHProf扩展中，一共提供了四个函数用于对PHP进行性能分析。
xhprof_enable/xhprof_sample_enable函数用于开始XHProf性能分析，区别在于前者功能更加强大，而后者则是是以简单模式启动性能分析（简单记录了函数的调用栈信息），开销比较小。
xhprof_disable/xhprof_sample_disable函数用于停止性能分析，并返回分析的数据。
需要特别说明的函数是xhprof_enable，其他函数都是不需要提供参数的，而该函数则可以接受两个可选的参数，用于改变该工具的行为。
void xhprof_enable ([ int $flags = 0 [, array $options ]] )
flags该参数用于为剖析结果添加额外的信息，该参数的值使用以下宏，如果需要提供多个值，使用|进行分隔。
XHPROF FLAGS NO_BUILTINS 跳过所有的内置函数
XHPROF FLAGS CPU 添加对CPU使用的分析
XHPROF FLAGS MEMORY 添加对内存使用的分析
options数组形式提供可选参数，在此处提供ignored_functions选项需要忽略的函数
比如下面的例子，同时对内存和CPU进行分析，并且忽略对call_user_func和call_user_func_array函数的分析。
```php
PHP5.5以下，PHP文件中开启的代码
xhprof_enable(
  XHPROF_FLAGS_MEMORY|XHPROF_FLAGS_CPU,
  [
    'ignored_functions'	=> [
      'call_user_func',
      'call_user_func_array'
    ]
  ]
);
#PHP5.5及以上，PHP文件中开启的代码
xhprof_enable(XHPROF_FLAGS_NO_BUILTINS | XHPROF_FLAGS_CPU | XHPROF_FLAGS_MEMORY,
 [
   'ignored_functions'	=> [
     'call_user_func',
     'call_user_func_array'
   ]
 ]
);
// 这里是PHP代码，比如业务逻辑实现等要被分析的代码部分
....
xhprof_enable();
// your code
// ...
file_put_contents((ini_get('xhprof.output_dir') ? : '/tmp') . '/' . uniqid() . '.xhprof.xhprof', serialize(xhprof_disable()));
```


###形象化的查看分析结果

PHP性能被动分析工具之xhgui加tideways的安装实践
https://segmentfault.com/a/1190000007580819

##三、xhgui+tideways
https://segmentfault.com/a/1190000007580819

##四、Xdebug安装（推荐）

```sh
git clone --depth=1 -v https://github.com/xdebug/xdebug.git /tmp/xdebug-ext
cd /tmp/xdebug-ext && phpize && ./configure --enable-xdebug && sudo make && sudo make install
sudo subl /usr/local/php/etc/php.ini
#912行加入：
#------------------------------------
zend_extension=xdebug.so
;xdebug配置
[Xdebug]
;开启自动跟踪
xdebug.auto_trace=1
;开启异常跟踪
xdebug.show_exception_trace=0
;开启远程调试自动启动
xdebug.remote_autostart=1
;开启远程调试
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port = 9000
xdebug.scream=0
xdebug.show_local_vars=1
xdebug.idekey=PHPSTORM
;收集变量
xdebug.collect_vars=1
;收集返回值
xdebug.collect_return=1
;收集参数
xdebug.collect_params=1
;是否覆盖php里面的函数var_dump();默认是开启的，值为1；设为0，则关闭；
xdebug.overload_var_dump = 1
;控制数组子元素显示的大小默认为256
xdebug.var_display_max_children = 256
;控制变量打印的大小，默认为512
xdebug.var_display_max_data = 512
;控制数组和对象元素显示的层级。默认为3
xdebug.var_display_max_depth = 3
;性能监控
xdebug.profiler_enable=1
;xdebug.profiler_enable_trigger=1
;xdebug.profiler_enable_trigger_value=1
xdebug.trace_output_dir=/tmp/xdebug
xdebug.trace_output_name=trace.
;用来存放性能分析文件,可自由定义目录
xdebug.profiler_output_dir=/tmp/xdebug
xdebug.profiler_output_name=cachegrind.out.%H.%R
#------------------------------------

###重启
sudo kill -SIGUSR2 `cat /usr/local/php/var/run/php-fpm.pid`
sudo mkdir -p /tmp/xdebug
sudo chmod 777 /tmp/xdebug
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

注 此项不适用于trace file的文件名


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
sudo apt-get install kcachegrind
```