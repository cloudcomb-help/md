# 桶的操作

## 获取桶的 ACL 配置 - GET Bucket acl

### 描述
返回桶的 ACL 配置。

### 语法

    GET /?acl HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

### 响应头

|   Header  |                                 描述                                |
|-----------|---------------------------------------------------------------------|
| x-nos-acl | 设置桶的访问控制列表<br>类型：字符串<br>有效值：private/public-read |

### 示例
Request

    GET /?acl HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    x-nos-acl: private
    Connection: close
    Server: NOS

### 细节描述

1.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

2.只有 Bucket 的拥有者才能获取这个 Bucket 的 ACL 信息。如果试图获取一个没有对应权限的 Bucket，返回403 Forbidden 错误。错误码：AccessDenied。