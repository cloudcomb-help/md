# 对象操作
### **PUT Obejct Meta**

#### **描述**
修改获取对象时的 HTTP 响应的响应首部。

#### **语法**

    PUT /${ObjectKey}?meta HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Content-Length: ${length}
    Content-MD5: ${md5}
    Authorization: ${signature}
    Content-Type: ${type}
    Content-Encoding: ${encoding}
    Cache-Control : ${cache-control}
    Expires : ${expires}
    Content-Disposition : ${disposition}
    Content-Language : ${language}

#### **请求头**
|**Header**|                       **描述**                        |**是否必须**|
|----------|-------------------------------------------------------|------------|
|Content-Type|  对象所属类型 类型：字符串 默认：application/octet-stream|  NO|
|Content-Encoding|  对象编码格式 类型：字符串 默认：无| NO|
|Cache-Control| 对象缓存控制 类型：字符串 默认：无| NO|
|Expires|   缓存的失效日期 类型：字符串 默认：无|    NO|
|Content-Disposition|   对象的默认文件名 类型：字符串 默认：无|   NO|
|Content-Language|  对象内容所属语言 类型：字符串 默认：无|   NO|
|x-nos-meta-|   以该前缀开头的header都将被认为是用户自定义的元数据，比如：x-nos-meta-title: TITLE 这个header会把title:TITLE作为用户自定义元数据key-value对。 类型：字符串 默认：无| NO|

#### **示例**
Request

    PUT /2.jpg?meta HTTP/1.1
    HOST: photo.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
    Content-Type: image/jpeg
    Content-Encoding: utf-8
    Cache-Control: max-age=0
    Expires: Fri, 10 Feb 2012 21:34:55 GMT
    Content-Language: en

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS

#### **细节描述**

1.如果要修改的 Object 不存在，返回 404 Not Found。

2.如果用户输入非法的 Content-Type 则 Content-Type 自动为 application/octet-stream ，其他参数不检验合法性。

3.如果用户使用 PutObjectMeta 接口中没有指定某项元数据，那么认为该元数据在本次修改中设置为空；如果 Content-Type 没有指定，统一把 Content-type 修改为 application/octet-stream。

4.Content-Disposition 如果没有对应的记录，使用 GET Object 接口时通过默认的规则返回。默认的规则是根据对象的 objectname生成。

5.本接口的权限控制类型与PUT Object一致。