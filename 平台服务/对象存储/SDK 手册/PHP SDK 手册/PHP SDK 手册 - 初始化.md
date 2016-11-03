# PHP SDK 手册
## 初始化

### 确定 EndPoint

EndPoint 是 NOS 各个区域的地址，目前支持以下形式

|**EndPoint 类型**|                  **备注**                 |
|-----------------|-----------------------------------------|
|NOS区域域名地址| 使用桶所在的区域的NOS域名地址|

#### NOS 区域域名地址

进入 NOS 控制台，在桶的属性中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如: test-logging.nos-eastchina1.126.net 中的 nos-eastchina1.126.net 为该桶的公网 EndPoint 。

### 配置秘钥

要接入 NOS 服务，您需要一对有效的 AccessKey（包括 AccessKeyId 与 AccessKeySecret）来进行 签名验证，开通服务与 AccessKey 请参考 访问控制

在获取到 AccessKeyId 与 AccessKeySecret 之后，可以按照以下的步骤进行初始化

### 新建 NosClient

使用 NOS 地区域名创建 NosClient

初始化代码如下所示:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
    } catch(NosException e){
            print e->getMessage();
    }

### 设置网络参数

我们可以通过 Client 设置一些基本的网络参数:

    <?php
    $nosClient->setTimeout(3600 /* seconds */);
    $nosClient->setConnectTimeout(10 /* seconds */);

其中：

* setTimeout 设置请求超时时间，单位秒，默认是 5184000 秒, 这里建议不要设置太小，如果上传文件很大，消耗的时间会比较长
* setConnectTimeout 设置连接超时时间，单位秒，默认是10秒