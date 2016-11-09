# 密钥 API

## 查看密钥列表

### 请求 header

    GET /api/v1/secret-keys
    
    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

### 响应

#### 成功响应

     200 Ok
        
        [
            {
                "fingerprint": "85:9a:ac:b1:37:51:80:a5:9d:3a:ec:c0:8e:fe:5c:15",
                "id": 133,
                "name": "turing",
                "created_at": "2016-01-26T05:26:14Z"
            }
        ]

|   参数说明  |                              描述                             |  类型  |
|-------------|---------------------------------------------------------------|--------|
| id          | 密钥id                                                        | long   |
| fingerprint | 密钥指纹                                                      | string |
| name        | 密钥名称                                                      | string |
| created_at  | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | string |

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/OpenAPI 错误响应.md)。