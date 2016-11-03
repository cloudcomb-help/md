# DockerHub 镜像加速

由于 [Docker 的官方镜像中心](https://hub.docker.com/) 在国外，当你想要直接拉取 DockerHub 上的镜像时，速度较慢，因此推荐你使用蜂巢的 DockerHub 镜像加速功能。

### **配置镜像加速**

#### Ubuntu | Debian | Centos
	$ sudo echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
	$ service docker restart

#### Windows

启动 Boot2docker Start Shell：

	$ sudo "sh -c \"echo EXTRA_ARGS=\'--registry-mirror=http://hub-mirror.c.163.com\' >>/var/lib/boot2docker/profile\""
重新启动 Boot2Docker。

#### Mac
	$ boot2docker ssh sudo "sh -c \"echo EXTRA_ARGS=\'--registry-mirror=http://hub-mirror.c.163.com\' >>/var/lib/boot2docker/profile\""
	$ boot2docker restart

### **使用**

配置完成后，直接使用以下命令，即可通过蜂巢的加速代理网络来下载 DockerHub 官方镜像：

	docker pull nginx