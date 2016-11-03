# Python SDK 手册

## 初始化

### 确定EndPoint

[EndPoint](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/数据中心和域名.md) 是 NOS 各个区域的地址，目前支持以下形式

|**EndPoint类型**|	            **备注**              |
|----------------|------------------------------------|
|NOS区域域名地址|	使用桶所在的区域的NOS域名地址|

#### NOS区域域名地址

进入NOS控制台，在桶的 [属性](http://support.c.163.com/md.html#!平台服务/对象存储/控制台手册/管理存储空间.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如:test-logging.nos-eastchina1.126.net中的nos-eastchina1.126.net 为该桶的公网EndPoint。

### 配置密钥

要接入NOS服务，你需要一对有效的AccessKey（包括AccessKeyId与AccessKeySecret）来进行 签名验证，开通服务与AccessKey请参考 [访问控制](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/访问控制.md)

在获取到AccessKeyId与AccessKeySecret之后，可以按照以下的步骤进行初始化

### 新建Client

使用NOS地区域名创建Client

初始化代码如下所示:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    client = nos.Client(access_key, secret_key, end_point)

### 设置额外参数

如果你需要修改Client的默认配置，可以在实例化Client时添加其他可选参数:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    client = nos.Client(
        access_key,
        secret_key,
        end_point,
        num_pools=10,
        timeout=5,
        max_retries=4
    )

具体参数见下表：

|**参数**|      	**描述**            |	   **默认值**       |
|--------|------------------------------|-----------------------|
|timeout|	建立连接的超时时间（单位：秒）|	默认：Socket的全局Timeout值|
|num_pools|	允许打开的最大HTTP连接数|	默认：16|
|max_retries|	请求失败后最大的重试次数|	默认：2|
