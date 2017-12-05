####注册码

```sh
----- BEGIN LICENSE -----
eldon
Single User License
EA7E-1122628
C0360740 20724B8A 30420C09 6D7E046F
3F5D5FBB 17EF95DA 2BA7BB27 CCB14947
27A316BE 8BCF4BC0 252FB8FF FD97DF71
B11A1DA9 F7119CA0 31984BB9 7D71700C
2C728BF8 B952E5F5 B941FF64 6D7979DA
B8EB32F8 8D415F8E F16FE657 A35381CC
290E2905 96E81236 63D2B06D E5F01A69
84174B79 7C467714 641A9013 94CA7162
------ END LICENSE ------
```



###Package Control


The simplest method of installation is through the Sublime Text console. The console is accessed via the ctrl+` shortcut or the View > Show Console menu. Once open, paste the appropriate Python code for your version of Sublime Text into the console.

####SUBLIME TEXT 3

import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)

####SUBLIME TEXT 2

import urllib2,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')


###插件
####默认全局配置
```json
{
    "font_size": 12,
    "ignored_packages":
    [
        "Vintage"
    ],
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
}

```

####phpfmt
php格式化插件
安装本地php：
```sh
sudo apt-get install libxml2-dev build-essential openssl libssl-dev make curl libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline6 libreadline6-dev 
tar zxvf php-7.0.11.tar.gz
mv php-7.0.11 /home/qianxun/
/home/qianxun/php-7.0.11
./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-openssl --with-gettext --enable-session --with-mcrypt --with-curl --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-opcache
make && sudo make install
```
保存配置
```json
{
    "format_on_save": false,
    "php_bin": "D:/Program Files/php/php.exe",
    //"php_bin":"/usr/local/php/bin/php",
    "option": "value",
    "enable_auto_align": true,
    "indent_with_space": true,//自动空格
    "psr1": true,
    "psr2": true,
}
```
快捷键配置
```sh
[
    { "keys": ["ctrl+f10"], "command": "analyse_this" },
    { "keys": ["ctrl+f11"], "command": "fmt_now" }
]
```

####ConvertToUTF8
编码转换插件

####Emmet 
Emmet 是一个前端开发的利器，其前身是 Zen Coding。它让编写 HTML 代码变得简单。Emmet 的基本用法是：输入简写形式，然后按 Tab 键。

####DocBlockr
注释格式化插件

####SublimeLinter 
SublimeLinter 是一个代码校验插件，它可以帮你找出错误或编写不规范的代码，支持 C/C++、CoffeeScript、CSS、Git Commit Messages、Haml、HTML、Java、JavaScript、Lua、Objective-J、Perl、PHP、Puppet、Python、Ruby 和 XML 语言。

####SublimeCodeIntel
SublimeCodeIntel 是一个代码提示、补全插件，支持 JavaScript、Mason、XBL、XUL、RHTML、SCSS、Python、HTML、Ruby、Python3、XML、Sass、XSLT、Django、HTML5、Perl、CSS、Twig、Less、Smarty、Node.js、Tcl、TemplateToolkit 和 PHP 等语言，是 Sublime Text 自带代码提示功能的很好扩展。它还有一个功能就是跳转到变量、函数定义的地方，十分方便。

####MarkDown Editing (GitHub)
SublimeText 不仅仅是能够查看和编辑 Markdown 文件，但它会视它们为格式很糟糕的纯文本。这个插件通过适当的颜色高亮和其它功能来更好地完成这些任务。

####Git
在工作中，版本控制软件最常用的软件之一，而最流行的 VCS 是 Git。你是否厌倦了保存文本文件，并切换回终端运行一些 Git 命令。如果你能从文本编辑器本身执行 Git 命令，岂不是很好？

####GitGutter
Sublime Text 有了 Git 插件之后，GitGutter 更好的帮助开发者查看文件之前的改动和差异，提升开发效率。
