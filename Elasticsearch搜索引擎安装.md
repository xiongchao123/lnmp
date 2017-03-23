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
#运行帮助
/usr/local/elasticsearch-5.2.2/bin/elasticsearch --help
#运行
/usr/local/elasticsearch-5.2.2/bin/elasticsearch
#守护进程在后台运行
/usr/local/elasticsearch-5.2.2/bin/elasticsearch -Ecluster.name=my_cluster_name -Enode.name=my_node_name -d
#关闭
ps -ef | grep elastic
#杀掉进程：
kill -9 进程号
#启动 
/usr/local/elasticsearch-5.2.2/bin/elasticsearch -Ecluster.name=zjh -Enode.name=zjhNode -d
```

然后浏览器中访问`http://localhost:9200/?pretty`看是否正常显示

###安装 Kibana
Sense 是一个 Kibana 应用 它提供交互式的控制台，通过你的浏览器直接向 Elasticsearch 提交请求。
1、下载（https://www.elastic.co/downloads/kibana）
```sh
tar zxvf kibana-5.2.2-linux-x86_64.tar.gz
sudo mv kibana-5.2.2-linux-x86_64/ /usr/local/
```
2、在 Kibana 目录下运行下面的命令，下载并安装 Sense app
```sh
#查看使用方法
/usr/local/kibana-5.2.2-linux-x86_64/bin/kibana-plugin --help

/usr/local/kibana-5.2.2-linux-x86_64/bin/kibana-plugin install elastic/sense
#Windows上面执行
bin\kibana.bat plugin --install elastic/sense
```
3、启动 Kibana.
```sh
/usr/local/kibana-5.2.2-linux-x86_64/bin/kibana
```
4、在你的浏览器中打开 Sense：`http://localhost:5601/app/sense`