# 桶的操作
## 设置桶的 404 - PUT Bucket Deafult 404

### 描述
设置桶的默认 404 对象，即设置当访问桶中一个对象不存在时，期望默认返回的对象内容。（注意：如果返回了桶的默认对象，返回值依然为 404）

语法

    PUT /?default404 HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}
    
    <Default404Configuration>
        <Key>${Key}</Key>
    </Default404Configuration>

### 请求元素
|          Header         |                                                 描述                                                 | 是否必须 |
|-------------------------|------------------------------------------------------------------------------------------------------|----------|
| Key                     | 设置桶的默认 404 对象（当该值为空时，表示不设置）<br>类型：字符串<br>父节点：Default404Configuration | Yes      |
| Default404Configuration | 桶默认 404 对象设置容器<br>类型：容器<br>子节点：Key                                                 | Yes      |

### 示例
#### 设置一个桶的默认 404 对象
Request

    PUT /? default404 HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Length: 124
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    <Default404Configuration>
        <Key>default.404</Key>
    </Default404Configuration>

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Fri, 10 Feb 2012 21:34:58 GMT
    Connection: close
    Server: NOS

#### 删除一个桶的默认 404 对象
Request

    PUT /? default404 HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Length: 124
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    <Default404Configuration>
        <Key></Key>
    </Default404Configuration>

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Fri, 10 Feb 2012 21:34:58 GMT
    Connection: close
    Server: NOS
