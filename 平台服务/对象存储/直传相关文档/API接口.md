# API接口

## API文档简介
直传服务是NOS推出的针对移动端或者Web端上传的一套解决方案，该方案优化了上传逻辑，上传更加快速、便捷。用户可以使用本文档提供的简单API接口，实现直传服务的上传逻辑。

## API接口

### DNS查询

#### 描述
用户客户端首先可以通过DNS服务查询得到最近的边缘加速节点IP列表，选择其中的IP进行上传.

#### 接口
	GET /lbs?version=${version}&bucketname=${bucketname}

#### 参数

|    名称    |            描述            | 是否必须 |
|------------|----------------------------|----------|
| lbs        | DNS查询的关键字            | 是       |
| version    | lbs的版本号字段，目前是1.0 | 是       |
| bucketname | 用户上传文件对应的桶名     | 否       |

#### 响应元素

返回json格式的内容，具体字段如下：

|  名称  |                       描述                      |
|--------|-------------------------------------------------|
| lbs    | 返回的最优的DNS地址，后续可以使用该地址进行上传 |
| upload | 返回最优的边缘节点列表，加速效果最好的在前面    |

#### 示例
查询test桶对应的最优上传节点：

http://lbs-eastchina1.126.net/lbs?version=1.0&bucketname=test

响应结果：

	{
	    "lbs": "http://106.2.45.249/lbs",
	    "upload": [
	        "http://106.2.45.251",
	        "http://106.2.45.250"
	    ]
	}

<span>Attention:</span><div class="alertContent">列表中加速效果好的节点排在前面，建议优先使用ip列表里面的第一个IP</div>

### 分片上传

#### 描述
此接口通过指定offset实现断点续传功能。用户每次上传要以服务器端返回的offset为准续传余下数据。

#### 接口

	POST /${bucketName}/${objectName}?offset=${offset}&complete=${complete}&context={context}&version=1.0 HTTP/1.1
	Host: $(host)
	Content-Length: ${length}
	Content-Type: ${contentType}
	Content-MD5: ${md5}
	x-nos-token: ${token}

	<data of body>

#### 参数
|      名称      |  类型  | 是否必须 |                                                                                                   描述                                                                                                   |
|----------------|--------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| host           | string | 是       | 上传的域名，为:nos-eastchina1.126.net                                                                                                                                                                    |
| bucketName     | string | 是       | 上传的桶名                                                                                                                                                                                               |
| objectName     | string | 是       | 上传的对象名                                                                                                                                                                                             |
| offset         | long   | 否       | 该分块在整个文件中的偏移，如果断点续传，可以使用查询接口获取offset                                                                                                                                       |
| complete       | string | 是       | 是否是最后一片，如果是则为true，不是为flase                                                                                                                                                              |
| context        | string | 否       | 上传上下文。本字段是只能被上传服务器解读使用的不透明字段，上传端不应修改其内容。用户不带此参数表示是第一次上传，之后上传剩余部分数据都需要带上这个参数。 context对应的桶名或者对象名不匹配返回400 code。 |
| x-nos-token    | string | 是       | 上传凭证，计算方法参考 上传凭证 :                                                                                                                                                                        |
| Content-Length | long   | 是       | 当前片的内容长度，单位：字节（Byte）。Content-Length合法值是[0,4M]，否则返回400 httpcode给客户端，拒绝本次请求                                                                                           |
| Content-type   | string | 否       | 标准http头。表示请求内容的类型，比如：image/jpeg。 仅第一次上传生效，续传不生效                                                                                                                          |
| Content-MD5    | string | 否       | 文件内容md5                                                                                                                                                                                              |


#### 响应元素
返回json格式的内容。

成功：

	HTTP/1.1 200 OK
	Content-Type:application/json;charset=utf-8

	{
	    "requestID":            "<RequestID          string>",
	    "offset":                <Offset             long>,
	    "context":              "<context            string>",
	}

|    名称   |  类型  |                                                                描述                                                                |
|-----------|--------|------------------------------------------------------------------------------------------------------------------------------------|
| requestID | string | uuid字符串， 服务器端生成的唯一UUID，用于记录日志排查问题使用                                                                      |
| offset    | long   | 下一个上传片在上传块中的偏移。注意：偏移从0开始，比如：用户上传0-128字节后，服务器返回的offset为128表示下一次上传从第129个字节开始 |
| context   | string | 上传上下文，后续分片采用该context上传                                                                                              |


失败：

	{
	    "requestID": "17b21e42ac11000001390ab891440240",
	    "errCode": "InvalidBucketName"
	    "errMsg": "bucketName = a/x.d, invalid bucketName"
	}

|    名称   |  类型  |                              描述                             |
|-----------|--------|---------------------------------------------------------------|
| requestID | string | uuid字符串， 服务器端生成的唯一UUID，用于记录日志排查问题使用 |
| errCode   | string | 错误简介                                                      |
| errMsg    | string | 返回的具体错误信息                                            |

状态码：

| HTTP状态码 |                                          含义                                          |
|------------|----------------------------------------------------------------------------------------|
|        200 | 上传成功                                                                               |
|        400 | 请求报文格式错误，报文构造不正确或者没有完整发送                                       |
|        403 | 上传凭证无效。凭证过期服务器会返回此错误码，用户需要重新申请凭证。                     |
|        500 | 服务端操作失败。如遇此错误，请将完整错误信息（包括所有HTTP响应头部）通过邮件发送给我们 |

#### 示例

发送请求为：

	POST /doc/anne.jpg?complete=false&version=1.0
	HOST: nos-eastchina1.126.net
	Content-Length: 12000
	Content-Type: image/jpeg
	Date: Wed, 01 Mar 2016 21:34:55 GMT                                                                                                                                     x-nos-token: UPLOAD b6ff5ed65d1041e9a56e2257a2672990:+SL08gyotpanS0qQdqugiWVdDSlsfrQr6YXUNw0Nkz4=:eyJCdWNrZXQiOiJkb2MiLCJPYmplY3QiOiJhbm5lLmpwZyIsIkV4cGlyZXMiOjE0OTEyMDB9

	<data of body>

响应内容：

HTTP/1.1 200 OK

	{
	  "requestID": "17b21e42ac11000001390ab891440240",
	  "offset": 12001
	}

### 断点查询

#### 描述
根据上传上下文查询对应分片上传当前续传的offset，上下文要与bucketName/objectName匹配，否则返回400错误码。(bucketName和objectName要进行URL编码,字符编码格式使用utf-8)

#### 接口
	GET /${bucketName}/${objectName}?uploadContext&context=${context}&version=1.0 HTTP/1.1
	Host: ${host}
	x-nos-token: ${token}
#### 参数

|     名称    |  类型  | 是否必须 |                                                                                                   描述                                                                                                   |
|-------------|--------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| host        | string | 是       | 查询的域名，为：nos-eastchina1.126.net                                                                                                                                                                   |
| bucketName  | string | 是       | 上传的桶名                                                                                                                                                                                               |
| objectName  | string | 是       | 上传的对象名                                                                                                                                                                                             |
| context     | string | 否       | 上传上下文。本字段是只能被上传服务器解读使用的不透明字段，上传端不应修改其内容。用户不带此参数表示是第一次上传，之后上传剩余部分数据都需要带上这个参数。 context对应的桶名或者对象名不匹配返回400 code。 |
| x-nos-token | string | 是       | 上传凭证，计算方法参考 上传凭证 :                                                                                                                                                                        |
| version     | string | 是       | http api版本号。这里是固定值1.0                                                                                                                                                                          |


#### 响应元素
返回json格式的内容。

成功：

	{
	    "requestID": "17b21e42ac11000001390ab891440240",
	    "offset": 1234
	}

|    名称   |  类型  |             描述             |
|-----------|--------|------------------------------|
| requestID | string | 服务器端生成的唯一UUID       |
| offset    | long   | 下一个上传片在上传块中的偏移 |

失败：

和上传的错误信息一致

状态码：

| HTTP状态码 |                                          含义                                          |
|------------|----------------------------------------------------------------------------------------|
|        200 | 查询分片成功                                                                           |
|        400 | 请求报文格式错误，报文构造不正确或者没有完整发送                                       |
|        403 | 上传凭证无效。token过期服务器会返回此错误码，用户需要重新申请token。                   |
|        404 | 对应context上传不存在                                                                  |
|        500 | 服务端操作失败。如遇此错误，请将完整错误信息（包括所有HTTP响应头部）通过邮件发送给我们 |


#### 示例
发送请求为：

	GET /doc/anne.jpg?uploadContext&context=17b21e42ac11000001390ab891440240&version=1.0
	HOST: nos-eastchina1.126.net
	Date: Wed, 01 Mar 2016 21:34:55 GMT
	x-nos-token: UPLOAD b6ff5ed65d1041e9a56e2257a2672990:+SL08gyotpanS0qQdqugiWVdDSlsfrQr6YXUNw0Nkz4=:eyJCdWNrZXQiOiJkb2MiLCJPYmplY3QiOiJhbm5lLmpwZyIsIkV4cGlyZXMiOjE0NTE0OTEyMDB9

响应为：

HTTP/1.1 200 OK

	{
	  "requestID": "17b21e42ac11000001390ab891440240",
	  "offset": 1234
	}






