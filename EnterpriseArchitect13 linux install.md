###Linux下如何安装Enterprise Architect
使用Wine安装Enterprise Architect

1、通过运行这些命令来安装Wine和Winetricks。如果apt-get抱怨丢失依赖关系，请安装它们，然后重复更新并安装命令。

```sh
sudo dpkg --add-architecture i386
sudo add-apt-repository ppa:wine/wine-builds
sudo apt-get update
sudo apt-get install --install-recommends winehq-devel
sudo apt-get install winetricks
```
2、我们建议您安装Carlito字体，以使图表中的文本与本机Windows安装中的相同。这也可以防止图表不必要地调整大小。发出此命令安装Carlito字体：

```sh
sudo apt-get install fonts-crosextra-carlito
```

3、通过运行以下命令安装MSXML和MDAC组件：
```sh
winetricks msxml3
winetricks msxml4
winetricks mdac28
```

4、下载最新的Enterprise Architect安装程序：
http://sparxsystems.com/products/ea/trial.html

5、通过运行以下命令来安装Enterprise Architect：这些命令分别与注册和试用安装相关：

```sh
wine msiexec /i easetupfull.msi
wine msiexec /i easetup.msi
```