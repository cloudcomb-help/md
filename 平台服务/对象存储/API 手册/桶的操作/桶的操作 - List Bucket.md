# 桶的操作
### **LIST Bucket**

#### **描述**
列出用户创建的所有桶。

#### **语法**

    GET / HTTP/1.1
    HOST: ${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **响应元素**
|     **Element**     |                          **描述**                               |
|---------------------|-----------------------------------------------------------------|
|CreationDate   |桶创建的日期 类型：时间戳 格式：yyyy-MM-dd”T”HH:mm:ss.SSSZ(日期+T+时间+时区)(Z=Zulu Time Zone) 父节点：ListAllMyBucketsResult.Buckets.Bucket|
|DisplayName|   桶所有者的名称 类型：字符串 父节点：ListAllMyBucketsResult.Owner|
|ID|    桶所有者的ID 类型：字符串 父节点：ListAllMyBucketsResult.Owner|
|ListAllMyBucketsResult |响应容器 类型：容器 子节点：Owner，Buckets|
|Name|  桶名称 类型：字符串 父节点：ListAllMyBucketsResult.Buckets.Bucket|
|Bucket|    代表一个桶的信息 类型：容器 父节点：ListAllMyBucketsResult.Buckets 子节点：Bucket|
|Buckets|   多个桶信息的容器 类型：容器 父节点：ListAllMyBucketsResult 子节点：Bucket|
#### **示例**
Request

    GET / HTTP/1.1
    HOST: nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <ListAllMyBucketsResult>
        <Owner>
            <ID>bcaf1ffd86f461ca5fb16fd081034f</ID>
            <DisplayName>photo</DisplayName>
        </Owner>
        <Buckets>
                <Bucket>
                <Name>dream</Name>
                <CreationDate>2012-03-03T16:45:09:000Z</CreationDate>
                </Bucket>
                <Bucket>
                <Name>photo</Name>
                <CreationDate>2012-03-03T16:41:58:000Z</CreationDate>
                </Bucket>
        </Buckets>
    </ListAllMyBucketsResult>

#### **细节描述**

1.List Bucket 是NOS操作入口，是最上层的接口。

2.List Bucket 只对验证通过的用户有效，如果请求中没有用户验证信息（即匿名访问）， 返回 403 Forbidden。错误码：AccessDenied。