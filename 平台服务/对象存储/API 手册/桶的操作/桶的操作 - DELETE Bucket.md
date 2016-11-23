# 桶的操作

## 删除桶 - DELETE Bucket

### 描述
删除一个桶，只能删除无对象的桶，如果桶非空，需要先删除桶内的对象。

### 语法

    DELETE / HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

### 示例
Request

    DELETE / HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

### 细节描述

1.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

2.如果试图删除一个不为空的 Bucket，返回 409 Conflict 错误。错误码：BucketNotEmpty。

3.只有 Bucket 的拥有者才能删除这个 Bucket。如果试图删除一个没有对应权限的 Bucket，返回 403 Forbidden 错误。错误码：AccessDenied。