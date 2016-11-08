# 桶的操作
### **PUT Bucket acl**

#### **描述**
设置桶的访问控制属性。

#### **语法**

    PUT /?acl HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}
    x-nos-acl: public-read

#### **请求头**
|**Header**|    **描述**      |
|----------|------------------|
|x-nos-acl |    public-read   |
#### **示例**
Request

    PUT /?acl HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    x-nos-acl: private
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Content-Length: 0
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

#### **细节描述**


1.如果 Bucket 存在，发送时带的权限和已有权限不一样，并且请求发送者是 Bucket 拥有者时，该请求不会改变 Bucket 内容，但是会更新权限。

2.如果请求中没有『x-nos-acl』头，并且该 Bucket 已存在，并属于该请求发起者，则维持原 Bucket 权限不变。 

3.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

4.只有 Bucket 的拥有者才能设置这个 Bucket 的 ACL 信息。如果试图设置一个没有对应权限的 Bucket，返回 403 Forbidden 错误。错误码：AccessDenied。

5.HTTP 请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。
