# 镜像 API

## 删除镜像

删除某个镜像仓库内的某个镜像。

### 请求示例

	DELETE /api/v1/repositories/{repo_name}/tags/{tag} HTTP/1.1
	Host: open.c.163.com
	Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
	Content-Type:application/json

### 请求参数


|    参数   |  类型  | 是否必填 |     描述     |
|-----------|--------|----------|--------------|
| repo_name | String | 是       | 镜像仓库名称 |
| tag       | String | 是       | 镜像 tag     |

### 响应示例

    200 OK

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。