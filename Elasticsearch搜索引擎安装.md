#Elasticsearch搜索引擎安装

###Elasticsearch 与 Solr 的比较总结
http://www.cnblogs.com/chowmin/articles/4629220.html
Solr 是传统搜索应用的有力解决方案，但 Elasticsearch 更适用于新兴的实时搜索应用。

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
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.2.tar.gz
#或
sudo curl -L https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.2.tar.gz -o elasticsearch-5.2.2.tar.gz
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
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.2.2-linux-x86_64.tar.gz
sudo curl -L https://artifacts.elastic.co/downloads/kibana/kibana-5.2.2-linux-x86_64.tar.gz -o kibana-5.2.2-linux-x86_64.tar.gz
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
4、在你的浏览器中打开 Sense：`http://localhost:5601`

###中文分词
github地址：https://github.com/medcl/elasticsearch-analysis-ik
去下面链接下载对应版本，否则会出错：
https://github.com/medcl/elasticsearch-analysis-ik/releases

####mvn打包(手动安装方式)，在此无需手动安装，直接下载打包好的文件即可。
mvn package


```sh
#下载
git clone https://github.com/medcl/elasticsearch-analysis-ik.git
#或
sudo curl -L https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.2.2/elasticsearch-analysis-ik-5.2.2.zip -o elasticsearch-analysis-ik.zip
#或(推荐)
sudo wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.2.2/elasticsearch-analysis-ik-5.2.2.zip -O elasticsearch-analysis-ik.zip

#解压到指定目录
unzip elasticsearch-analysis-ik-5.2.2.zip -d /usr/local/elasticsearch-5.2.2/plugins/ik
cd /usr/local/elasticsearch-5.2.2/plugins/ik/
#查找进程号
ps -ef | grep elastic
#杀掉进程：
kill -9 进程号
#启动 
/usr/local/elasticsearch-5.2.2/bin/elasticsearch -Ecluster.name=zjh -Enode.name=zjhNode -d
```

###pinyin分词器
```sh
sudo wget https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v5.2.2/elasticsearch-analysis-pinyin-5.2.2.zip -o elasticsearch-analysis-ik.zip
unzip elasticsearch-analysis-pinyin-5.2.2.zip -d /usr/local/elasticsearch-5.2.2/plugins/pinyin
cd /usr/local/elasticsearch-5.2.2/plugins/pinyin/
```

###IK+pinyin分词配置 5.1创建索引与分析器设置
创建索引
```sh
#创建索引
curl -XPUT http://localhost:9200/my_index
#删除索引:
curl -XDELETE http://localhost:9200/my_index
#删除多个索引
curl -XDELETE http://localhost:9200/index_one,index_two
curl -XDELETE http://localhost:9200/index_*
#删除全部索引
curl -XDELETE http://localhost:9200/_all
curl -XDELETE http://localhost:9200/*
```

####1、创建一个索引，并设置index分析器相关属性:
```sh
curl -XPUT http://localhost:9200/my_index -d'
{
    "index" : {
        "analysis" : {
            "analyzer" : {
                "ik_pinyin_analyzer" : {
                    "type":"custom",
                    "tokenizer" : "ik_smart",
                    "filter":["my_pinyin","word_delimiter"]
                }
            },
            "filter":{
                "my_pinyin":{
                    "type" : "pinyin",
                    "first_letter" : "prefix",
                    "padding_char" : " "
                }
            }
        }
    }
}'
```
2、mapping 配置:
```sh
curl -XPUT http://localhost:9200/my_index/folks/_mapping -d'
{
    "folks": {
        "properties":{
            "name":{
                "type":"keyword",
                "fields":{
                    "pinyin":{
                        "type":"text",
                        "store":"no",
                        "term_vector":"with_positions_offsets",
                        "analyzer":"ik_pinyin_analyzer",
                        "boost":10
                    }
                }
            }
        }
    }
}'
```

测试(1)拼音分词：
```sh
#文档一
curl -XPOST http://localhost:9200/my_index/folks/andy -d '{"name":"刘德华"}'
#文档二
curl -XPOST http://localhost:9200/my_index/folks/tina -d '{"name":"中华人民共和国国歌"}'

#测试
curl -XPOST "http://localhost:9200/my_index/folks/_search?q=name.pinyin:liu"
curl -XPOST "http://localhost:9200/my_index/folks/_search?q=name.pinyin:de"
curl -XPOST "http://localhost:9200/my_index/folks/_search?q=name.pinyin:hua"
curl -XPOST "http://localhost:9200/my_index/folks/_search?q=name.pinyin:ldh"
```

测试(2)IK分词测试：
```sh
#test1
curl -XPOST "http://localhost:9200/my_index/folks/_search?pretty" -d'
{
    "query":{
        "match":{
            "name.pinyin":"国歌"
        }
    },
    "highlight":{
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "name.pinyin" : {}
        }
    }
}'
#test2
curl -XPOST "http://localhost:9200/my_index/folks/_search?pretty" -d'
{
    "query":{
        "match":{
            "name.pinyin":"zhonghua"
        }
    },
    "highlight":{
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "name.pinyin" : {}
        }
    }
}'
```



###访问客户端
列表：
https://www.elastic.co/guide/en/elasticsearch/client/community/current/index.html
PHP:
https://www.elastic.co/guide/en/elasticsearch/client/php-api/current/index.html
github地址：
https://github.com/elastic/elasticsearch-php