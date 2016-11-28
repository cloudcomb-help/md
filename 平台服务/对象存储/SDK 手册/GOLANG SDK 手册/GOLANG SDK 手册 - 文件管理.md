# GOLANG SDK 手册


## 文件管理

在 NOS 中，用户可以通过一系列的接口管理桶 (Bucket) 中的文件 (Object)，比如 ListObjects，DeleteObject，CopyObject，DoesObjectExist 等。

列出桶中的文件

通过 ListObjects 方法获取用户桶下面的对象。可以设置的参数列表如下：

|**参数**|	               **作用**                  |
|--------|-------------------------------------------|
|Prefix|	限定返回的 object key 必须以 prefix 作为前缀|
|Delimiter|	是一个用于对 Object 名字进行分组的字符。所有名字包含指定的前缀且第一次出现 delimiter 字符之间的 object 作为一组元素——CommonPrefixes|
|Marker	|字典序的起始标记，只列出该标记之后的部分|
|MaxKeys|	限定返回的数量，返回的结果小于或等于该值 (默认值为 100)|

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

通过 DoesObjectExist 方法来判断对象是否存在。示例代码如下：

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

通过 DeleteObject 方法实现单个文件删除功能。示例代码如下:

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

通过 DeleteMultiObjects 方法实现多个文件删除功能。示例代码如下：

    package main
    import (
        "fmt"
    
        "github.com/NetEase-Object-Storage/nos-golang-sdk/nosclient"
        "github.com/NetEase-Object-Storage/nos-golang-sdk/model"
    )
    
    func main() {
        deleteMultiObjects := DeleteMultiObjects{
                Quiet: false,            //详细和静默模式，设置为 true 的时候，只返回删除错误的文件列表，设置为 false 的时候，成功和失败的文件列表都返回
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

通过 CopyObject 方法实现对象复制功能，NOS 支持桶内 copy 以及相同用户的跨桶 copy。示例代码如下：

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

<span>Attention:</span><div class="alertContent">支持跨桶的文件 copy</div>

#### 移动文件

通过 MoveObject 方法实现对象重命名，NOS 只支持桶内重命名。示例代码如下：

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

<span>Attention:</span><div class="alertContent">暂时不支持跨桶的文件 move</div>

#### 获取文件的文件元信息

通过 GetObjectMetaData 方法获取文件的元数据。示例代码如下：

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

