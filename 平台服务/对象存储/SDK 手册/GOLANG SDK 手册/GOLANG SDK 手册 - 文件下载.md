# GOLANG SDK 手册

## 文件下载

#### 下载文件

通过 GetObject 方法获取对象的网络流。可以设置的参数列表为：

|**参数**|	                  **作用**                      |
|--------|--------------------------------------------------|
|ObjRange|	下载指定对象的指定范围的数据|
|IfModifiedSince|	文件的最后修改时间小于等于 If-Modified-Since 参数指定的时间，则不进行下载，否则正常下载文件|

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

