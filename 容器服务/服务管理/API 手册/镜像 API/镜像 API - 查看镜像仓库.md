# 镜像 API

## 查看镜像仓库

### 请求 header

    GET /api/v1/repositories/{id}

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

| 参数说明 |     描述    | 类型 | 是否必填 |
|----------|-------------|------|----------|
| id       | 镜像仓库 id | long | 必填     |

### 响应

#### 成功响应

    200 Ok
    {
        "tags": [
            {
                "name": "430",
                "size": 190425418,
                "status": 2
            },
            {
                "name": "latest",
                "size": 190425418,
                "status": 2
            }
        ],
        "repo_id": 399,
        "user_name": "wutaigong",
        "repo_name": "fafafa",
        "open_level": 0,
        "base_desc": "base_desc",
        "detail_desc": "desc",
        "tag_count": 2,
        "download_url": null,
        "created_at": "2016-03-15T02:43:01Z",
        "updated_at": "2016-03-24T07:05:37Z"
    }

|   参数说明  |                               描述                              |  类型  |
|-------------|-----------------------------------------------------------------|--------|
| repo_id     | 镜像仓库 id                                                     | long   |
| user_name   | 用户名                                                          | string |
| repo_name   | 镜像仓库名                                                      | string |
| open_level  | 开放级别，0 (私有) / 1 (公有)                                   | int    |
| base_desc   | 基本描述                                                        | string |
| detail_desc | 详细描述                                                        | string |
| tag_count   | 版本数量                                                        | int    |
| created_at  | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化   | string |
| updated_at  | 修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化   | string |
| name        | 镜像 tag                                                        | string |
| size        | 镜像大小，单位 B                                                | long   |
| status      | 镜像状态，0 (初始化) / 1 (构建中) / 2 (构建成功) / 3 (构建失败) | int    |

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/OpenAPI 错误响应.md)。