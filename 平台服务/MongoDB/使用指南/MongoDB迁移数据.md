# 迁移数据

使用 MongoDB 自带的 mongodump 和 mongorestore 迁移数据

<span>Attention:</span><div class="alertContent">请使用 MongoDB 3.0 及以上版本的 mongodump 和 mongorestore 工具。
</div>


## 源实例迁出数据

使用相应权限的账号连接源实例，执行 `mongodump -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件存在路径 ` 将源实例的内容导出。例如，执行以下语句导出所有数据库，默认生成文件名为 dump 的备份文件。

	mongodump --host xxx:27017 --authenticationDatabase  admin -u xxx -p xxx

详细参考请见 [mongodump 命令官方文档](https://docs.mongodb.org/manual/reference/program/mongodump/)。


## 数据导入蜂巢 MongoDB 

根据上一步导出生成的备份文件，执行 `mongorestore -h IP --port 27017 -u 'admin' -p '密码' --authenticationDatabase admin -d 数据库名 --drop 导出数据库路径` 命令将数据全部导入蜂巢 MongoDB。例如，执行以下语句将数据库全部导入。

	mongorestore --host mongodb1.example.net --port 37017 --username user --password pass /opt/backup/mongodump-2011-10-24

    mongorestore --host dds-xxx:3717 --authenticationDatabase  admin -u root -p xxx dump

详细参考请见 [mongostore 命令官方文档](https://docs.mongodb.com/manual/reference/program/mongorestore/)。


关于该命令的详细说明请参见：[mongo 命令官方文档](https://docs.mongodb.com/manual/reference/program/mongo/) 。


