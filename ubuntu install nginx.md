##ubunut install nginx

###1. 从Nginx官网下载二进制安装包
###2.解压
```
sudo wget http://nginx.org/download/nginx-1.13.6.tar.gz -O /data/software/nginx-1.13.6.tar.gz
cd /data/software/
sudo tar zxvf nginx-1.13.6.tar.gz   
cd nginx-1.13.6/
```
###3.编译并安装Nginx
```sh
sudo groupadd www
sudo useradd -g www www
sudo apt-get install libpcre3 libpcre3-dev openssl libssl-dev
sudo ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-http_gzip_static_module
sudo make && sudo make install
```
###4.启动Nginx
Nginx默认安装路径是/usr/local/nginx， 启动Nginx:
```sh
sudo /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```
###5.验证安装
浏览器输入:http://localhost/

###6.配置php
```sh
sudo cp -r /home/qianxun/website/lnmp/nginx/vhosts/ /usr/local/nginx/conf/
sudo gedit /usr/local/nginx/conf/nginx.conf

##input and replace
#include vhosts conf file, server setting
include ./vhosts/*.conf;
```
###7.
```sh
/usr/local/nginx/sbin/nginx -h
sudo /usr/local/nginx/sbin/nginx
sudo /usr/local/nginx/sbin/nginx -s stop
sudo /usr/local/nginx/sbin/nginx -s quit
sudo /usr/local/nginx/sbin/nginx -s reopen
sudo /usr/local/nginx/sbin/nginx -s reload
```