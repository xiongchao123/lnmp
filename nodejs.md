#node.js相关


###apt-get安装
```sh
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```

###编译安装
https://www.oschina.net/question/54100_28161

###源码安装
```sh
tar -xJf ./node-v7.7.4-linux-x64.tar.xz
sudo mv node-v7.7.4-linux-x64/ /usr/local/
#使用命令 sudo gedit /etc/profile 打开配置文件，在文件最后中添加如下两行：
#nodejs
export PATH="/usr/local/node-v7.7.4-linux-x64/bin:$PATH"
export NODE_PATH="/usr/local/node-v7.7.4-linux-x64/lib/node_modules"
##重启机器或
source /etc/profile
```

###设置 npm 使用淘宝源
在 `~/.bashrc` 中添加（请先备份 `cp ~/.bashrc ~/.bashrc.bak`）
```sh
cp ~/.bashrc ~/.bashrc.bak
# nodejs
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"
#使修改立即生效，输入，回车 
source ~/.bashrc

```


###使用淘宝镜像安装 npm 包
终端输入 
cnpm install [name]

###附录A - npm命令
全局安装
npm install -g 软件包名
全局安装的路径可以通过下面的命令查看
npm config get prefix
全局安装的路径可以通过下面的命令修改
npm config set prefix "目录"
局部安装（将模块下载到当前命令行所在目录），不推荐
npm install 软件包名