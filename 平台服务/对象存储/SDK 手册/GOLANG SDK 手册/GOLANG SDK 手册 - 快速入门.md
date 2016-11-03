# GOLANG SDK 手册


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

<span>Attention:</span><div class="alertContent">对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md)</div>

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

<span>Note:</span><div class="alertContent">上面的代码默认列举100个object</div>


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


