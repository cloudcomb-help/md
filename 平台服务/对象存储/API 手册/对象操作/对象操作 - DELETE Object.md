# 对象操作

## 删除对象 - DELETE Object

### 描述
删除一个对象。

### 语法

    DELETE /${ObjectKey} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

### 请求参数
|    参数   |                描述                | 是否必须 |
|-----------|------------------------------------|----------|
| ObjectKey | 删除对象的对象名称<br>类型：字符串 | Yes      |

### 响应元素
|   Header   |                     描述                     |
|------------|----------------------------------------------|
| 无特定头部 | 除通用返回头部外，无特殊头部<br>类型：字符串 |

### 示例
Request

    DELETE /1.jpg HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

### 细节描述

1.如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2.只有 Bucket 的拥有者才能删除 Bucket 中的 Object 。非 Bucket 拥有者执行 DELETE Object 操作将返回 403 Forbidden 错误。错误码：AccessDenied。
3.如果要删除的 Object 不存在，返回 404- NoSuchKey 。
