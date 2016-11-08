# 大对象分块接口

## Abort Multipart Upload

### 描述

该接口可以根据用户提供的 Upload ID 中止其对应的 Multipart Upload 事件。当一个 Multipart Upload 事件被中止后，就不能再使用这个 Upload ID 做任何操作，已经上传的 Part 数据也会被删除。

### 语法

 

    DELETE /${ObjectKey}?uploadId=${uploadId} HTTP/1.1
    Host: ${BucketName}.${endpoint}
    Date: ${Date}
    Authorization:  ${signature}

### 特殊错误码

|    错误码    |  Http状态码   |                                         描述                                        |
|--------------|---------------|-------------------------------------------------------------------------------------|
| NoSuchUpload | 404 Not Found | 对应的分块上传不存在，可能原因：uploadId 非法、已经执行了 abort、已经执行了 complete 等 |

### 示例

Request

    DELETE /movie.avi?uploadId=23r54i252358235332523f23 HTTP/1.1
    Host: filestation.nos-eastchina1.126.net
    Date: Mon, 1 May 2012 20:34:56 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 204 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Mon, 1 May 2012 20:34:59 GMT
    ETag: VXBsb2FkIElEIGZvciA2aWWpbmcncyBtZpZS5tMnRzIHVwbG9hZA
    Connection: close
    Server: NOS

### 细节描述

1. 如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2. 只有 Bucket 的拥有者才能操作大对象分块接口。非 Bucket 拥有者执行此类操作将返回 403 Forbidden 错误。错误码： AccessDenied。
3. 如果输入的 Upload Id 不存在，NOS 会返回 NoSuchUpload 的错误码。
4. 调用该接口完成大对象分开接口前，必须调用 Initiate Multipart Upload 接口，获取一个 NOS 服务器分配的Upload ID，并调用 Upload Part 上传至少一块数据。
