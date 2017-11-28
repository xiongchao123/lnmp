###git use 

####长期存储密码：
```sh
git config --global credential.helper store
```

##git 命令使用技巧
###1.如果使用htts协议，需要执行初始化命令,并保存账号密码
```sh
//保存账号密码 
git config --global credential.helper store 
//取消ssl验证 
git config --global http.sslVerify false 
//忽略文件夹权限 
git config core.filemode false
```

###2.切换到本地没有而远程服务器有的分支：
```sh
git fetch --all
git checkout -f branch_name
```

###3.代码回滚
```sh
git reset --hard the_commit_id --回滚到某commit_id的版本
```

###4.放弃所有本地修改，跟远程服务器保持一致
```sh
git reset --hard origin/branch_name
```

###5.查看所有分支
```sh
git branch -a
```

###6.查看代码仓库地址
```sh
git remote -v
```

###7.修改远程仓库地址
```sh
git remote set-url origin remote_url
```

###8.查看历史commit信息
```sh
git log
git log --stat #显示近几次提交更新文件的内容。（可显示最近提交人）
git log --pretty=oneline --stat #仅仅显示最近提交更新的内容（不显示最近提交人）
```

###9.创建新的分支
```sh
git branch branch_name
```

###10.从一个分支推送到另外一个分支
```sh
git push origin branch_name_a:branch_name_b
```

###删除分支
```
git branch -d <branchName>
git push origin --delete <branchName>
git push origin --delete tag <tagname>
```

###SSH Key
http://git.oschina.net/oschina/git-osc/wikis/%E5%B8%AE%E5%8A%A9#ssh-keys
http://www.ithao123.cn/content-1584888.html

###git切换远程分支
git HTTPS和SSH方式的区别和使用:http://www.ithao123.cn/content-1584888.html

```sh
git remote rm origin
git remote add origin "git@git.oschina.net:zhaojianhui/lnmp.git"
git push origin master
```

###git一个项目设置多个远程仓库
1.使用git remote
```sh
git remote add origin https://git.coding.net/lixiaohao/phaser-flappybird.git
```
2.修改.git/config配置文件
```sh
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
[remote "origin"]
        url = git@git.coding.net:lixiaohao/phaser-flappybird.git
        url = git@github.com:lh4111/phaser-flappybird.git
        #在这里添加一行 url = xxx 即可
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
```

###改写历史，去除大文件
```sh
git filter-branch --tree-filter 'rm -f path/to/large/files' --tag-name-filter cat -- --all
git push origin --tags --force
git push origin --all --force
```


##git如何删除远程仓库某次错误提交
reset命令有3种方式
```sh
git reset --mixed
此为默认方式，不带任何参数的git reset，就是这种方式，它回退到某个版本，只保留源码，回退commit和stage信息
 
git reset --soft
回退到某个版本， 只回退了commit的信息，不会恢复stage（如果还要提交，直接commit即可)
 
git reset --hard
彻底回退到某个版本， 本地的源码也会变为上一个版本的内容
```

整体思路分四步:

1)打新的分支备份

2)git reset --hard 版本号，本地回退到指定版本

3)在本地把远程的branch_name分支删除

4)再把reset后的分支内容给push上去

```sh
1）新建backup_branch_name分支 作为备份，以防万一[备份]
git branch backup_branch_name
将本地的backup_branch_name备份分支推送到远程[备份]
git push origin backup_branch_name
 
2）删除远程的branch_name分支 (注意branch_name前有个:)
git push origin :branch_name
3）本地仓库　彻底回退到某一个版本
git reset --hard 版本号
 
4）恢复远程仓库
git push origin branch_name

```

技巧：
删除远程分支(删除之前一定得备份)
git push origin  :branch_name