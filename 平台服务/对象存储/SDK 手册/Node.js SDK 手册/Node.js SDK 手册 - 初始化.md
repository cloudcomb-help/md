# Node.js SDK 手册

## 初始化

## 确定 EndPoint

EndPoint 是 NOS 各个区域的地址，目前支持以下形式

|  EndPoint 类型   |               备注              |
|------------------|---------------------------------|
| NOS 区域域名地址 | 使用桶所在的区域的 NOS 域名地址 |

### NOS 区域域名地址

进入 NOS 控制台，在桶的 [属性](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如：test-logging.nos-eastchina1.126.net 中的 nos-eastchina1.126.net 为该桶的公网 EndPoint。

### 配置秘钥

要接入 NOS 服务，你需要一对有效的 AccessKey（包括 AccessKeyId 与 AccessKeySecret）来进行 签名验证，开通服务与 AccessKey 请参考 [访问控制](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/访问控制.md)

在获取到 AccessKeyId 与 AccessKeySecret 之后，可以按照以下的步骤进行初始化

### 使用方法

#### 使用步骤

1.安装 nos-node-sdk 模块:

    npm install nos-node-sdk

2.引入模块 nos-node-sdk 模块:

    var NosClient = require('nos-node-sdk');

3.初始化 NosClient:

    var nosclient = new NosClient();
    nosclient.setAccessId('你的accessKeyId');
    nosclient.setSecretKey('你的accessKeySecret');
    nosclient.setEndpoint('建桶时选择的的区域域名');
    nosclient.setPort('80');

#### 使用说明

1、nos-node-sdk 提供 callback 风格的 api 接口，所有的 api 都有两个参数，示例如下:

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

* 第一个参数是 map，不同的接口要求传入的 map 参数不一样。
* 第二个参数是回调函数 cb，cb 中的操作由用户自行定义，在收到响应的时候由 sdk 自动调用，并传入一个 result 参数，该参数提供的内容在不同的 api 中有所不同。用户可以在自定义 cb 的时候利用该参数获取响应的内容，如 uploadid，etag 等等。

2、使用 sdk 时，用户只需要按照文档要求提供合法的 map 参数和定义 cb，就能方便调用 nos 接口通过 node 管理资源。NOS Node.js SDK 主要描述各个 api 的 map 参数和 cb 函数的 result 参数的内容，并提供使用示例。
3、当接口调用失败，返回状态码不在[200,400)范围时，sdk 会抛出异常，异常包含的信息请参考 [异常信息](http://support.c.163.com/md.html#!平台服务/对象存储/SDK 手册/Node.js SDK 手册/Node.js SDK 手册 - 错误处理.md)。
