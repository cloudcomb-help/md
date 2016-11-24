# 对象操作

## 删除多个对象 - DELETE Multiple Objects

### 描述
Delete Multiple Object 操作支持用户通过一个 HTTP 请求删除同一个 Bucket 中的多个 Object。Delete Multiple Object 操作支持一次请求内最多删除 1000 个 Object，并提供两种返回模式：详细（verbose）模式和简单（quiet）模式:

* 详细模式：NOS 返回的消息体中会包含每一个删除 Object 的结果。
* 简单模式：NOS 返回的消息体中只包含删除过程中出错的 Object 结果；如果所有删除都成功的话，则没有消息体。

### 语法

    POST / HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}

### 请求元素
|  Element  |                            描述                            |
|-----------|------------------------------------------------------------|
| Delete    | 多重删除的请求容器元素<br>类型：容器                       |
| Quiet     | 是否显示具体删除信息<br>类型：布尔值<br>父节点：Delete     |
| Object    | 要删除的单个对象的容器元素<br>类型：容器<br>父节点：Delete |
| Key       | 要删除的对象键值<br>类型：字符串<br>父节点：Object         |
| VersionId | 要删除的对象版本号<br>类型：数字<br>父节点：Object         |

### 响应头
|   Element    |                             描述                             |
|--------------|--------------------------------------------------------------|
| DeleteResult | 多重删除的响应容器元素<br>类型：容器                         |
| Deleted      | 已被成功删除的容器元素<br>类型：容器<br>父节点：DeleteResult |
| Key          | 已删除的对象键值<br>类型：字符串<br>父节点：Deleted，Error   |
| Error        | 删除失败的对象版本号<br>类型：容器<br>父节点：DeleteResult   |
| Code         | 删除失败返回的错误码<br>类型：字符串<br>父节点：Error        |
| Message      | 删除失败返回的详细错误描述<br>类型：字符串<br>父节点：Error  |

### 示例
Request

    POST /?delete HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Content-Length: 123
    Content-MD5: cdb586d8ee4952fdcc234e8712ea2bdb
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    <Delete>
        <Quiet>true</Quiet>
            <Object>
                <Key>1.jpg</Key>
            </Object>
            <Object>
                <Key>2.jpg</Key>
            </Object>
    </Delete>

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Fri, 02 Feb 2012 01:53:42 GMT
    Content-Length: 251
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <DeleteResult>
    <Deleted>
                <Key>1.jpg</Key>
        </Deleted>
        <Error>
                <Key>2.jpg</Key>
                <Code>AccessDenied</Code>
                <Message>Access Denied</Message>
        </Error>
        <Error>
                <Key>3.jpg</Key>
                <Code>NoSuchKey</Code>
                <Message>No Such Key</Message>
        </Error>
    </DeleteResult>

### 细节描述

1.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2.只有 Bucket 的拥有者才能删除 Bucket 中的 Object。非 Bucket 拥有者执行 DELETE multiple Objects 操作将返回 403 Forbidden 错误。错误码：AccessDenied。
3.Delete Multiple Object 请求默认是详细（verbose）模式。
4.在 Delete Multiple Object 请求中删除一个不存在的 Object，仍然认为是成功的。
5.Delete Multiple Object 的消息体最大允许 2 MB 的内容，超过 2 MB 会返回 MalformedXML 错误码。
6.Delete Multiple Object 请求最多允许一次删除 1000 个 Object；超过1000 个 Object 会返回 MalformedXML 错误码。
7.如果 HTTP 请求的 BODY XML 格式有误，返回 400 Bad Request 消息。错误码：MalformedXML。
8.HTTP 请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。