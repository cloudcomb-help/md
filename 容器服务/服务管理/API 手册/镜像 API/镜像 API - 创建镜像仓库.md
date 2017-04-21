# 镜像 API

## 创建镜像仓库

### 请求 URL

`POST https://open.c.163.com/api/v1/repositories`

### 请求示例

```http
POST /api/v1/repositories HTTP/1.1
Authorization: Token 344957249da34e17925c2bbd531f6fdf
Content-Type: application/json

{
  "repo_name":"a/b/c",
  "open_level":0,
  "base_desc":"base_desc",
  "detail_desc":"detail_desc",
  "ci_support":1
}
```

### 请求参数

<span>Attention:</span><div class="alertContent">支持持续集成的镜像仓库必须私有，即 ci_support 为 1 时 open_level 必须为 0</div>

|     参数    |  类型  | 是否必填 |                               说明                              |   示例值    |
|-------------|--------|----------|-----------------------------------------------------------------|-------------|
| repo_name   | String | 是       | 镜像仓库名称（支持多级目录）                                    | a/b/c       |
| open_level  | int    | 是       | 公开级别，0（私有）/ 1（公开）                                  | 0           |
| base_desc   | String | 是       | 镜像仓库基本描述                                                | base_desc   |
| detail_desc | String | 是       | 镜像仓库详细描述                                                | detail_desc |
| ci_support  | int    | 否       | 镜像仓库是否支持持续集成，0（不支持）/ 1（支持），默认 0 不支持 | 1           |


### 响应示例

```
{
  "repo_id": 58807
}
```

### 响应参数


|   参数  | 类型 |     描述    | 示例值 |
|---------|------|-------------|--------|
| repo_id | long | 镜像仓库 id |  58807 |






