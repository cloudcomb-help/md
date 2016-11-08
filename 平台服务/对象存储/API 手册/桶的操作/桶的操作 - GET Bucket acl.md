# 桶的操作
### **GET Bucket acl**

#### **描述**
返回桶的ACL配置。

#### **语法**

    GET /?acl HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **响应头**

|**Header**|      **描述**      |
|----------|--------------------|
|x-nos-acl |    设置桶的访问控制列表<br>类型：字符串<br>有效值：private/public-read|

#### **示例**
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

#### **细节描述**

1.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。

2.只有 Bucket 的拥有者才能获取这个 Bucket 的ACL信息。如果试图获取一个没有对应权限的 Bucket，返回403 Forbidden 错误。错误码：AccessDenied。

### **GET Bucket location**

#### **描述** 
获取桶的地理分区信息，地理分区信息在建通时指定，见PUT Bucket。

#### **语法**

    GET /?location HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **响应元素** 
|   **Element**    |            **描述**          |
|------------------|------------------------------|
|LocationConstraint|    桶的地理分区<br>类型：字符串<br>有效值：HZ / BJ / GZ<br>父节点：无 |

示例 
Request

    GET /?location HTTP/1.1
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
    <LocationConstraint>HZ</LocationConstraint>

#### **细节描述**

1.如果 Bucket 不存在，返回404 no content错误。错误码：NoSuchBucket。

2.只有 Bucket 的拥有者才能获取这个 Bucket 的 Location 信息。如果试图获取一个没有对应权限的 Bucket，返回 403 Forbidden 错误。错误码：AccessDenied。


