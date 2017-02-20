Ubuntu 16.04下安装VMware Tools
http://blog.csdn.net/hexiechina2010/article/details/51469399

http://www.linuxdiyf.com/linux/20858.html

###Ubuntu 16.04 LTS安装好之后需要做的15件事
https://www.sysgeek.cn/15-things-to-do-after-installing-ubuntu-16-04-lts/

####qq的安装方法：
http://blog.csdn.net/fuchaosz/article/details/51919607

####git的安装及使用方法：
http://www.cnblogs.com/jackge/archive/2013/08/17/3264801.html

####svn的安装及使用方法：
http://www.cnblogs.com/cocowool/archive/2008/11/10/1330932.html

####OS X 和 Linux下微信客户端 electronic-wechat
http://www.oschina.net/p/electronic-wechat?fromerr=HYUuhLNx
中文说明书，建议直接下载开箱即用稳定版：
https://github.com/geeeeeeeeek/electronic-wechat/blob/master/README_zh.md
开箱即用稳定版：
https://github.com/geeeeeeeeek/electronic-wechat/releases

nodejs安装方法
http://www.xitongzhijia.net/xtjc/20150202/36680.html

ubuntu下安装docker方法：
http://blog.csdn.net/mickjoust/article/details/51578629

sublime text3中文输入问题修复：
https://my.oschina.net/lee2013/blog/396855

ubuntu下安装最新版GCC的方法：
http://www.linuxidc.com/Linux/2016-11/136840.htm

http://blog.csdn.net/skykingf/article/details/45267517

git安装及初始化：
```sh
sudo apt-get install git
git config --global user.name "zhaojianhui"
git config --global user.email "zhaojianhui129@163.com"
ssh-keygen -t rsa -C "zhaojianhui129@163.com"
cat ~/.ssh/id_rsa.pub
```
ubuntu优化：
```sh
sudo apt-get autoremove libreoffice-common
sudo apt-get autoremove totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get autoremove onboard deja-dup
```


ubuntu修改host方法：

具体过程如下：
#1、修改hosts
```sh
sudo gedit /etc/hosts
```
#2、添加解析记录（ . ）
完整案例：127.0.0.1 localhost.localdomain localhost
简洁记录：127.0.0.1 localhost
#3、保存后重启网络
```sh
sudo /etc/init.d/networking restart
```


ubuntu设置桌面图标：

zend studio:
```sh
sudo gedit /usr/share/applications/zend-studio.desktop
```

输入以下内容：
```sh
[Desktop Entry]
Encoding=UTF-8
Name=Zend Studio 13.5
Comment=Zend Studio IDE
Exec=/opt/ZendStudio/ZendStudio
Icon=/opt/ZendStudio/icon.xpm
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

phpstorm:
```sh
sudo gedit /usr/share/applications/phpstorm.desktop
```
输入以下内容：
```sh
[Desktop Entry]
Encoding=UTF-8
Name=Phpstorm 2016.2
Comment=Phpstorm IDE
Exec=/opt/PhpStorm/bin/phpstorm.sh
Icon=/opt/PhpStorm/bin/webide.png
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

//貌似可以了哦 ，不错不错，这种正常输入中文的方式挺好的。
navicate:
```sh
sudo gedit /usr/share/applications/navicate.desktop
```
输入以下内容：
```sh
[Desktop Entry]
Encoding=UTF-8
Name=navicate
Comment=navicate tool
Exec=/opt/navicat112_mysql_cs_x64/start_navicat
Icon=/opt/navicat112_mysql_cs_x64/navicate.png
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

wechat
```sh
sudo gedit /usr/share/applications/wechat.desktop
```
输入以下内容：
```sh
[Desktop Entry]
Encoding=UTF-8
Name=wechat
Comment=electronic-wechat
Exec=/opt/electronic-wechat-linux-x64/electronic-wechat
Icon=/opt/electronic-wechat-linux-x64/wechat.png
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

filezilla
```sh
sudo gedit /usr/share/applications/filezilla.desktop
```
输入以下内容：
```sh
[Desktop Entry]
Name=FileZilla
GenericName=FTP client
GenericName[de]=FTP-Client
GenericName[fr]=Client FTP
Comment=Download and upload files via FTP, FTPS and SFTP
Comment[de]=Dateien über FTP, FTPS und SFTP übertragen
Comment[fr]=Transférer des fichiers via FTP, FTPS et SFTP
Exec=/opt/FileZilla3/bin/filezilla
Terminal=false
Icon=/opt/FileZilla3/share/pixmaps/filezilla.png
Type=Application
Categories=Network;FileTransfer;
Version=1.0
```

###关于ubuntu 16.04 LTS下navicate的界面中文乱码问题：
解压navicate软件包，打开start_navicate文件，
```sh
//找到
export LANG="en_US.UTF-8"
//修改成
export LANG="zh_CN.UTF-8"
```
然后再次打开程序，中文就会正常显示。


###清理不必要的文件：
```sh
//使用如下命令查找安装列表
sudo dpkg -l mysql*
sudo dpkg -l
//然后使用如下命令一个一个删除，不能使用通配符
sudo dpkg --purge mysql-client-core-5.7
//最后自动清理
sudo apt-get autoremove
```


###dpkg卸载软件步骤：
1、查看dpkg的帮助。
选择 dpkg -l来查看软件的状态。
选择 dpkg -P来卸载软件。因为dpkg --remove只是删除安装的文件，但不删除配置文件。而dpkg --purge则安装文件和配置文件都删除。
2、先列举出libreoffice相关的软件，看哪些是已经安装的。命令为: dpkg -l libreoffice*
3、其中，un, ii, rc等是Desired和Status
Desired=Unknown/Install/Remove/Purge/Hold
Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
ii就是已经安装的软件, rc则表示已经被删除，但配置文件还存在。
4、选择libreoffice-base-core包来演示卸载
5、使用命令dpkg -P libreoffice-base-core进行卸载，如图。


###upgrade
update
```sh
sudo apt-get update && sudo apt-get upgrade
```

version update
```sh
sudo update-manager  -c  -d 
```

###win10 ubuntu16.04 双系统 时间不一致问题解决办法
```sh
//先在ubuntu下更新一下时间，确保时间无误：
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
//然后将时间更新到硬件上：
sudo hwclock --localtime --systohc
//重新进入windows10，发现时间恢复正常了！
reboot
```