# 镜像 API

## 镜像仓库列表

### 请求 header

    GET /api/v1/repositories

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

### 请求参数

    limit=20&offset=0

| 参数说明 |             描述            | 类型 | 是否必填 |
|----------|-----------------------------|------|----------|
| limit    | 大于 0 小于等于 30，默认 20 | int  | 可填     |
| offset   | 偏移量，大于等于 0，默认 0  | int  | 可填     |

### 响应

#### 成功响应

    200 Ok
    {
        "total": 1,
        "repositories": [
            {
                "repo_id": 399,
                "user_name": "user",
                "repo_name": "name",
                "open_level": 0,
                "base_desc": "base_desc",
                "detail_desc": "desc",
                "tag_count": 0,
                "created_at": "2016-03-15T02:43:01Z",
                "updated_at": "2016-03-15T02:43:01Z"
            }
        ]
    }

|   参数说明  |                              描述                             |  类型  |
|-------------|---------------------------------------------------------------|--------|
| repo_id     | 镜像仓库 id                                                   | long   |
| user_name   | 用户名                                                        | string |
| repo_name   | 镜像仓库库名                                                  | string |
| open_level  | 开放级别，0 (私有 ) / 1 (公有)                                | int    |
| base_desc   | 基本描述                                                      | string |
| detail_desc | 详细描述                                                      | string |
| tag_count   | 版本数量                                                      | int    |
| created_at  | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | string |
| updated_at  | 修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | string |

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/OpenAPI 错误响应.md)。