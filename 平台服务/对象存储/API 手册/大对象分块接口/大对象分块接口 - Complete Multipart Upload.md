# 大对象分块接口

## Complete Multipart Upload

### 描述

在将所有数据 Part 都上传完成后，必须调用 Complete Multipart Upload API 来完成整个文件 的 Multipart Upload 。在执行该操作时，用户必须提供所有有效的数据 Part 的列表 （包括 part 号码和 ETAG）；NOS 收到用户提交的 Part 列表后，会逐一验证每个数据 Part 的有效性。 当所有的数据 Part 验证通过后，NOS 将把这些数据part组合成一个完整的 Object。

### 语法

    POST /${ObjectKey}?uploadId=${uploadId} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-MD5:  ${entityMD5}
    Content-Length:  ${length}
    x-nos-Object-md5: ${ObjectMD5}
    Authorization:  ${signature}
    
    <CompleteMultipartUpload>
        <Part>
                <PartNumber>${PartNumber}</PartNumber>
                <ETag>${ETag}</ETag>
        </Part>
        ...
    </CompleteMultipartUpload>

### 请求头定义

|    Header   |                                                                                   描述                                                                                   | 是否必须 |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| x-nos-meta- | 以该前缀开头的header都将被认为是用户自定义的元数据，比如：x-nos-meta-title: TITLE<br>这个 header 会把 title:TITLE 作为用户自定义元数据 key-value 对。<br>类型：字符串<br>默认：无 | No       |

### 请求元素

|           元素          |                                      描述                                     | 是否必须 |
|-------------------------|-------------------------------------------------------------------------------|----------|
| CompleteMultipartUpload | 完成块传输的请求容器<br>类型：容器<br>子节点：一个或多个Part节点              | Yes      |
| ETag                    | 一块数据上传完毕后，服务器端返回的 Entity tag<br>类型：字符串<br>父节点：Part | Yes      |
| Part                    | 每一块的描述信息的容器<br>类型：容器<br>子节点：PartNumber，ETag              | Yes      |
| PartNumber              | 分块序号。<br>类型：整型<br>父节点：Part                                      | Yes      |

### 响应元素

|              元素             |                                          描述                                          |
|-------------------------------|----------------------------------------------------------------------------------------|
| Bucket                        | 新创建对象所在的桶<br>类型：字符串<br>父节点：CompleteMultipartUploadResult            |
| CompleteMultipartUploadResult | 响应容器元素<br>类型：容器<br>子节点：Location，Bucket，Key，ETag                      |
| ETag                          | 新创建的对象的Entity Tag<br>类型：字符串<br>父节点：CompleteMultipartUploadResult      |
| Key                           | 新创建的对象的Entity Tag<br>类型：字符串<br>父节点：CompleteMultipartUploadResult      |
| Location                      | 新创建的这个对象的资源定位URL<br>类型：字符串<br>父节点：CompleteMultipartUploadResult |

### 特殊错误码

|      错误码      |   Http状态码    |                                                描述                                               |
|------------------|-----------------|---------------------------------------------------------------------------------------------------|
| InvalidPart      | 400 Bad Request | 请求所指定的上传块中，有一个或多个块不存在，可能的原因：该块缺失未上传，该块的 EntityTag 不匹配等 |
| InvalidPartOrder | 400 Bad Request | 上传块列表，不是按照块序号升序排列                                                                |
| NoSuchUpload     | 404 Not Found   | 对应的分块上传不存在，可能原因：uploadId 非法、已经执行了 abort、已经执行了 complete 等           |

### 示例

Reqeust

    POST /movie.avi?uploadId=23r54i252358235-32523f23 HTTP/1.1
    HOST: filestation.nos-eastchina1.126.net
    Content-MD5: bb69583fd4da5970a86aa47c0da561ad
    Content-Length: 325
    x-nos-Object-md5: fd4da5970a86aa47c0da56bb69363
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    <CompleteMultipartUpload>
        <Part>
                <PartNumber>1</PartNumber>
                <ETag>"a54357aff0632cce46d942af68356b38"</ETag>
        </Part>
        <Part>
                <PartNumber>2</PartNumber>
                <ETag>"0c78aef83f66abc1fa1e8477f296d394"</ETag>
        </Part>
        <Part>
                <PartNumber>3</PartNumber>
                <ETag>"acbd18db4cc2f85cedef654fccc4a4d8"</ETag>
        </Part>
    </CompleteMultipartUpload>

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    ETag: VXBsb2FkIElEIGZvciA2aWWpbmcncyBtZpZS5tMnRzIHVwbG9hZA
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <CompleteMultipartUploadResult xmlns="">
        <Location> filestation.nos-eastchina1.126.net/movie.avi</Location>
        <Bucket>filestation </Bucket>
        <Key>movie.avi </Key>
        <ETag>"3858f62230ac3c915f300c664312c11f"</ETag>
    </CompleteMultipartUploadResult>

### 细节描述

1. 如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2. 只有 Bucket 的拥有者才能操作大对象分块接口。非 Bucket 拥有者执行此类操作将返回 403 Forbidden 错误。错误码： AccessDenied 。
3. 调用该接口完成大对象分开接口前，必须调用 Initiate Multipart Upload 接口，获取一个 NOS 服务器颁发的Upload ID，并调用 Upload Part 上传至少一块数据。
4. 如果执行 Complete Multipart Upload 时，UploadId 对应的 Object 名和 Bucket 名不匹配，返回：400 Bad Request 错误。错误码：InvalidArgument。
5. 如果执行 Complete Multipart Upload 时，UploadId 已经被 Abort，或者 UploadId 本就不存在，返回：404 Not Found 错误。错误码：NoSuchUpload。
6. Complete Multipart Upload 时，会确认除最后一块以外所有块的大小都大于 16k，并检查用户提交的 Partlist 中的每一个 Part 号码和 Etag 。所以在上传 Part 时，客户端除了需要记录 Part 号码外，还需要记录每次上传 Part 成功后，服务器返回的 ETag 值。
7. 如果非最后一块小于 16k，返回：400 Bad Request。错误码：EntityTooSmall。
8. 用户提交的 Part List 中，Part 号码可以是不连续的。例如第一块的 Part 号码是1，第二块的 Part 号码是5。完成 Complete Multipart Upload 后，所有没有被提交的已上传 Part 将被删除。
9. 用户提交的 Part List 中，Part 号码必须是升序排列的，否则返回：400 Bad Request。错误码：InvalidPartOrder。
10. 如果用户提交的 Part List 中存在还为上传完成的Part号码，返回：400 Bad Request。错误码：InvalidPart。
11. NOS 处理 Complete Multipart Upload 请求成功后，该 Upload ID 就会变成无效。
12. 同一个 Object 可以同时拥有不同的 Upload Id，当 Complete 一个 Upload ID 后，该 Object 的其他 Upload ID 不受影响。
13. 如果 HTTP 请求的 BODY XML 格式有误，返回 400 Bad Request 消息。错误码：MalformedXML。
14. HTTP 请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。
15. etag 的计算方法是，每个分块的 etag 加上‘-’，包括最后一个分块，然后求 md5，转换为字符串就得到整个大对象的 etag 了。
16. 分块上传的元数据是在调用这个接口后才有效的。
