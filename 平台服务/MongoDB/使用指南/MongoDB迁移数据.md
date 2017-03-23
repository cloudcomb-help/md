# 迁移数据

使用 MongoDB 自带的 mongodump 和 mongorestore 迁移数据

<span>Attention:</span><div class="alertContent">请使用 MongoDB 3.0 及以上版本的 mongodump 和 mongorestore 工具。
</div>


## 源实例导出数据

使用相应权限的账号连接源实例，执行 `mongodump -h <域名/IP>:<端口> -u <用户名> -p <密码> -d <数据库> -o <期望文件路径> ` 将源实例的内容导出。例如，执行以下语句导出数据库，默认生成文件名为 mongodump-20170323 的备份文件。

	mongodump -h 192.168.0.163:27017 -u root -p passwd --authenticationDatabase admin -d testdb -o /data/mongodump-20170323

关于该命令的详细说明请参见： [mongodump 命令官方文档](https://docs.mongodb.org/manual/reference/program/mongodump/) 。


## 数据导入蜂巢 MongoDB 

根据上一步导的备份文件，执行 `mongorestore -h <域名/IP>:<端口> -u <用户名> -p <密码> --dir <备份文件路径>` 命令将数据全部导入蜂巢 MongoDB。例如，执行以下语句将数据库全部导入。

	mongorestore -h 10.173.33.33:27017 -u root -p passwd --authenticationDatabase admin --dir /data/mongodump-20170323

关于该命令的详细说明请参见： [mongorestore 命令官方文档](https://docs.mongodb.com/manual/reference/program/mongorestore/) 。





