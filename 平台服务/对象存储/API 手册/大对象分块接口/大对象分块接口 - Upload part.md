## Upload part

### 描述

传输一个数据块之前需要先调用初始化操作( Initiate Multipart Upload )。在初始化一个 Multipart Upload 之后，可以根据指定的 Object 名和 Upload ID 来分块（Part）上传数据。 每一个上传的 Part 都有一个标识它的号码（part number，范围是 1~10,000）。对于同一个 Upload ID， 该号码不但唯一标识这一块数据，也标识了这块数据在整个文件内的相对位置。 如果你用同一个 part 号码，上传了新的数据，那么 NOS 上已有的这个号码的Part数据将被覆 盖，单块限制为最小为 16k ，最大为 100M，最后一块则没有最大小限制。

### 语法

    PUT /${ObjectKey}?partNumber=${partNumber}&uploadId=${uploadId} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Content-Length: ${size}
    Authorization: ${signature}

### 请求头

|     Header     |                         描述                        | 是否必须 |
|----------------|-----------------------------------------------------|----------|
| Content-Length | Entity Body 的长度<br>类型：整型<br>默认：无        | Yes      |
| Content-MD5    | Entity Body 的 MD5<br>摘要 类型：字符串<br>默认：无 | No       |

### 特殊错误码

|    错误码    |  Http状态码   |                                          描述                                          |
|--------------|---------------|----------------------------------------------------------------------------------------|
| NoSuchUpload | 404 Not Found | 对应的分块上传不存在，可能原因：uploadId 非法、已经执行了abort、已经执行了 complete 等 |

### 示例

Request

    PUT /movie.avi?partNumber=1&uploadId=23r54i252358235-32523f23 HTTP/1.1
    HOST: filestation.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Length: 1046203
    Content-MD5: bb69583fd4da5970a86aa47c0da561ad
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    [1046203 bytes of part data]

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    ETag: bb69583fd4da5970a86aa47c0da561ad
    Connection: close
    Server: NOS

### 细节描述

1. 如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2. 只有 Bucket 的拥有者才能操作大对象分块接口。非 Bucket 拥有者执行此类操作将返回 403 Forbidden 错误。错误码：AccessDenied。
3. 调用该接口上传 Part 数据前，必须调用 Initiate Multipart Upload 接口，获取一个 NOS 服务器颁发的 Upload ID 。
4. 如果执行 Upload Part 时，UploadId 对应的 Object 名和 Bucket 名不匹配，返回：400 Bad Request 错误。 错误码：InvalidArgument。
5. 如果执行 Upload Part 时，UploadId 已经被Abort，或者 UploadId 本就不存在，返回：404 Not Found 错误。错误码：NoSuchUpload。
6. Multipart Upload 要求除最后一个 Part 以外，其他的 Part 大小都要大于16k。但是 Upload Part 接口并不会立即校验上传 Part 的大小（因为不知道是否为最后一块）；只有当 Complete Multipart Upload 的时候才会校验。
7. 与 PUT Object<6.6_PUT_Object> 类似，NOS 根据 Content-MD5 判断上传的文件块的正确性，如果不匹配，返回 404 Bad Request 错误，错误码：BadDigest；如果不带 Content-MD5，返回 Etag，由用户来确保数据正确性。
8. Part 号码的范围是 1~10000 。如果超出这个范围，NOS 将返回 InvalidArgument 的错误码。
9. Upload Part 请求头中的 Content-Length 必须和 HTTP BODY 的长度一致，否则返回 400 Bad Request 。错误码：IncompleteBody。
10. 如果 Head 中没有加入 Content length 参数，会返回 411 Length Required 错误。错误码：MissingContentLength。
11. 如果添加文件长度超过 100M，返回错误消息 400 Bad Request。错误码：EntityTooLarge。 HTTP请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。