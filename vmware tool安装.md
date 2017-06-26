[CentOS 7] VMware-tools安裝
在VMware Workstation裡面, 按照以前的方法安裝vmware-tools的時候, 會遇到兩個問題:

首先提醒一下, 記得先裝下面這些套件:
```sh
$ yum install gcc make perl fuse fuse-libs kernel-devel open-vm-tools -y
```
1. 如果用了最小安裝, vmware-tools installer會找不到ifconfig這個指令.
這是因為CentOS 7把ifconfig設為deprecated (等待淘汰), 改用ip這個指令做IP管理.
CentOS 7網路設定的事情另一篇文章再來講, 我們先解決vmware-tools的問題.
ifconfig這東西可以在net-tools套件找到.
所以在沒有網路的情形下, 可以從安裝媒體裡面找, 或是直接:
```sh
$ yum install net-tools -y
```

编译安装
```sh
$ mkdir /mnt/cdrom/
$ mount /dev/cdrom /mnt/cdrom
$ cp /mnt/cdrom/VMwareTools-10.1.6-5214329.tar.gz ~/
$ umount /dev/cdrom
$ cd ~/
$ tar zxvf VMwareTools-10.1.6-5214329.tar.gz
$ cd vmware-tools-distrib/
$ ./vmware-install.pl -d
```