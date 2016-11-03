# GOLANG SDK 手册


## 初始化

#### 确定EndPoint

[EndPoint](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/数据中心和域名.md) 是NOS各个区域的地址，目前支持以下形式

|**EndPoint类型**|	               **备注**                   |
|----------------|--------------------------------------------|
|NOS区域域名地址|	使用桶所在的区域的NOS域名地址|

### NOS区域域名地址

进入NOS控制台，在桶的 [属性](http://support.c.163.com/md.html#!平台服务/对象存储/控制台手册/管理存储空间.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如:test-logging.nos-eastchina1.126.net中的nos-eastchina1.126.net 为该桶的公网EndPoint。

#### 配置秘钥

要接入NOS服务，您需要一对有效的AccessKey（包括AccessKeyId与AccessKeySecret）来进行 签名验证，开通服务与AccessKey请参考 [访问控制](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/访问控制.md):

在获取到AccessKeyId与AccessKeySecret之后，可以按照以下的步骤进行初始化

#### 新建NosClient

GO-SDK提供的接口都在NosClient中实现，并以成员方法的方式对外提供调用。因此使用GO-SDK前必须实例化一个NosClient对象。

### 关于请求参数

NosClient中的方法采用对象方式进行传参：

    package main
    
     import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
     )
    
    func main() {
        copyObjectRequest := &CopyObjectRequest{
            SrcBucket : TEST_BUCKET,
            SrcObject : PUTOBJECTFILE,
            DestBucket : TEST_BUCKET,
            DestObject : "CopiedTest",
        }
        err := nosClient.CopyObject(copyObjectRequest)
    }

#### 实例化NosClient

如果您需要修改NosClient的默认参数，可以在实例化NosClient时传入Config实例。Config是NosClient的配置类，可配置连接超时、Key等参数。通过Config可以设置的参数见下表：

|**参数**|	         **描述**            |**是否必须**|
|--------|-------------------------------|------------|
|Endpoint|	上传的NOS地址|	是|
|AccessKey|	认证使用的Access Key|	否|
|SecretKey	|认证使用的Access Secret	|否|
|NosServiceConnectTimeout|	建立连接的超时时间（单位：秒）默认：30秒|	否|
|NosServiceReadWriteTimeout	|Socket层传输数据超时时间（单位：秒）默认：60秒	|否|
|NosServiceMaxIdleConnection|	最大空闲连接时间（单位：秒）默认：60秒|	否|
|LogLevel	|打印日志的等级默认：Debug	|否|
|Logger|	打印日志的对象|	否|

带Config参数实例化NosClient的示例代码：

    package main
    
      import (
         "fmt"
    
         "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/logger"
      )
    
     func main() {
         conf := &config.Config{
             Endpoint:  "nos.netease.com",
             AccessKey: "your-accesskey",
             SecretKey: "your-secretkey",
    
             NosServiceConnectTimeout:    3,
             NosServiceReadWriteTimeout:  15,
             NosServiceMaxIdleConnection: 500,
    
             LogLevel:  logger.LogLevel(logger.DEBUG),
             Logger:    logger.NewDefaultLogger(),
    
         }
    
         nosClient, err := nosclient.New(conf)
         if err != nil {
             fmt.Println(err.ERROR())
             return
         }
    }

<span>Attention:</span><div class="alertContent">后面的示例代码默认您已经实例化了所需的NosClient对象, 不再赘述,后续的代码示例均需要将实例化的代码写入main函数</div>

