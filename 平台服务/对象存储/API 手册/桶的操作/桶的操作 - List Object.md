# 桶的操作
### **GET Bucket (List Object)**

#### **描述** 
列出桶的对象，可以根据简单的检索条件，返回对象列表的子集。

#### **语法**

    GET / HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **请求参数**
|**参数**|                                  **描述**                                |
|--------|------------------------------------------------------------------------|
|delimiter| 分界符，用于做groupby操作 类型：字符串 默认：无|
|marker|    字典序的起始标记，只列出该标记之后的部分 类型：字符串 默认：无|
|max-keys|  限定返回的数量，返回的结果小于或等于该值 类型：数字 默认：100 取值范围：[0-1000]|
|prefix|    只返回Key以特定前缀开头的那些对象。可以使用前缀把一个桶里面的对象分成不同的组，类似文件系统的目录一样。类型：字符串 默认：无|
#### **响应元素**
|   **元素**   |                      **描述**                           |
|--------------|-----------------------------------------------------------|
|Contents|  对象元数据，代表一个对象描述 类型：容器 父节点：ListBucketObjects 子节点：Key，LastModified，Size，Etag|
|CommonPrefixes|    只有当指定了delimiter分界符时，才会有这个响应 类型：字符串 父节点：ListBucketObjects|
|delimiter| 分界符 类型：字符串 父节点：ListBucketObjects|
|DisplayName|   对象的拥有者 类型：字符串 父节点：ListBucketObjects.Contents.Owner|
|Etag|  对象的哈希描述 类型：字符串 父节点：ListBucketObjects.Contents|
|ID|    对象拥有者的ID 类型：字符串 父节点：ListBucketObjects.Contents.Owner|
|IsTruncated|   是否截断，如果因为设置了limit导致不是所有的数据集都返回，则该值设置为true类型：布尔值 父节点：ListBucketObjects|
|Key|   对象的名称 类型：字符串 父节点：ListBucketObjects.Contents|
|LastModified|  对象最后修改日期和时间 类型：日期 格式：yyyy-MM-dd”T”HH:mm:ss.SSSZ 父节点：ListBucketObjects.Contents|
|Marker|    列表的起始位置，等于请求参数设置的Marker值 类型：字符串 父节点：ListBucketObjects|
|NextMark|  下一次分页的起点 类型：字符串 父节点：ListBucketObjects|
|MaxKeys|   请求的对象个数限制 类型：数字 父节点：ListBucketObjects|
|Name|  请求的桶名称 类型：字符串 父节点：ListBucketObjects|
|Owner| CommonPrefixes子节点：DisplayName|ID|
|Prefix|    请求的对象的Key的前缀 类型：字符串 父节点：ListBucketObjects|
|Size|  对象的大小字节数 类型：数字 父节点：ListBucketObjects.contents|
|StorageClasss| 存储级别 类型：字符串 父节点：ListBucketObjects.contents|
#### **示例** 
Request

    GET /?max-keys=2&prefix=user HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:56 GMT
    Content-Type: application/xml
    Content-Length: 302
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <ListBucketResult>
        <Name>dream</Name>
        <Prefix>user</Prefix>
        <MaxKeys>2</MaxKeys>
        <NextMarker>user/yao</NextMarker>
        <IsTruncated>true</IsTruncated>
        <Contents>
                <Key>user/lin</Key>
                <LastModified>2012-01-01T12:00:00.000Z</LastModified>
                <Etag>258ef3fdfa96f00ad9f27c383fc9acce</Etag>
                <Size>143663</Size>
            <StorageClass>Standard</StorageClass>
        </Contents>
        <Contents>
                <Key>user/yao</Key>
                <LastModified>2012-01-01T12:00:00.000Z</LastModified>
                <Etag>828ef3fdfa96f00ad9f27c383fc9ac7f</Etag>
                <Size>423983</Size>
                <StorageClass>Standard</StorageClass>
        </Contents>
    </ListBucketResult>

#### **细节描述**

1.Object 中用户自定义的 Meta，在 GetBucket 请求时不会返回。

2.如果访问的 Bucket 不存在，包括试图访问因为命名不规范无法创建的 Bucket，返回 404 Not Found 错误，错误码：NoSuchBucket。

3.如果没有访问该 Bucket 的权限，返回 403 Forbidden 错误，错误码：AccessDenied。

4.如果因为 max-keys 的设定无法一次完成 listing，返回结果会附加一个 <NextMarker>，提示继续 listing 可以以此为 marker。NextMarker 中的值仍在 list 结果之中。

5.在做条件查询时，即使 marker 实际在列表中不存在，返回也从符合 marker 字母排序的下一个开始打印。如果max-keys 小于0或者大于1000，将返回 400 Bad Request 错误。错误码：InvalidArgument。

6.若 prefix，marker，delimiter 参数不符合长度要求，返回 400 Bad Request。错误码：InvalidArgument。prefix，marker，delimiter 用来实现分页显示效果，参数的长度必须小于1000字节。