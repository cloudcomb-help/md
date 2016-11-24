# 对象操作

## 获取对象信息 - HEAD Object

### 描述
获取对象相关信息，返回对象相关元数据信息。该接口通常也用来判断对象存在性和是否有权限。

### 语法

    HEAD /${ObjectKey} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

### 请求参数

|    参数   |                描述               | 是否必须 |
|-----------|-----------------------------------|----------|
| ObjectKey | 对象名<br>类型：字符串<br>默认:无 | No       |

### 请求头

|       Header      |                                                 描述                                                |
|-------------------|-----------------------------------------------------------------------------------------------------|
| If-Modified-Since | 只有当指定时间之后做过修改操作才返回这个对象，否则返回 304（Not Modifed）<br>类型:字符串<br>默认:无 |

### 示例
Request

    HEAD /1.jpg?versionId=3332619744290771 HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Content-Type: image
    Date: Fri, 02 Feb 2012 01:53:42 GMT
    Last-Modified: Sun, 1 Jan 2012 12:00:00 GMT
        ETag: d41d8cd98f00b204e9800998ecf8427e
    Connection: close
    Server: NOS

### 细节描述

1.不论正常返回 200 OK 还是非正常返回，Head Object 都不返回消息体。所有对象元数据都包含在 HTTP 返回头中。

2.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

3.只有 Bucket 的拥有者才能获取 Bucket 中 Object 的元数据信息。非 Bucket 拥有者执行 HEAD Object 操作将返回 403 Forbidden 错误。错误码：AccessDenied。

4.如果对象是分块上传的对象，返回的 etag 不是由该对象对应的文件的 md5 生成的。etag 尾部的 -1 无特殊含义，只是作为标志。
