#Elasticsearch搜索引擎安装

###Java安装
```sh
sudo mkdir -p /usr/java
sudo mv jre-8u121-linux-x64.tar.gz /usr/java/
cd /usr/java/
sudo tar zxvf jre-8u121-linux-x64.tar.gz 
pwd
sudo vi /etc/profile
sudo gedit /etc/profile
#-------------
JAVA_HOME=/usr/java/jdk1.8.0_121
CLASSPATH=$JAVA_HOME/lib/
PATH=$PATH:$JAVA_HOME/bin
export PATH JAVA_HOME CLASSPATH
#-------------
##重启机器或
source /etc/profile
#保存后，使用如下命令来进一步安装这个jre
sudo update-alternatives --install /usr/bin/java java /usr/java/jre1.8.0_121/bin/java 300
#这样就安装好这个jre了，然而可能系统中有多个jre，那么系统究竟判断用那一个来作为默认的jre呢，就需要使用如下的命令来配置：
sudo update-alternatives --config java
java -version
```

###elasticsearch安装
```sh
tar -xvf elasticsearch-5.2.2.tar.gz
sudo mv elasticsearch-5.2.2 /usr/local/
cd /usr/local/elasticsearch-5.2.2/bin/
./elasticsearch
```