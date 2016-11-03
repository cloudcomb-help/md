## 初始化

### 确定EndPoint

EndPoint 是NOS各个区域的地址，目前支持以下形式

|**EndPoint类型**|              **备注**             |
|----------------|---------------------------------|
|NOS区域域名地址| 使用桶所在的区域的NOS域名地址|

#### NOS区域域名地址

进入NOS控制台，在桶的 [属性](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如:test-logging.nos-eastchina1.126.net中的nos-eastchina1.126.net 为该桶的公网EndPoint。

#### 配置秘钥

要接入NOS服务，你需要一对有效的AccessKey（包括AccessKeyId与AccessKeySecret）来进行 签名验证，开通服务与AccessKey请参考 [访问控制](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/访问控制.md)

在获取到AccessKeyId与AccessKeySecret之后，可以按照以下的步骤进行初始化

使用方法

使用步骤

1.安装nos-node-sdk模块:

    npm install nos-node-sdk

2.引入模块 nos-node-sdk 模块:

    var NosClient = require('nos-node-sdk');

3.初始化 NosClient:

    var nosclient = new NosClient();
    nosclient.setAccessId('你的accessKeyId');
    nosclient.setSecretKey('你的accessKeySecret');
    nosclient.setEndpoint('建桶时选择的的区域域名');
    nosclient.setPort('80');

使用说明

    1.nos-node-sdk提供callback风格的api接口，所有的api都有两个参数，示例如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path' //本地文件路径
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }
    
    *第一个参数是map，不同的接口要求传入的map参数不一样。

    *第二个参数是回调函数cb，cb中的操作由用户自行定义，在收到响应的时候由sdk自动调用，并传入一个result参数，该参数提供的内容在不同的api中有所不同。用户可以在自定义cb的时候利用该参数获取响应的内容，如uploadid，etag等等。

    2.使用sdk时，用户只需要按照文档要求提供合法的map参数和定义cb，就能方便调用nos接口通过node管理资源。NOS Node SDK主要描述各个api的map参数和cb函数的result参数的内容，并提供使用示例。

    3.当接口调用失败，返回状态码不在[200,400)范围时，sdk会抛出异常，异常包含的信息请参考 [异常信息](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/Node.js%20SDK%20%E6%89%8B%E5%86%8C.md)
