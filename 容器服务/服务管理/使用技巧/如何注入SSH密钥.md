# 如何注入 SSH 密钥

目前我们提供两种方式管理容器内的密钥：

* 蜂巢托管（创建服务时，在控制台注入密钥）<br>SSH所有密钥由蜂巢托管，创建完成后不支持重新注入密钥（我们即将提供控制台层的密钥管理功能）。
* 自主管理（创建服务时，不在控制台注入密钥）<br>所有密钥由你自主管理，创建完成后支持重新注入密钥。


## 一、蜂巢托管
<span>Attention:</span><div class="alertContent">若选择了蜂巢托管，将不支持自主管理密钥。所有密钥管理必须使用蜂巢控制台。</div>

<span>Note:</span><div class="alertContent">无状态服务本身不建议在容器内部做改动，所以无状态服务不支持在控制台注入密钥。</div>

* 注入已有密钥<br>添加容器时，选择已有 SSH 密钥：![](../image/创建服务-创建有状态服务-注入已有密钥.png)
	* 创建容器时，最多支持注入五个密钥；
	* 容器创建成功后，出于安全考虑，不支持在「容器设置」页直接修改密钥。
* 创建密钥<br>点击「创建密钥」，蜂巢提供两种创建 SSH 密钥方式：
![](../image/创建服务-创建有状态服务-创建密钥.png)
	* 创建新密钥：选择「创建新密钥」，蜂巢生成随机密钥，自动下载至本地；
	* 导入密钥：选择「导入密钥」，上传本地公钥文件或填写公钥内容导入本地密钥。


## 二、自主管理

### 重新生成密钥

<span>Note:</span><div class="alertContent">若没有密钥，可以使用以下方法在容器内生成新的密钥对，然后将私钥拷贝到本地使用。</div>

1、打开 Web Console（[如何使用蜂巢 WebConsole](http://support.c.163.com/md.html#!容器服务/服务管理/使用技巧/如何使用蜂巢WebConsole.md)），输入以下命令生成新密钥对：

	ssh-keygen

2、生成过程中的人工交互部分，默认全部回车即可，生成完毕输入以下命令将公钥导入授权文件：
	
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

3、输入以下命令输出「私钥内容」，并将输出内容复制或下载到本地，保存为任意文件名。

<span>Attention:</span><div class="alertContent">复制后注意删除多余空格和换行符。</div>

	cat ~/.ssh/id_rsa

![](../image/如何使用SSH密钥登录-重新注入密钥.png)

4、在原生 SHH 客户端导入该私钥即可使用，详见：[如何使用 SSH 密钥登录](http://support.c.163.com/md.html#!容器服务/服务管理/使用技巧/如何使用 SSH 密钥登录.md)。


## 添加公钥

<span>Note:</span><div class="alertContent">若本地已有可用密钥对，可以使用以下方法，将公钥添加至容器中。</div>

1、打开 Web Console（[如何使用蜂巢 WebConsole](http://support.c.163.com/md.html#!容器服务/服务管理/使用技巧/如何使用蜂巢WebConsole.md)），输入以下命令创建 .ssh 文件夹并调整权限：

	mdkir ~/.ssh
	chmod 700 ~/.ssh

2、输入以下命令将本地公钥内容（.pub 文件）导入授权文件：

	echo "此处填写你的公钥内容" >> ~/.ssh/authorized_keys

3、调整权限：

	chmod 600 ~/.ssh/authorized_keys

![](../image/如何重新注入密钥-添加公钥.png)

4、在原生 SHH 客户端导入本地私钥即可使用，详见：[如何使用 SSH 密钥登录](http://support.c.163.com/md.html#!容器服务/服务管理/使用技巧/如何使用 SSH 密钥登录.md)。










