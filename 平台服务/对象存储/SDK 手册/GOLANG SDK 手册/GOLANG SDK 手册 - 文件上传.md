# GOLANG SDK 手册


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

<span>Attention:</span><div class="alertContent">上传的字符串内容不超过100M</div>

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

<span>Attention:</span><div class="alertContent">上传的文件内容不超过100M</div>

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

