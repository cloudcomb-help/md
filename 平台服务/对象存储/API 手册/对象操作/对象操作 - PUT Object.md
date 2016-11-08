# 对象操作

### **PUT Object**
#### **描述**
PUT Object接口把对象上传到一个桶中。主要特性有：

* 持久特性，返回成功，则代表对象所有备份已经安全存储。
* 并发特性，对象存储不提供锁机制，同时写一个对象，则后完成的会覆盖前者。
* 数据完整特性，为了保证数据不被损坏，在 Content-MD5头设置对象的MD5摘要，服务器会比对收到的二进制内容。也可以边传输边计算MD5，传完后跟响应的ETag属性对比。
#### **语法**

    PUT /${ObjectKey} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Content-Length: ${length}
    Content-MD5: ${md5}
    Authorization: ${signature}

#### **请求头定义**
|**参数**|                        **描述**                             |
|--------|---------------------------------------------------------------|
|Content-Length|对象的大小 类型：字符串 默认：无|
|Content-MD5|   128位MD5摘要经过Base64编码的值，用来检查网络传输过程中文件是否损坏 类型：字符串 默认：无|
|x-nos-meta-|以该前缀开头的header都将被认为是用户自定义的元数据，比如：x-nos-meta-title: TITLE 这个header会把title:TITLE作为用户自定义元数据key-value对。类型：字符串 默认：无|
#### **示例**
Request

    PUT /1.jpg HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Type: image/jpeg
    Content-Length: 4096
    Content-MD5: fbacf535f27731c9771645a39863328
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    [4096 bytes of Object data]

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 12 Oct 2012 17:50:00 GMT
    ETag: fbacf535f27731c9771645a39863328
    Connection: close
    Server: NOS

#### **细节描述**

1.如果 Bucket 不存在，返回404 no content错误。错误码：NoSuchBucket。

2.只有 Bucket 的拥有者才能向 Bucket 中 PUT Object 。非 Bucket 拥有者执行 PUT Object 操作将返回 403 Forbidden 错误。错误码：AccessDenied。

3.如果 Put Object 请求带 Content-MD5 头，NOS 会将其与实际上传文件内容的 MD5 值进行对比，如果不一致，说明用户操作有误，或者文件在传输过程中出错，返回 400 Bad Request 错误。错误码：BadDigest。

4.如果 Put Object 请求不带 Content-MD5 头，NOS 会将收到文件的 MD5 值放在返回给用户的请求头” ETag ”中，以便用户检查 NOS 上的数据和要上传的数据内容一致。

5.PUT Object 请求头中的 Content-Length 必须和 HTTP BODY 的长度一致，否则返回 400 Bad Request 。错误码：IncompleteBody。

6.如果在 PutObject 的时候，携带以 x-nos-meta- 为前缀的参数，则视为 Meta data，比如 x-nos-meta-location 。一个 Object 可以有多个类似的参数，但所有的 Meta data 总大小不能超过2k。

7.如果 Head 中没有加入 Content-Length 参数，会返回 411 Length Required 错误。错误码：MissingContentLength。

8.如果用户数据已经达到配额上线，则返回 403 Forbidden 错误。错误码：QuotaExceeded。

9.如果添加文件长度超过 100M，返回错误消息 400 Bad Request。错误码：EntityTooLarge。建议大对象使用分块接口。

10.PUT Object 允许创建空文件。Object 名长度不能超过1000字节，否则错误消息 400 Bad Request。错误码：InvalidArgument。