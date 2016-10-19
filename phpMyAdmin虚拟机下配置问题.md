在虚拟机下，使用phpMyAdmin时，权限过大，导致出现：配置文件权限错误，不应任何用户都能修改！错误，

其中一种方法是通过修改文件夹权限解决：
```sh
chmod -R 755 phpmyadmin
```
(ubuntu)
```sh
$sudo chmod -R 755 phpmyadin
```
另外一种方法是通过修改phpmyadmin的配置文件解决：
在根目录下的config.inc.php文件下加入一下配置项，此方法不建议，但虚拟机无法更改宿主机上的文件权限，可使用此方法：
$cfg['CheckConfigurationPermissions'] = false;