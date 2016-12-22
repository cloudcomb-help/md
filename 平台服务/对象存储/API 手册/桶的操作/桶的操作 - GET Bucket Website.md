# 桶的操作

## GET Bucket Website

### 描述
查看 bucket 的静态网站托管状态。

### 语法

    GET /?website HTTP/1.1
    Host: ${BucketName}.{endpoint}
    Date: ${date}
    Authorization: ${signature}

### 响应元素

|    Element    |                                                                                                        描述                                                                                                       |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| IndexDocument | 子元素 Suffix 的父元素                                                                                                                                                                                            |
| Suffix        | 索引文件名，不能为空。例如索引文件设置为 index.html，则访问 mybucket.nos.netease.com/mydir/ 这样的目录 URL 请求的时候默认都相当于访问 mybucket.nos.netease.com/index.html。<br>类型：字符串类型，最长 1000 个字符 |
| ErrorDocument | 子元素 Key 的父元素                                                                                                                                                                                               |
| Key           | 文件不存在时（404）使用的文件名, String 类型，最长 1000 个字符                                                                                                                                                    |

### 示例
Request

    GET /?websiteHTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

    <?xml version="1.0" encoding="UTF-8"?>
    <WebsiteConfiguration>
        <IndexDocument>
            <Suffix>{suffix}</Suffix>
        </IndexDocument>
        <ErrorDocument>
            <Key>{key}</Key>
        </ErrorDocument>
    </WebsiteConfiguration>

### 细节描述


1. 如果 Bucket 或 Website 不存在，返回 404 Not Found 错误，错误码：NoSuchBucket或NoSuchWebsiteConfiguration。
