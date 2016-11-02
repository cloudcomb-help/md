# GOLANG SDK 手册

## 安装

### SDK

Git hub地址: https://github.com/NetEase-Object-Storage/nos-golang-sdk 
历史版本: 无

### 环境要求

建议golang 1.3+ 使用以下命令显示当前的golang版本:

go version

### 安装

#### 命令行方式

在命令行下执行：

    go get -u github.com/NetEase-Object-Storage/nos-golang-sdk

sdk会安装到GOPATH目录下

#### 源码安装

从git hub地址上手动下载sdk，存到GOPATH目录下。使用以下命令显示当前的GOPATH路径:

    go env

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

Attention:
后面的示例代码默认您已经实例化了所需的NosClient对象, 不再赘述,后续的代码示例均需要将实例化的代码写入main函数

## 快速入门

#### 快速入门

请确认您已经熟悉NOS的基本概念，如Bucket、Object、EndPoint、AccessKeyId和AccessKeySecret等。 本节您将看到如何快速的使用NOS GOLANG SDK,完成常用的操作，上传文件、下载文件等

常用包

|**常用类型**|	     **备注**        |
|------------|-----------------------|
|nosclient|	包含了主要的对象操作API|
|model	|包含了对象操作API的请求和响应的结构类型|
#### 基本操作

### 上传文件

对象（Object）是NOS中最基本的数据单元，您可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

  

    package main
    
      import (
         "fmt"
    
         "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
      )
    
     func main() {
    
         metadata := &model.ObjectMetadata{
                 Metadata: map[string]string{
                      nosconst.CONTENT_TYPE:     contentType,
                      nosconst.CONTENT_MD5:      OBJECTMD5,
                 },
         }
    
         putObjectRequest := &model.PutObjectRequest{
                 Bucket:   "使用的桶名，注意命名规则",
                 Object:   "使用的对象名，注意命名规则",
                 FilePath: path,
                 Metadata: metadata,
         }
    
         result, err := nosClient.PutObjectByFile(putObjectRequest)
         if err != nil {
                 fmt.Println(err.Error())  // Message from an error.
         } else {
                 fmt.Println(result) // Pretty-print the response data.
         }
    }

Attention:
对象命名规则请参见 [API 手册 对象](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/API%E6%89%8B%E5%86%8C/%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5.md)

更多的上传文件信息，请参见 NOS-GOLANG-SDK 上传文件

### 下载文件

上传对象成功之后，您可以读取它的内容，以下代码可以实现文件的下载:

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
         objectRequest := &model.GetObjectRequest{
                Bucket:         "使用的桶名，注意命名规则",
                Object:         "使用的对象名，注意命名规则",
        }
        objectResult, err := nosClient.GetObject(objectRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

更多的下载文件信息，请参见 [NOS-GOLANG-SDK 下载文件](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/GOLANG%20SDK%20%E6%89%8B%E5%86%8C.md)

### 列举文件

当上传文件成功之后，可以查看桶中包含的文件列表，以下代码展示如何列举桶内的文件:

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        listRequest := &model.ListObjectsRequest{
                Bucket:    "使用的桶名，注意命名规则",
                Prefix:    PREFIX,
                Delimiter: DELIMITER,
                Marker:    MARKER,
                MaxKeys:   100,
        }
        objectResult, err := s.nosClient.ListObjects(listRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

Note:
上面的代码默认列举100个object

更多的管理文件信息，请参见 [NOS-GOLANG-SDK 文件管理](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/GOLANG%20SDK%20%E6%89%8B%E5%86%8C.md)

### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        objectRequest := &model.ObjectRequest{
             Bucket : "使用的桶名，注意命名规则",
             Object : "使用的对象名，注意命名规则",
        }
    
        err := nosClient.DeleteObject(objectRequest)
        if err != nil {
            fmt.Println(err.Error())  // Message from an error.
            return
        }
    }

## 文件上传

在NOS中用户的基本操作单元是对象，亦可以理解为文件，NOS PHP SDK提供了丰富的上传接口，可以通过以下的方式上传文件:

 

     1. 流式上传
     2. 本地文件上传
     3. 大对象上传

字符串上传、本地文件上传最大为100M，大对象上传对文件大小没有限制

#### 流式上传

通过PutObjectByStream方法上传对象，该方法只支持小于100M的对象。示例代码如下：

    package main
    
    import (
        "fmt"
        "os"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosconst"
    )
    
    func main() {
    
        file, err := os.Open(Path)
    
        metadata := &model.ObjectMetadata{
                ContentLength: contentLength,
                Metadata: map[string]string{
                      nosconst.CONTENT_TYPE:     CONTENTTYPE,
                      nosconst.CONTENT_MD5:      OBJECTMD5,
                },
        }
    
        putObjectRequest := &model.PutObjectRequest{
                Bucket:   "使用的桶名，注意命名规则",
                Object:   "使用的对象名，注意命名规则",
                Body:     file,
                Metadata: metadata,
        }
    
        result, err := nosClient.PutObjectByStream(putObjectRequest)
        if err != nil {
                fmt.Println(err.Error())  // Message from an error.
        } else {
                fmt.Println(result) // Pretty-print the response data.
        }
    }

Attention:
上传的字符串内容不超过100M

#### 本地文件上传

通过PutObjectByFile方法上传本地文件，该方法只支持小于100M的文件。示例代码如下：

    package main
    
      import (
         "fmt"
    
         "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
      )
    
     func main() {
    
         metadata := &model.ObjectMetadata{
                 Metadata: map[string]string{
                      nosconst.CONTENT_TYPE:     contentType,
                      nosconst.CONTENT_MD5:      OBJECTMD5,
                 },
         }
    
         putObjectRequest := &model.PutObjectRequest{
                 Bucket:   "使用的桶名，注意命名规则",
                 Object:   "使用的对象名，注意命名规则",
                 FilePath: path,
                 Metadata: metadata,
         }
    
         result, err := nosClient.PutObjectByFile(putObjectRequest)
         if err != nil {
                 fmt.Println(err.Error())  // Message from an error.
         } else {
                 fmt.Println(result) // Pretty-print the response data.
         }
    }

Attention:
上传的文件内容不超过100M

#### 分片上传

除了通过putObject接口上传文件到NOS之外，NOS还提供了另外一种上传模式-分片上传,用户可以在如下应用场景内（但不限于此），使用分片上传模式，如：

 

    1. 需支持断点上传
     2. 上传超过100M的文件
     3. 网络条件较差，经常和NOS服务器断开连接
     4. 上传前无法确定文件大小

### 初始化分块

通过InitMultiUpload方法实现分块上传的初始化。示例代码如下：

    package main
    
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        initRequest := &model.InitMultiUploadRequest{
                Bucket:   "使用的桶名，注意命名规则",
                Object:   "使用的对象名，注意命名规则",
        }
    
        initResult, err := nosClient.InitMultiUpload(initRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    
        uploadId := initResult.UploadId      //同一个对象的分块上传都要携带该uploadId
    }

### 分块上传

通过UploadPart方法实现分块上传。示例代码如下：

    package main
    
    import (
        "os"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
            file, err := os.Open(path)
            uploadPartRequest := &model.UploadPartRequest{
                Bucket:     "使用的桶名，注意命名规则",
                Object:     "使用的对象名，注意命名规则",
                UploadId:   uploadId,
                PartNumber: partNumber,      //number of uploading
                Content:    content,         //content of uploading
                PartSize:   partSize,        //size of uploading the part
                ContentMd5: OBJECTMD5,       //md5 of uploading the part
            }
            buffer := make([]byte, BufferSize)
            var partNum int
            for ; ;  {
                partNum++
                readLen, err := file.Read(buffer)
                if err != nil || n == 0 {
                    break
                }
    
                uploadPartRequest.PartSize = int64(readLen)
                uploadPartRequest.PartNumber = partNum
                uploadPartRequest.Content = buffer
                uploadPart, err := nosClient.UploadPart(uploadPartRequest)
                if err != nil {
                    break
                }
           }
    }

### 分块终止上传

通过AbortMultiUpload方法终止分块上传。示例代码如下：

    package main
    
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        abortMultiUploadRequest := &model.AbortMultiUploadRequest{
                Bucket:             "使用的桶名，注意命名规则",
                Object:             "使用的对象名，注意命名规则",
                UploadId:           uploadId,
        }
        err := nosClient.AbortMultiUpload(abortMultiUploadRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

### 完成分块上传

通过CompleteMultiUpload方法完成分块上传。示例代码如下：

    package main
    
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        completeMultiUploadRequest := &model.CompleteMultiUploadRequest{
                Bucket:     "使用的桶名，注意命名规则",
                Object:     "使用的对象名，注意命名规则",
                UploadId:   uploadId,
                Parts:      etags,       //map，partnum: etag
                ContentMd5: contentMd5,  //body md5
                ObjectMd5:  objectMd5,   //big file md5
        }
        completeResult, err := nosClient.CompleteMultiUpload(completeMultiUploadRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

### 列出分块

查看已经上传的分片可以罗列出指定Upload ID(InitiateMultipartUpload时获取)所属的所有已经上传成功的分片，您可以通过NosClient::listParts接口获取已经上传的分片，可以参考以下代码:

通过ListUploadParts方法实现列出一个UploadId对应的所有分块。可以设置的参数为：

|**参数**|	                  **作用**                    |
|--------|------------------------------------------------|
|UploadId|	分块上传的UploadId|
|MaxParts|	响应中的limit个数, 取值范围[0-1000]，默认1000|
PartNumberMarker	分块号的界限，只有更大的分块号会被列出来
示例代码如下：

 

    package main
     import (
         "fmt"
    
         "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
     )
    
     func main() {
         listUploadPartsRequest := &model.ListUploadPartsRequest{
                 Bucket:           "使用的桶名，注意命名规则",
                 Object:           "使用的对象名，注意命名规则",
                 UploadId:         uploadId,
                 MaxParts:         2,
                 PartNumberMarker: 20,
         }
         completeResult, err := nosClient.ListUploadParts(completeMultiUploadRequest)
         if err != nil {
                 fmt.Println(err.Error())
         }
    }

### 列出所有上传的分块

通过ListMultiUploads方法罗列出所有执行中的Multipart Upload事件，即已经被初始化的Multipart Upload但是未被Complete或者Abort的Multipart Upload事件。可以设置的参数为：

|**参数**|	                    **作用**                        |
|--------|------------------------------------------------------|
|KeyMarker	|指定某一uploads key，只有大于该key-marker的才会被列出|
|MaxUploads	|最多返回max-uploads条记录，取值范围[0-1000]，默认1000|
示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        listMultiUploadsRequest = &model.ListMultiUploadsRequest{
                Bucket:     "使用的桶名，注意命名规则",
                KeyMarker:  KEYMARKER,
                MaxUploads: 20,
        }
        completeResult, err := nosClient.ListMultiUploads(listMultiUploadsRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

## 文件下载

#### 下载文件

通过GetObject方法获取对象的网络流。可以设置的参数列表为：

|**参数**|	                  **作用**                      |
|--------|--------------------------------------------------|
|ObjRange|	下载指定对象的指定范围的数据|
|IfModifiedSince|	文件的最后修改时间小于等于If-Modified-Since参数指定的时间，则不进行下载，否则正常下载文件|
示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
         objectRequest := &model.GetObjectRequest{
                Bucket:         "使用的桶名，注意命名规则",
                Object:         "使用的对象名，注意命名规则",
        }
        objectResult, err := nosClient.GetObject(objectRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

## 文件管理

在NOS中，用户可以通过一系列的接口管理桶(Bucket)中的文件(Object)，比如ListObjects，DeleteObject，CopyObject，DoesObjectExist等。

列出桶中的文件

通过ListObjects方法获取用户桶下面的对象。可以设置的参数列表如下：

|**参数**|	               **作用**                  |
|--------|-------------------------------------------|
|Prefix|	限定返回的object key必须以prefix作为前缀|
|Delimiter|	是一个用于对Object名字进行分组的字符。所有名字包含指定的前缀且第一次出现delimiter字符之间的object作为一组元素——CommonPrefixes|
|Marker	|字典序的起始标记，只列出该标记之后的部分|
|MaxKeys|	限定返回的数量，返回的结果小于或等于该值(默认值为100)|
示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        listRequest := &model.ListObjectsRequest{
                Bucket:    "使用的桶名，注意命名规则",
                Prefix:    PREFIX,
                Delimiter: DELIMITER,
                Marker:    MARKER,
                MaxKeys:   100,
        }
        objectResult, err := nosClient.ListObjects(listRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

#### 判断文件是否存在

通过DoesObjectExist方法来判断对象是否存在。示例代码如下：

    package main
     import (
         "fmt"
    
         "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
         "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
     )
    
     func main() {
         objectRequest := &model.ObjectRequest{
                 Bucket : "使用的桶名，注意命名规则",
                 Object : "使用的对象名，注意命名规则",
         }
    
         isExist, err := nosClient.DoesObjectExist(objectRequest)
         if err != nil {
                 fmt.Println(err.Error())  // Message from an error.
         }
    }

#### 删除单个文件

通过DeleteObject方法实现单个文件删除功能。示例代码如下:

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        objectRequest := &model.ObjectRequest{
             Bucket : "使用的桶名，注意命名规则",
             Object : "使用的对象名，注意命名规则",
        }
    
        err := nosClient.DeleteObject(objectRequest)
        if err != nil {
            fmt.Println(err.Error())  // Message from an error.
            return
        }
    }

#### 删除多个文件

通过DeleteMultiObjects方法实现多个文件删除功能。示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        deleteMultiObjects := DeleteMultiObjects{
                Quiet: false,            //详细和静默模式，设置为true的时候，只返回删除错误的文件列表，设置为false的时候，成功和失败的文件列表都返回
        }
        deleteMultiObjects.Append(DeleteObject{Key:PUTOBJECTFILE})
        deleteMultiObjects.Append(DeleteObject{Key:PUTOBJECTFILE+"1"})
        deleteMultiObjects.Append(DeleteObject{Key:PUTOBJECTFILE+"2"})
        deleteMultiObjects.Append(DeleteObject{Key:PUTOBJECTFILE+"3"})
    
        deleteRequest := &DeleteMultiObjectsRequest{
                Bucket : "使用的桶名，注意命名规则",
                DelectObjects : &deleteMultiObjects,
        }
        deleteResult, err := nosClient.DeleteMultiObjects(deleteRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

#### 拷贝文件

通过CopyObject方法实现对象复制功能，NOS支持桶内copy以及相同用户的跨桶copy。示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        copyRequest := &model.CopyObjectRequest{
            SrcBucket :  SRC_BUCKET,
            SrcObject :  SRC_OBJECT,
            DestBucket : DEST_BUCKET,
            DestObject : DEST_OBJECT,
        }
    
        err := nosClient.CopyObject(copyRequest)
        if err != nil {
            fmt.Println(err.Error())  // Message from an error
        }
    }

Attention:
支持跨桶的文件copy

#### 移动文件

通过MoveObject方法实现对象重命名，NOS只支持桶内重命名。示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        moveRequest := &model.MoveObjectRequest{
                SrcBucket :  SRC_BUCKET,
                SrcObject :  SRC_OBJECT,
                DestBucket : DEST_BUCKET,
                DestObject : DEST_OBJECT,
        }
    
        err := nosClient.MoveObject(moveRequest)
        if err != nil {
                fmt.Println(err.Error())  // Message from an error.
        }
    }

Attention:
暂时不支持跨桶的文件move

#### 获取文件的文件元信息

通过GetObjectMetaData方法获取文件的元数据。示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        objectRequest := &model.GetObjectRequest{
                Bucket:         "使用的桶名，注意命名规则",
                Object:         "使用的对象名，注意命名规则",
        }
        metaData, err := nosClient.GetObjectMetaData(objectRequest)
        if err != nil {
                fmt.Println(err.Error())
        }
    }

## 错误处理

返回的错误类型一共有两种，分别是客户端错误和服务端错误，分别都实现了error方法。

    type ClientError struct {
        StatusCode int
        Resource string
        Message  string
    }
    
    type ServerError struct {
        StatusCode int
        RequestId  string
        NosErr     NosError   //服务端返回的原始错误内容
    }
    
    type NosError struct {
        Code         string
        Message      string
        Resource     string
        NosRequestId string  //请求ID,非常重要，有利于nos开发人员跟踪异常请求的错误原因
    }
    Next  Previous

