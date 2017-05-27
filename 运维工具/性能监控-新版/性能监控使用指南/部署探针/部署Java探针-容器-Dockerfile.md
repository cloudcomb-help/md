# 通过 Dockerfile 部署 Java 探针 

通过部署探针，即可实现业务的全链路跟踪和异常捕获。

* **适用版本：**Tomcat7 及其以上版本、JDK 1.6 及其以上版本部署的 Java 服务
* **可监控协议：**HTTP、Redis、Memcached、DB、RabbitMQ、Dubbo
* **支持部署方式：**
	* [直接在蜂巢容器中部署探针](../md.html#!运维工具/性能监控-新版/性能监控使用指南/部署探针/部署Java探针.md)
		**使用场景：**在蜂巢已有运行中的容器，希望直接在容器中部署探针
	* [通过 Dockerfile 部署探针](../md.html#!运维工具/性能监控-新版/性能监控使用指南/部署探针/部署Java探针-容器-Dockerfile.md)
		**使用场景：**代码已经上传到代码托管服务，并且项目中包含 Dockerfile 文件用于构建镜像，希望通过 Dockerfile 方部署探针。 
	* [在任意主机中部署探针](../md.html#!运维工具/性能监控-新版/性能监控使用指南/部署探针/部署Java探针-主机.md)
		**使用场景：**在任意主机（包括但不限于蜂巢）上直接部署探针

## 操作步骤

### 1. 在项目 Dockerfile 中增加探针安装内容

	...
	# 请确保安装了 wget 和 tar
	wget -P /root/java/ http://nos.netease.com/agent/napm-java-agent.tar.gz  
	tar zxvf /root/java/napm-java-agent.tar.gz
	...

### 2. 修改启动脚本

建议将启动脚本复制一份放到项目中（或放到桶里），修改启动脚本，添加如下启动参数：

	-java-agent:<user_agent_dir>/napm-java-rewriter.jar

### 3. Dockerfile 中 ADD 脚本

	...
	ADD catalina.sh /root/tomcat8/bin/
	...

### 4. 构建镜像

* 在蜂巢镜像仓库，通过 [代码构建镜像](http://support.c.163.com/md.html#!计算服务/镜像仓库/使用指南/创建自定义镜像.md)；
* 或在本地构建镜像后，[推送到蜂巢镜像仓库](http://support.c.163.com/md.html#!计算服务/镜像仓库/使用指南/推送本地镜像.md)。

### 5. 启用新镜像

无状态服务支持直接更改镜像版本；有状态服务需要使用保存的镜像重新创建服务。
服务启动后，在 [应用监控模块](https://c.163.com/dashboard#/m/apm/) 可以看到全链路数据展示的变化：

![](../../image/性能监控使用指南-部署Java探针-效果.png)
