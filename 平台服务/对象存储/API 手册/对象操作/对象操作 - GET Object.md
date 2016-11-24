# 对象操作
## 读取对象内容 - GET Object

### 描述
读取对象内容，返回对象流。

### 语法

    GET /${ObjectKey}?download=${download}&ifNotFound=${ifNotFound} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}
    Range: ${range}

### 请求参数
|    参数    |                                                                                                                                                         描述                                                                                                                                                        |
|------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| download   | 通过浏览器打开时，通过指定该值，浏览器将进行下载而非在浏览器中直接打开当 NOS 发现请求的 Url 中有该值时，会在响应中增加标准 HTTP 字段 Content-Disposition，如下：Content-Disposition: attachment; filename=”<file_name>”<br>类型：字符串（经过 urlencode 编码）<br>限制：字符串长度不得超过 256 字节（未经过编码时） |
| ifNotFound | 通过该参数，可以指定当访问的对象不存在时，期望返回的对象内容（注意此时返回值为 404）<br>类型：字符串（经过urlencode编码）                                                                                                                                                                                           |

### 响应头
|        参数       |                                                  描述                                                 |
|-------------------|-------------------------------------------------------------------------------------------------------|
| Range             | 下载指定的数据块，Range Header 参考 RFC l616<br>类型：字符串<br>默认：无                              |
| If-Modified-Since | 只有当指定时间之后做过修改操作才返回这个对象，否则返回 304（Not Modifed）<br>类型：字符串<br>默认：无 |

### 示例
Request

    GET /1.jpg HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Range: 0-1024
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 206 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Content-Length: 1024
    Content-Range: 0-1024/234564
        ETag: d41d8cd98f00b204e9800998ecf8427e
    Date: Wed, 01 Mar 2012 21:34:55 GMT
        Last-Modified: Tue, 05 Jul 2016 17:32:21 Asia/Shanghai
    Connection: close
    Server: NOS
    
    [1024 bytes of binary data]

### 细节描述

1、如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2、NOS 支持匿名读，此时需要设置桶为 Public-read。如果试图读取没有读权限的 Bucket 中的 Object，返回 403 Forbidden 错误。错误码：AccessDenied。
3、GetObject 通过 range 参数可以支持断点续传，对于比较大的 Object 建议使用该功能。     

* 表示头 500 个字节：bytes=0-499
* 表示第二个 500 字节：bytes=500-999
* 表示最后 500 个字节：bytes=-500
* 表示 500 字节以后的范围：bytes=500-

Range 设置必须严格符合上述规则，否则返回 416 Requested Range Not Satisfiable 错误。错误码：InvalidRange。
4、如果文件修改时间早于 If-Modified-Since，返回 304 Not Modified。
5、如果文件不存在返回 404 Not Found 错误。错误码：NoSuchKey。
6、Get Object 返回的 HTTP 头中还包含对象的 ETag、Content-Type、Last-Modified 等信息。
7、若指定了 ifNotFound 参数，当访问指定对象不存在时，NOS 会进一步查找 ifNotFound 参数指定的对象，若存在，则返回 ifNotFound 对象内容，返回值为 404，若不存在，则直接返回 NoSuchKey 错误。
8、如果返回的对象是分块上传对象，etag 不是由对应文件的 md5 生成的。etag 尾部的 -1 无特殊含义，只是作为标志。
