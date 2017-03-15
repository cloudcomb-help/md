# 镜像 API

## 删除镜像

删除某个镜像仓库内的某个镜像。

### 请求 URL

`DELETE https://open.c.163.com/api/v1/repositories/{mysql}/tags/{tag}`

### 请求示例

```http
DELETE /api/v1/repositories/mysql/tags/v1 HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
Content-Type:application/json
```

### 请求参数

|    参数   |  类型  | 是否必填 |     描述     |
|-----------|--------|----------|--------------|
| repo_name | String | 是       | 镜像仓库名称 |
| tag       | String | 是       | 镜像 tag     |
