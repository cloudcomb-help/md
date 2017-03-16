# 镜像 

## 查看镜像仓库

通过 [获取镜像仓库列表](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/镜像 API/镜像 API - 获取镜像仓库列表.md) 获取的镜像仓库 id 查看某个镜像仓库的具体信息。

### 请求 URL

`GET https://open.c.163.com/api/v1/repositories/{id}`

### 请求示例

```http
GET /api/v1/repositories/45433 HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
```

### 请求参数

| 参数 | 类型 |                是否必填                |     描述    |
|------|------|----------------------------------------|-------------|
| id   | long | 是（[获取镜像仓库列表](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/镜像 API/镜像 API - 获取镜像仓库列表.md)） | 镜像仓库 id |

### 响应示例

```json
{
  "tags": [
    {
      "name": "master20161215042831791",
      "size": 190425418,
      "status": 2
    },
    {
      "name": "master20161215034013640",
      "size": 0,
      "status": 2
    }
  ],
  "repo_id": 45433,
  "user_name": "admin",
  "repo_name": "mysql",
  "open_level": 0,
  "base_desc": "基本描述",
  "detail_desc": "详细描述",
  "tag_count": 2,
  "download_url": "hub.c.163.com/admin/mysql:master20161215042831791",
  "created_at": "2016-12-15T06:50:20Z",
  "updated_at": "2016-12-15T08:28:44Z"
}
```

### 响应参数

|   参数说明   |  类型  |                               描述                              |                      示例值                       |
|--------------|--------|-----------------------------------------------------------------|---------------------------------------------------|
| name         | String | 镜像 tag                                                        | master20161215042831791                           |
| size         | long   | 镜像大小，单位 B                                                | 190425418                                         |
| status       | int    | 镜像状态，0 (初始化) / 1 (构建中) / 2 (构建成功) / 3 (构建失败) | 2                                                 |
| repo_id      | long   | 镜像仓库 id                                                     | 45433                                             |
| user_name    | String | 用户名                                                          | admin                                             |
| repo_name    | String | 镜像仓库名                                                      | mysql                                             |
| open_level   | int    | 开放级别，0（私有）/1（公有）                                   | 0                                                 |
| base_desc    | String | 基本描述                                                        | 基本描述                                          |
| detail_desc  | String | 详细描述                                                        | 详细描述                                          |
| tag_count    | int    | 版本数量                                                        | 2                                                 |
| download_url | String | docker pull 地址                                                | hub.c.163.com/admin/mysql:master20161215042831791 |
| created_at   | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化   | 2016-12-15T06:50:20Z                              |
| updated_at   | String | 修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化   | 2016-12-15T08:28:44Z                              |
