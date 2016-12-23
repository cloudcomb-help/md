# 密钥 API

## 获取密钥列表

### 请求示例

    GET /api/v1/cloud-volumes?limit=10&amp;offset=0 HTTP/1.1
    Host: open.c.163.com
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数

|  参数  | 类型 | 是否必填 |                        描述                       | 示例值 |
|--------|------|----------|---------------------------------------------------|--------|
| limit  | int  | 否       | 每次获取的云硬盘个数，大于 0 小于等于 20，默认 20 |     20 |
| offset | int  | 否       | 获取云硬盘列表起始位置，默认 0                    |      0 |

### 响应示例

    200 OK
    [
      {
        "id": 119766,
        "name": "mykey",
        "fingerprint": "e7:a9:dd:85:2a:a8:fe:bd:34:35:e8:74:65:ac:e7:7e",
        "created_at": "2016-12-22T13:03:00Z"
      },
      {
        "id": 119646,
        "name": "mykey2",
        "fingerprint": "39:11:74:90:6c:bc:12:56:03:8b:a4:46:df:d7:c1:2c",
        "created_at": "2016-12-21T02:53:21Z"
      }
    ]

### 响应参数

|     参数    |  类型  |                              描述                             |                     示例值                      |
|-------------|--------|---------------------------------------------------------------|-------------------------------------------------|
| id          | long   | 密钥 id                                                       | 119766                                          |
| name        | String | 密钥名称                                                      | mykey                                           |
| fingerprint | String | 密钥指纹                                                      | e7:a9:dd:85:2a:a8:fe:bd:34:35:e8:74:65:ac:e7:7e |
| created_at  | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-22T13:03:00Z                            |

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。