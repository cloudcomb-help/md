# 桶的操作

桶（Bucket）是对象的容器，所有的对象都必须位于桶里面，在整个系统里面桶名称唯一，在桶内部，对象 key 唯一。

## PUT Bucket
### 描述
创建一个新的桶，桶名称（BucketName）系统全局唯一，如果有重复，则按照该桶是否属于调用者，返回 BucketAlreadyOwnedByYou 或者 BucketAlreadyExist 两种错误码。

### 语法

    PUT / HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Content-Length: ${length}
    Date: ${date}
    Authorization: ${signature}

### 请求头

|   Header  |                                         描述                                         | 是否必须 |
|-----------|--------------------------------------------------------------------------------------|----------|
| x-nos-acl | 设置桶的访问控制列表<br>类型：字符串<br>有效值：private/public-read<br>默认：private | No       |

### 请求元素

|           Header          |                                描述                                | 是否必须 |
|---------------------------|--------------------------------------------------------------------|----------|
| CreateBucketConfiguration | 建桶配置<br>类型：容器                                             | No       |
| LocationConstraint        | 指定一个地理分区<br>类型：枚举<br>有效值：HZ / BJ / GZ<br>默认：HZ | No       |

### 示例
Request

    PUT / HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    x-nos-acl: public
    Content-Length: 123
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    <CreateBucketConfiguration >
        <LocationConstraint>BJ</LocationConstraint>
    </CreateBucketConfiguration >

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

### 细节描述

1.Bucket 命名请遵循命名规范，否则返回 400 Bad Request。错误码：InvalidBucketName。

2.NOS 支持分区部署，但是如果尝试在一个尚未建立的分区上建桶，返回 404 Not Found，错误码： NoSuchZone。

3.如果请求的 Bucket 已经存在，并且请求者是所有者，返回 409 Conflict，错误码：BucketAlreadyOwnedByYou。

4.如果请求的 Bucket 已经存在，但是不是请求者所拥有的，返回 409 Conflict。错误码：BucketAlreadyExist。

5.如果想创建的 Bucket 不符合命名规范，返回 400 Bad Request 消息。错误码：InvalidBucketName。

6.如果用户发起 PUT Bucket 请求的时候，没有传入用户验证信息，返回 403 Forbidden 消息。错误码：AccessDenied。

7.如果 PutBucket 的时候发现已经超过 Bucket 最大创建数时，返回 400 Bad Request 消息。错误码：TooManyBuckets。

8.如果没有指定访问权限，即 x-nos-acl，则默认使用「private」权限。

9.如果没有指定 Location ，则默认使用「HZ」分区。

10.如果 HTTP 请求的 BODY XML 格式有误，返回 400 Bad Request 消息。错误码：MalformedXML。

11.HTTP 请求头 Content-Length 必须，否则返回 411 Length Required 消息。错误码：MissingContentLength。