# 桶的操作

## Put Bucket Website

### 描述
将一个 bucket 设置成静态网站托管模式。

### 语法

    PUT /?website HTTP/1.1
    Host: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}
    Content-MD5: ${md5}

    <?xml version="1.0" encoding="UTF-8"?>
    <WebsiteConfiguration>
        <IndexDocument>
            <Suffix>{suffix}</Suffix>
        </IndexDocument>
        <ErrorDocument>
            <Key>{key}</Key>
        </ErrorDocument>
    </WebsiteConfiguration>

### 请求元素

|    Element    |                                                                                                     描述                                                                                                    |         是否必须        |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|
| IndexDocument | 子元素 Suffix 的父元素                                                                                                                                                                                      | Yes                     |
| Suffix        | 索引文件名，不能为空。例如索引文件设置为index.html，则访问mybucket.nos.netease.com/mydir/这样的目录URL请求的时候默认都相当于访问mybucket.nos.netease.com/index.html。<br>类型：字符串类型，最长 1000 个字符 | 有 IndexDocument 时必须 |
| ErrorDocument | 子元素 Key 的父元素                                                                                                                                                                                         | No                      |
| Key           | 文件不存在时（404）使用的文件名, String 类型，最长 1000 个字符                                                                                                                                              | 有 IndexDocument 时必须 |

### 示例
Request

    PUT /?website HTTP/1.1
    Host: dream.nos-eastchina1.126.net
    Content-Length: length
    Date: date
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    Content-MD5: md5

    <?xml version="1.0" encoding="UTF-8"?>
    <WebsiteConfiguration>
            <IndexDocument>
                 <Suffix>index.html</Suffix>
            </IndexDocument>
            <ErrorDocument>
                 <Key>error.html</Key>
            </ErrorDocument>
    </WebsiteConfiguration>

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

### 细节描述


1. 若请求的 http body 中 xml 格式不合法，则返回 400 Bad Request。错误码：MalformedXML；
2. Suffix 和 Key 的值必须是桶内的已存在对象。否则返回 400 Bad Request。错误码：InvalidArgument
3. 如果此前没有设置过 Website，此操作会创建一个新的 Website 配置；否则，就覆写先前的配置。
4. 在将一个 bucket 设置成静态网站托管模式后，对静态网站根域名的匿名访问，NOS 将返回索引页面；对静态网站根域名的签名访问，NOS 将返回 Get Bucket 结果。
