# 桶的操作
### **HEAD Bucket**

#### **描述** 
这个接口主要用于判断桶是否存在，以及是否有权限访问。

#### **语法** 

    HEAD / HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **示例**
Request

    HEAD / HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    Connection: Keep-Alive

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

#### **细节描述**

1.不论正常返回 200 OK 还是非正常返回，Head Bucket 都不返回消息体。所有桶相关信息都 包含在 HTTP 返回头中。

2.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

3.只有 Bucket 的拥有者才能执行 HEAD Bucket 操作。如果试图对一个没有对应权限的 Bucket 进行该操作，返回 403 Forbidden 错误。错误码：AccessDenied。
