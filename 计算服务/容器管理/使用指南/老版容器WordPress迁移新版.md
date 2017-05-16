# 老版容器WordPress迁移新版 #

## 老版容器数据及数据库备份 ##

### SSH登录老版容器 ###

参照 [如何使用 SSH 密钥登录](http://support.c.163.com/md.html#!计算服务/容器服务/使用技巧/如何使用 SSH 密钥登录.md)

### 数据备份 ###
1.打包默认数据目录/var的www文件夹

    root@wordpresslaoban-952717-6065c26f-9x7p1:/var# pwd 	
    /var 
    root@wordpresslaoban-952717-6065c26f-9x7p1:/var# ls  
    backups  cache  lib  local  lock  log  mail  opt  run  spool  tmp  www   
	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# tar cvf www.tar www
	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# ls                                                  
	backups  cache  lib  local  lock  log  mail  opt  run  spool  tmp  www  www.tar 

2.导出备份数据至本地（以Xshell5为例备份至winPC）
   	
    root@wordpresslaoban-952717-6065c26f-9x7p1:/var# apt-get update       
    root@wordpresslaoban-952717-6065c26f-9x7p1:/var# apt-get install -y lrzsz	#安装lrzsz
	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# sz www.tar	#在弹出窗口选择备份www.tar的winPC路径

### 数据库备份 ###
1.备份数据库

	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# mysqldump -uroot -p wordpress > wordpress.sql
	Enter password: 
	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp  wordpress.sql  www  www.tar
	root@wordpresslaoban-952717-6065c26f-9x7p1:/var# sz wordpress.sql	#在弹出窗口选择备份wordpress.sql的winPC路径


## 新版容器数据及数据库导入 ##
### 创建新版容器 ###
参照 [创建有状态服务](http://support.c.163.com/md.html#!计算服务/容器服务/使用指南/创建有状态服务.md)，在选择镜像时选择WordPress镜像。

### 数据导入 ###
1.删除新版容器原有/var下的www文件夹

	root@test-64015:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp  www
	root@test-64015:/var# rm www -rf
	root@test-64015:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp

2.导入备份数据www.tar至默认路径/var（以Xshell5为例从winPC导入）

	root@test-64015:/var# rz	#在弹出的窗口选择导入数据的路径www.tar
	root@test-64015:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp  www.tar

3.解压为/var下的www文件夹

	root@test-64015:/var# tar xvf www.tar www
	root@test-64015:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp  www	www.tar


### 数据库导入 ###
1.删除新版容器原有wordpress数据库

	root@test-64015:/var# mysql -uroot -p 
	Enter password: 
	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| wordpress          |
	+--------------------+
	4 rows in set (0.00 sec)
	mysql> drop database wordpress;
	Query OK, 12 rows affected (0.05 sec)

	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	+--------------------+
	3 rows in set (0.00 sec)

2.新建空wordpress数据库供还原wordpress.sql

	mysql> create database wordpress;
	Query OK, 1 row affected (0.00 sec)
	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| wordpress          |
	+--------------------+
	4 rows in set (0.00 sec)
	mysql> exit
	Bye
	root@test-64015:/var# 

3.导入老版备份数据库wordpress.sql并还原

	root@test-64015:/var# rz
	root@test-64015:/var# ls
	backups  cache	lib  local  lock  log  mail  opt  run  spool  tmp  wordpress.sql  www  www.tar
	root@test-64015:/var# mysql -uroot -p wordpress < wordpress.sql 

## 业务恢复检查 ##
登录WordPress验证业务