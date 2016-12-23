# 镜像 API

## 获取镜像仓库列表

### 请求示例

    GET /api/v1/repositories?limit=20&offset=0 HTTP/1.1
    Host: open.c.163.com
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数

|  参数  | 类型 | 是否必填 |                描述               | 示例值 |
|--------|------|----------|-----------------------------------|--------|
| limit  | int  | 否       | 分页，大于 0 小于等于 30，默认 20 |     20 |
| offset | int  | 否       | 偏移量，大于等于 0，默认 0        |      0 |


### 响应示例

    200 OK
    {
      "total": 2,
      "repositories": [
        {
          "repo_id": 45433,
          "user_name": "admin",
          "repo_name": "mysql",
          "open_level": 0,
          "base_desc": "基本描述",
          "detail_desc": "详细描述",
          "tag_count": 2,
          "created_at": "2016-12-21T02:27:12Z",
          "updated_at": "2016-12-21T02:27:12Z"
        },
        {
          "repo_id": 44627,
          "user_name": "admin",
          "repo_name": "axure",
          "open_level": 0,
          "base_desc": "basedesc",
          "detail_desc": "detaildesc",
          "tag_count": 5,
          "created_at": "2016-12-15T06:50:20Z",
          "updated_at": "2016-12-15T08:28:44Z"
        }
      ]
    }

### 响应参数

|     参数    |  类型  |                              描述                             |        示例值        |
|-------------|--------|---------------------------------------------------------------|----------------------|
| repo_id     | long   | 镜像仓库 id                                                   | 45433                |
| user_name   | String | 用户名                                                        | admin                |
| repo_name   | String | 镜像仓库库名                                                  | mysql                |
| open_level  | int    | 开放级别，0 （私有）/1（公有）                                | 0                    |
| base_desc   | String | 基本描述                                                      | 基本描述             |
| detail_desc | String | 详细描述                                                      | 详细描述             |
| tag_count   | int    | 版本数量                                                      | 2                    |
| created_at  | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-21T02:27:12Z |
| updated_at  | String | 修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-21T02:27:12Z |


### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。





