# 对象操作
### **PUT Object - Move**

#### **描述**
远程移动操作，生成一个新的对象，相当于”一次COPY”+”一次DELETE”，但不涉及物理文件的 拷贝动作，仅仅修改元数据，不支持跨桶 move 操作。

#### **语法**

    PUT /${DestinationObjectKey} HTTP/1.1
    HOST: ${DestinationBucketName}.${endpoint}
    Date: ${date}
    x-nos-move-source: /${SourceBucketName}/${SourceObjectKey}
    Authorization: ${signature}

#### **请求头定义**
|  **参数**  |                     **描述**                     |**是否必须**|
|------------|------------------------------------------------|------------|
|x-nos-move-source| 对象原来的桶号和名称 类型：字符串 默认：无 限制：该字符串必须做一下URL Encode，并且对该桶有读权限 |YES|

#### **示例**
Request

    PUT /1.jpg HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Type: image/jpeg
    Content-Length: 4096
    Content-MD5: fbacf535f27731c9771645a39863328
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    
    [4096 bytes of Object data]

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 12 Oct 2012 17:50:00 GMT
    ETag: fbacf535f27731c9771645a39863328
    Connection: close
    Server: NOS