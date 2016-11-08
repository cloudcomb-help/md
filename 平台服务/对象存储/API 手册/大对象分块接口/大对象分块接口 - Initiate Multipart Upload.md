# 大对象分块接口
大对象可以调用分块上传接口来提高上传成功率，该接口支持断点续传和并发上传。上传数 据分块最小 16 k，最大 100 M（最后一块除外）。

## Initiate Multipart Upload

### 描述

使用 Multipart Upload 模式传输数据前，必须先调用该接口来通知 NOS 初始化一个 Multipart Upload 事件。该接口会返回一个 NOS 服务器创建的全局唯一的 Upload ID，用于标识本次 Multipart Upload 事件。用户可以根据这个 ID 来发起相关的操作，如中止 Multipart Upload 、 查询 Multipart Upload 等。

### 语法

    POST /${ObjectKey}?uploads HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}

### 请求头定义

|     参数    |                                                                                                     描述                                                                                                    | 是否必须 |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| x-nos-meta- | 以该前缀开头的header都将被认为是用户自定义的元数据，比如：<code>x-nos-meta-title: TITLE</code><br>这个 header 会把 <code>title:TITLE</code> 作为用户自定义元数据 key-value 对。<br>类型：字符串<br>默认：无 | No       |

### 响应元素

|              元素             |                                                  描述                                                 |
|-------------------------------|-------------------------------------------------------------------------------------------------------|
| InitiateMultipartUploadResult | 响应容器元素<br>类型：容器<br>子节点：Key，Bucket                                                           |
| Key                           | 对象的Key<br>类型：字符串<br>父节点：InitiateMultipartUploadResult                                          |
| Bucket                        | 对象的桶<br>类型：字符串<br>父节点：InitiateMultipartUploadResult                                           |
| UploadId                      | 分块上传的ID，用这个ID来作为各块属于这个文件的标识<br>类型：字符串<br>父节点：InitiateMultipartUploadResult |

### 示例

Request

    POST /movie.avi?uploads HTTP/1.1
    HOST: filestation.nos-eastchina1.126.net
    Content-Length: 401
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response


    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Content-Length: 197
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <InitiateMultipartUploadResult>
        <Bucket>filestation</Bucket>
        <Key>movie.avi</Key>
        <UploadId>VXBsb2FkIElEIGZvciA2aWWpbmcncyBteS1tb3S5tMnRzIHVwbG9hZA</UploadId>
    </InitiateMultipartUploadResult>

### 细节描述

1. 如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2. 只有 Bucket 的拥有者才能操作大对象分块接口。非 Bucket 拥有者执行此类操作将返回 403 Forbidden 错误。错误码：AccessDenied。
3. Object 名最大长度为 1000，如果超出，返回 400 Bad Request。错误码：KeyTooLong。
4. 相同 Object 能进行多次初始化，得到多个 UploadId，后完成的多块上传将覆盖先完成的 Object（如果开启版本号，先完成的多块上传将入历史版本）。
5. HTTP 请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。

