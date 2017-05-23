###快捷键：
PhPStorm 是 JetBrains 公司开发的一款商业的 PHP 集成开发工具，PhpStorm可随时帮助用户对其编码进行调整，运行单元测试或者提供可视化debug功能。Phpstrom的一款名为Magicento的插件对快速创建Magento插件十分有用。

ctrl+tab:         switcher,在已打开文件之间或者工具窗口间切换
alt+alt:          连续两次快速按下alt键不放，显示tool windows（project,database ...)
ctrl+k:           快速调用 commit changes 对话框
alt+F3:           显示搜索窗格，对当前文件进行搜索，然后配合ctrl+alt+r,可以进行替换操作
ctrl+shift+f:     find in path 在指定文件夹或者整个project内搜索，ctrl+shift+r进行替换操作
ctrl+shift+alt+t: 快速rename，里面有好几个选项，慢慢理解吧
shift+F6:         rename，自动重命名该变量所有被调用的地方
ctrl+shift+n:     快速导航到指定文件，弹出一个dialog，输入文件名即可
ctrl+shift+i:     快速查找选中内容定义的位置 quick definition viewer
ctrl+n:           快速打开任意类，弹出一个对话框，输入类名称，跳转到类文件
ctrl+shift+alt+n: 快速打开指定的method，field.弹出一个对话框，输入标识符，选择后跳转到指定内容
alt+F7:           查找选定变量，方法被调用的地方。选中一个方法或者变量，查找出所有调用的地方
ctrl+F12:         弹出一个对话框，显示当前文件里的所有方法，变量，直接输入方法变量名，回车即可跳转到定义位置
alt+F1:           快速打开当前编辑文件在其他tool windows里，这个很好用的键盘
ese:              退出tool windows，焦点返回到编辑器里
shift+esc:        退出并隐藏tool windows,焦点返回编辑器里
F12:              光标从编辑器里移动到最后一个关闭的tool windows里
ctrl+alt+d:       快速复制多行，哈哈，这个vim里更加简单
ctrl+shift+p:     显示函数方法的参数列表
ctrl+shift+backspace: last edit location
ctrl+shift+F7:    在当前文件高亮选定的标识符，esc退出高亮，f3,shift f3向下向上导航高亮标识符
ctrl+shift+alt+e: exploer最近打开的文件
alt+方向键：      左右在打开的编辑器标签间切换，上下在打开的文件中的方法里上下切换
alt+shift+c:      浏览最近的修改历史
ctrl+`:           选择主题，不常用


###http://www.cr173.com/html/66775_1.html
http://www.cr173.com/html/66775_1.html

###破解方法：
http://idea.lanyus.com/
下载地址：http://us.idea.lanyus.com/jar/JetbrainsCrack-2.6.2.jar
将JetbrainsCrack-2.6.2.jar放到phpstorm安装目录下的lib文件夹
找到phpstorm 的安装路径, 在\bin目录下有两个文件 sudo gedit phpstorm.vmoptions 
打开文件
最后面加入 一行
```sh
-javaagent:/opt/PhpStorm/lib/JetbrainsCrack-2.6.2.jar
```
后面是补丁的路径,根据自己放的位置修改
保存文件
关闭并重新打开phpstorm
到网站生成一个激活码,userName可以改:
http://idea.lanyus.com/getkey?userName=qianxun
code
```sh
CNEKJPQZEX-eyJsaWNlbnNlSWQiOiJDTkVLSlBRWkVYIiwibGljZW5zZWVOYW1lIjoibGFuIHl1IiwiYXNzaWduZWVOYW1lIjoiIiwiYXNzaWduZWVFbWFpbCI6IiIsImxpY2Vuc2VSZXN0cmljdGlvbiI6IkZvciBlZHVjYXRpb25hbCB1c2Ugb25seSIsImNoZWNrQ29uY3VycmVudFVzZSI6ZmFsc2UsInByb2R1Y3RzIjpbeyJjb2RlIjoiQUMiLCJwYWlkVXBUbyI6IjIwMTgtMDEtMzAifSx7ImNvZGUiOiJETSIsInBhaWRVcFRvIjoiMjAxOC0wMS0zMCJ9LHsiY29kZSI6IklJIiwicGFpZFVwVG8iOiIyMDE4LTAxLTMwIn0seyJjb2RlIjoiUlMwIiwicGFpZFVwVG8iOiIyMDE4LTAxLTMwIn0seyJjb2RlIjoiV1MiLCJwYWlkVXBUbyI6IjIwMTgtMDEtMzAifSx7ImNvZGUiOiJEUE4iLCJwYWlkVXBUbyI6IjIwMTgtMDEtMzAifSx7ImNvZGUiOiJSQyIsInBhaWRVcFRvIjoiMjAxOC0wMS0zMCJ9LHsiY29kZSI6IlBTIiwicGFpZFVwVG8iOiIyMDE4LTAxLTMwIn0seyJjb2RlIjoiREMiLCJwYWlkVXBUbyI6IjIwMTgtMDEtMzAifSx7ImNvZGUiOiJEQiIsInBhaWRVcFRvIjoiMjAxOC0wMS0zMCJ9LHsiY29kZSI6IlJNIiwicGFpZFVwVG8iOiIyMDE4LTAxLTMwIn0seyJjb2RlIjoiUEMiLCJwYWlkVXBUbyI6IjIwMTgtMDEtMzAifSx7ImNvZGUiOiJDTCIsInBhaWRVcFRvIjoiMjAxOC0wMS0zMCJ9XSwiaGFzaCI6IjUxOTU1OTMvMCIsImdyYWNlUGVyaW9kRGF5cyI6MCwiYXV0b1Byb2xvbmdhdGVkIjpmYWxzZSwiaXNBdXRvUHJvbG9uZ2F0ZWQiOmZhbHNlfQ==-QOxwjWvRwJz6vo6J6adC3CJ4ukQHosbPYZ94URUVFna/Rbew8xK/M5gP3kAaPh6ZDveFdtMR1UBoumq3eCwXtXM3U3ls5noB4LIr+QplVlCj2pK5uNq7g/feyNyQcHpSXtvhIOnXDBLOecB05DOsxzm0p7ulGGJoAInmHeb9mc0eYjqc4RPpUQfh6HSYBnvEnKMlLF5bz4KEtzmsvvgA55CwzwQ3gRitm5Q/wUT7AQCBdjmBfNUjKVQL6TSjSDPp56FUdEs4Aab8LqstA2DIMbxocO64rvytmcUeIwu8Mi5uq87KQP5AQMSMYb59Inbd+dmVfx5cJo3fRS4/5s3/Hg==-MIIEPjCCAiagAwIBAgIBBTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBMB4XDTE1MTEwMjA4MjE0OFoXDTE4MTEwMTA4MjE0OFowETEPMA0GA1UEAwwGcHJvZDN5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxcQkq+zdxlR2mmRYBPzGbUNdMN6OaXiXzxIWtMEkrJMO/5oUfQJbLLuMSMK0QHFmaI37WShyxZcfRCidwXjot4zmNBKnlyHodDij/78TmVqFl8nOeD5+07B8VEaIu7c3E1N+e1doC6wht4I4+IEmtsPAdoaj5WCQVQbrI8KeT8M9VcBIWX7fD0fhexfg3ZRt0xqwMcXGNp3DdJHiO0rCdU+Itv7EmtnSVq9jBG1usMSFvMowR25mju2JcPFp1+I4ZI+FqgR8gyG8oiNDyNEoAbsR3lOpI7grUYSvkB/xVy/VoklPCK2h0f0GJxFjnye8NT1PAywoyl7RmiAVRE/EKwIDAQABo4GZMIGWMAkGA1UdEwQCMAAwHQYDVR0OBBYEFGEpG9oZGcfLMGNBkY7SgHiMGgTcMEgGA1UdIwRBMD+AFKOetkhnQhI2Qb1t4Lm0oFKLl/GzoRykGjAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBggkA0myxg7KDeeEwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMA0GCSqGSIb3DQEBCwUAA4ICAQC9WZuYgQedSuOc5TOUSrRigMw4/+wuC5EtZBfvdl4HT/8vzMW/oUlIP4YCvA0XKyBaCJ2iX+ZCDKoPfiYXiaSiH+HxAPV6J79vvouxKrWg2XV6ShFtPLP+0gPdGq3x9R3+kJbmAm8w+FOdlWqAfJrLvpzMGNeDU14YGXiZ9bVzmIQbwrBA+c/F4tlK/DV07dsNExihqFoibnqDiVNTGombaU2dDup2gwKdL81ua8EIcGNExHe82kjF4zwfadHk3bQVvbfdAwxcDy4xBjs3L4raPLU3yenSzr/OEur1+jfOxnQSmEcMXKXgrAQ9U55gwjcOFKrgOxEdek/Sk1VfOjvS+nuM4eyEruFMfaZHzoQiuw4IqgGc45ohFH0UUyjYcuFxxDSU9lMCv8qdHKm+wnPRb0l9l5vXsCBDuhAGYD6ss+Ga+aDY6f/qXZuUCEUOH3QUNbbCUlviSz6+GiRnt1kA9N2Qachl+2yBfaqUqr8h7Z2gsx5LcIf5kYNsqJ0GavXTVyWh7PYiKX4bs354ZQLUwwa/cG++2+wNWP+HtBhVxMRNTdVhSm38AknZlD+PTAsWGu9GyLmhti2EnVwGybSD2Dxmhxk3IPCkhKAK+pl0eWYGZWG3tJ9mZ7SowcXLWDFAk0lRJnKGFMTggrWjV8GYpw5bq23VmIqqDLgkNzuoog==
```
然后激活

php-cs-fixer插件安装方法：
http://tzfrs.de/2015/01/automatically-format-code-to-match-psr-standards-with-phpstorm/