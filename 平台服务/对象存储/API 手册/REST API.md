# REST API

以下几部分详细介绍 NOS Open API 的定义：前三章定义通用请求头、响应头、错误码；第四 章定义了桶相关操作 API；第五章定义了对象相关的操作 API；第六章定义了大对象分块上传 相关的操作 API；

### **通用请求头**
| **Header** |	             **描述**                |   **是否必须**   |
|------------|---------------------------------------|------------------|
|Authorization|	认证信息类型：字符串默认：无|	Yes|
|Content-Length|	RFC2616所定义的请求长度类型：字符串默认：无|	Conditional|
|Content-Type|	文件的类型类型：字符串默认：无|	No|
|Content-MD5	|HTTP BODYMD5值base64编码后的值，与md5sum结果一致，无效的Content-MD5将返回错误：InvalidDegest类型：字符串示例：fbacf535f27731c9771645a39863328默认：无|	No|
|Date|	请求的时间戳类型：字符串，格式必须符合RFC1123的日期格式示例：Wed, 01 Mar 2012 12:00:00 GMT默认：无|	Yes|
|Host|	请求资源的主机名，通常采用虚拟机风格描述类型：字符串示例：BucketName.nos-eastchina1.126.net默认：无|	Yes|
|x-nos-entity-type|	接口返回的格式，当前支持 xml 和 json 两种格式类型：字符串示例：有效取值：json、xml默认：xml|	No    |

### **通用响应头**

|   **Header**   |	                        **描述**                              |
|----------------|----------------------------------------------------------------|
|Content-Length|	响应体的字节数 类型：字符串 默认：无 |
|Connection	|close 默认：无|
|Date|	响应的时间戳 类型：字符串 默认：无|
|ETag	|HTTP Entity Tag，代表对象的哈希值，反应对象内容的更改情况。(RFC2616) 类型：字符串|
|Server|	响应的服务器名称 类型： 字符串|
|x-nos-request-id|	唯一定位一个请求的 ID 号，主要用于某些情况下错误定位 类型：字符串|

### **错误码定义**

|         **错误码**          |	  **HTTP状态码**    |	                **描述**                       |
|-----------------------------|---------------------|--------------------------------------------------|
|AccessDenied|	403 Forbidden|	权限错误，拒绝访问|
|BadDigest|	400 Bad Request|	提供的MD5值与服务器收到的二进制内容不匹配|
|BucketAlreadyExist|	409 Conflict|	创建桶时，桶名已存在|
|BucketAlreadyOwnedByYou|	409 Conflict|	创建桶时，该桶已经属于你，重复创建了|
|BucketNotEmpty|	409 Conflict|	尝试删的桶非空|
|EntityTooSmall|	400 Bad Request|	提交的请求小于允许的对象的最小值|
|EntityTooLarge|	400 Bad Request|	提交的请求大于允许的对象的最大值|
|IllegalVersioningConfigurationException|	400 Bad Request|	版本号配置无效|
|IncompleteBody|	400 Bad Request|	上传的数据量小于 HTTP 头中的Content-Length|
|InternalError	|500 Internal Server Error|	服务器内部错误，请重试|
|InvalidAccessKeyId|	403 Forbidden	|AccessKey找不到匹配的记录|
|InvalidArgument|	400 Bad Request|	无效参数|
|InvalidBucketName|	400 Bad Request|	无效桶名称|
|InvalidDigest|	400 Bad Request|	不是有效的 Content-MD5|
|InvalidPart	|400 Bad Request	|无效的上传块|
|InvalidPartOrder|	400 Bad Request|	上传块的顺序有错误|
|InvalidRange	|416 Requested Range Not Satisfiable|	请求的 Range 不合法|
|InvalidRequest|	400 Bad Request|	非法请求|
|InvalidStorageClass	|400 Bad Request	|无效的存储级别|
|KeyTooLong	|400 Bad Request|	Object Key 长度太长|
|MalformedXML	|400 Bad Request	|XML 格式错误|
|MetadataTooLarge|	400 Bad Request|	元数据过大|
|MethodNotAllowed	|405 Method Not Allowed	|请求的 HTTP Method 不允许访问|
|MissingContentLength|	411 Length Required|	缺少 HTTP Header Content-Length|
|MissingRequestBodyError	|400 Bad Request	|缺少请求体|
|NoSuchBucket|	404 Not Found|	请求的桶不存在|
|NoSuchKey	|404 Not Found	|没有这个key|
|NoSuchUpload|	404 Not Found|	对应的分块上传不存在|
|NoSuchVersion	|400 Bad Request	|没有这个版本号|
|NotImplemented	|501 Not Implemented|	该项功能尚未实现|
|RequestTimeout	|400 Bad Request	|请求超时|
|RequestTimeTooSkewed|	403 Forbidden|	请求时间戳和服务器时间戳差距过大|
|SignatureDoesNotMatch	|403 Forbidden	|请求的签名与服务器计算的签名不符|
|ServiceUnavailable|	503 Service Unavailable|	服务不可用|
|TooManyBuckets	|400 Bad Request|	创建了过多的桶|
### **错误响应格式**

发生错误时，服务端的响应包括

* 相应的 HTTP 3xx，4xx，5xx 状态码（HTTP Status Code）
* Content-Type:application/xml
* XML 格式的消息体
下面是一个 XML 格式消息体的例子

   

     <?xml version="1.0" encoding="UTF-8"?>
        <Error>
            <Code>NoSuchKey</Code>
            <Message>The resource you requested does not exist</Message>
            <Resource>/myBucket/1.jpg</Resource>
            <RequestId>123456</Request>
        </Error>

下面这个表格定义了错误响应的 XML 元素

|  **错误码**  |	                 **HTTP 状态码**                         |
|--------------|-------------------------------------------------------------|
|Code|	错误代码，唯一标识了一种类型的错误。类型：字符串 父节点：Error|
|Error|	错误信息元素。类型：容器 父节点：无|
|Message|	父节点：Error|
|RequestId|	该错误对应的请求 ID 号，请求号主要用于定位某些异常问题 类型：字符串 父节点：Error|
|Resource|	包含了 Bucket 或 Object 的请求资源描述符。类型：字符串 父节点：Error|

如http请求头部中制定 x-nos-entity-type: json ,则返回 JSON 格式消息体，示例如下

    {
        "Error":{
        "Code": "NoSuchKey",
        "Message": "The resource you requested does not exist",
        "Resource": "/myBucket/1.jpg",
        "RequestId": "123456"
        }
    }

### **文档约定**

**语法**:	接口语法描述，使用 ${var} 的类 shell 语法表示变量。

**请求参数**:	HTTP 请求 URL 参数说明，参数列表以 ? 开始，多个参数之间以 & 隔开。

**请求头**:	HTTP Reqeust Header 说明，每个接口特有的请求头在接口定义中给出，通用的请求头请参阅3.1节。

**请求元素**:	HTTP PUT/POST 请求的 entity-body 中的 xml element 说明，通常比较多的内容用请求参数不友好，需要用 entity 来请求。

**响应头**:	HTTP Response Header 说明。

**响应元素**:	响应的 entity-body 中的 xml element 说明。

**RFC**:	文档中备注的 RFC 语义参考 http://www.w3.org/Protocols/ 对 HTTP 相关 RFC 的解释。

