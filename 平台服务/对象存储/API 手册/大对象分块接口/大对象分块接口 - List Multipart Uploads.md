# 大对象分块接口

## List Multipart Uploads

### 描述

List Multipart Uploads 可以罗列出所有执行中的 Multipart Upload 事件，即已经被初始化 的 Multipart Upload 但是未被 Complete 或者 Abort 的 Multipart Upload 事件。NOS 返回的罗列 结果中最多会包含 1000 个 Multipart Upload 信息。如果想指定 NOS 返回罗列结果内Multipart Upload信息的数目，可以在请求中添加max-uploads参数。另外，NOS 返回罗列结果中的 IsTruncated元素标明是否还有其他的 Multipart Upload。

### 语法

    GET /?uploads HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

## 请求头定义

|     参数    |                                   描述                                   | 是否必须 |
|-------------|--------------------------------------------------------------------------|----------|
| key-marker  | 指定某一 uploads key，只有大于该 key-marker 的才会被列出<br>类型: String | No       |
| max-uploads | 最多返回 max-uploads 条记录<br>类型: 数字<br>默认：1000 取值：[0-1000]   | No       |

### 响应元素

|                元素               |                                                                 描述                                                                |
|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| ListMultipartUploadsResult        | 响应容器元素<br>类型：容器<br>子节点：Bucket，KeyMarker，Upload，NextKeyMarker, owner                                               |
| Bucket                            | 对象的桶<br>类型：字符串<br>父节点：ListMultipartUploadsResult                                                                      |
| NextKeyMarker                     | 作为后续查询的 key-marker<br>类型：String 父节点：ListMultipartUploadsResult                                                        |
| IsTruncated                       | 是否截断，如果因为设置了limit导致不是所有的数据集都返回了，则该值设置为 true<br>类型：Boolean<br>父节点: ListMultipartUploadsResult |
| Upload                            | 类型：容器<br>子节点：Key，UploadId 父节点：ListMultipartUploadsResult                                                              |
| Key                               | 对象的 Key<br>类型：字符串 父节点：Upload                                                                                           |
| UploadId                          | 分块上传操作的 ID<br>类型String 父节点：Upload                                                                                      |
| ID                                | 对象拥有者的 ID<br>类型: String<br>父节点：Owner                                                                                    |
| DisplayName                       | 对象的拥有者<br>类型: String<br>父节点: Owner                                                                                       |
| Owner                             | ID<br>父节点：Upload                                                                                                                |
| StorageClass                      | 存储级别<br>类型: String<br>父节点: Upload                                                                                          |
| Initiated                         | 该分块上传操作被初始化的时间<br>类型：Date<br>父节点： Upload                                                                       |
| ListMultipartUploadsResult.Prefix | 当请求中包含了 prefix 参数时，响应中会填充这一 prefix<br>类型：String<br>父节点: ListMultipartUploadsResult                                    |
示例

Request

    GET /?uploads&HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: Mon,1 Nov 2010 20:34:56 GTM
    Authorization: ${signature}

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Mon, 1 Feb 2012 20:34:56 GMT
    Content-Length: 197
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <ListMultipartUploadsResult>
      <Bucket>Bucket</Bucket>
      <NextKeyMarker>my-movie.m2ts</NextKeyMarker>
      <Upload>
        <Key>my-divisor</Key>
        <UploadId>XMgbGlrZSBlbHZpbmcncyBub3QgaGF2aW5nIG11Y2ggbHVjaw</UploadId>
        <Owner>
          <ID>75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a</ID>
          <DisplayName>OwnerDisplayName</DisplayName>
        </Owner>
        <StorageClass>STANDARD</StorageClass>
      </Upload>
      <Upload>
        <Key>my-movie.m2ts</Key>
            <UploadId>VXBsb2FkIElEIGZvciBlbHZpbcyBteS1tb3ZpZS5tMnRzIHVwbG9hZA</UploadId>
            <Owner>
            <ID>b1d16700c70b0b05597d7acd6a3f92be</ID>
            <DisplayName>OwnerDisplayName</DisplayName>
            </Owner>
            <StorageClass>STANDARD</StorageClass>
      </Upload>
    </ListMultipartUploadsResult>

### 细节描述

1. 如果Bucket不存在，返回404 no content错误。错误码：NoSuchBucket。
2. 只有Bucket的拥有者才能操作大对象分块接口。非Bucket拥有者执行此类操作将返回403 Forbidden错误。错误码：AccessDenied。
3. 通过key-marker和max-uploads参数，能够遍历到Bucket内有多少未完成的多块上传。
4. 返回未完成多块上传按照Key字典序排列。
