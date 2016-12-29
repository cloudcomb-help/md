### 如何访问蜂巢MongoDB
MongoDB实例目前为私网实例，需要先连上 VPN 后才能进行访问。操作指南请参见[如何使用VPN](http://support.c.163.com/md.html#!容器服务/服务管理/使用技巧/如何使用蜂巢 OpenVPN.md)

连接命令举例:

    mongo IP:27017/admin -u admin -p 密码

### 如何将外部实例数据导入到蜂巢数据库实例中？

可以使用工具mongodump导出mongodb数据库，用mongorestore导入到蜂巢MongoDB实例中。
数据库导入、导出命令举例:

    mongodump -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件存在路径 
    
    mongorestore -h IP --port 27017 -u 'admin' -p '密码' --authenticationDatabase admin -d 数据库名 --drop 导出数据库路径