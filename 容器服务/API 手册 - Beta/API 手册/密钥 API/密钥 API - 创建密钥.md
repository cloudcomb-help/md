# 密钥 API

## 创建密钥

### 请求示例

    POST /api/v1/secret-keys HTTP/1.1
    Host: open.c.163.com
    Authorization: Token 48e6b1bdb5fb4a23a680a977dffb3c30
    Content-Type: application/json

    {
      "key_name": "mykey"
    }

### 请求参数

|   参数   |  类型  | 是否必填 |   描述   | 示例值 |
|----------|--------|----------|----------|--------|
| key_name | String | 否       | 密钥名称 | mykey  |


### 响应示例

    201 Created
    {
      "id": 119766,
      "name": "mykey",
      "fingerprint": "e7:a9:dd:85:2a:a8:fe:bd:34:35:e8:74:65:ac:e7:7e",
      "created_at": "2016-12-22T13:03:00Z"
    }

### 响应参数

|     参数    |  类型  |                              描述                             |                     示例值                      |
|-------------|--------|---------------------------------------------------------------|-------------------------------------------------|
| id          | long   | 密钥 id                                                       | 119766                                          |
| name        | String | 密钥名称                                                      | mykey                                           |
| fingerprint | String | 密钥指纹                                                      | e7:a9:dd:85:2a:a8:fe:bd:34:35:e8:74:65:ac:e7:7e |
| created_at  | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-22T13:03:00Z                            |

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。