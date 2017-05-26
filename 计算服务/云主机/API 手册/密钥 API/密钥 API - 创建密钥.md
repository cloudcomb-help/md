# 密钥 API

## 创建密钥

### 请求 header

    POST /api/v1/secret-keys

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


### 请求 payload

    {
      "key_name": "name"
    }

| 参数说明 |   描述   |  类型  | 是否必填 |
|----------|----------|--------|----------|
| key_name | 密钥名称 | string | 可填     |



### 响应
#### 成功响应

     201 Created
        {
            "id": 163,
            "name": "name",
            "fingerprint": "1b:5c:23:7f:a6:68:0e:e0:b0:f9:54:53:55:e1:a4:84",
            "created_at": "2016-03-29T09:01:52Z"
        }

|   参数说明  |                              描述                             |  类型  |
|-------------|---------------------------------------------------------------|--------|
| id          | 密钥 id                                                       | long   |
| name        | 密钥名称                                                      | string |
| fingerprint | 密钥指纹                                                      | string |
| created_at  | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | string |

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!计算服务/容器服务/API 手册/OpenAPI 错误响应.md)。