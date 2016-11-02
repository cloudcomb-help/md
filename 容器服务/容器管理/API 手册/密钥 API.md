# 密钥 API

### 创建密钥

请求 header

    POST /api/v1/secret-keys


    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


请求 payload

    {
      "key_name": "name"
    }



|参数说明	|描述	|类型	 | 是否必填|
|-----------|-------|--------|---------|
|key_name|密钥名称|	string	|可填|



### 响应
* 成功响应

   

     201 Created
        {
            "id": 163,
            "name": "name",
            "fingerprint": "1b:5c:23:7f:a6:68:0e:e0:b0:f9:54:53:55:e1:a4:84",
            "created_at": "2016-03-29T09:01:52Z"
        }

|参数说明	|描述	|类型	 |
|-----------|-------|--------|
|id	|密钥 id	|long	| 
|name|密钥名称	|string|
|fingerprint	|密钥指纹	|string|
|created_at	|创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|


* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

### 获取私钥文件

此接口每用户每秒访问次数为 300 次。

请求 header

    GET /api/v1/secret-keys/{id}
    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


|参数说明	|描述	|类型	 | 是否必填|
|-----------|-------|--------|---------|
|id	        |密钥 id|	long |     必填|


响应
* 成功响应

   

     200 OK
    [私钥文件内容]


* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

### 密钥列表

请求 header

    GET /api/v1/secret-keys
    
    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

响应

* 成功响应

   

     200 Ok
        
        [
            {
                "fingerprint": "85:9a:ac:b1:37:51:80:a5:9d:3a:ec:c0:8e:fe:5c:15",
                "id": 133,
                "name": "turing",
                "created_at": "2016-01-26T05:26:14Z"
            }
        ]



|参数说明|	描述|	  类型|
|--------|------|---------|
|id|	密钥id|	long|
|fingerprint|	密钥指纹|	string|
|name|	密钥名称|	string|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|	string|



* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

### 删除密钥

请求 header

    DELETE /api/v1/secret-key/{id}
    
    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json



|参数说明	|描述	|类型	 | 是否必填|
|-----------|-------|--------|---------|
|id	|密钥 id|	long|	必填|


响应
* 成功响应

   

     200 Ok

* 失败响应 详情请参见 [错误返回码](./OpenAPI错误响应.md)。
