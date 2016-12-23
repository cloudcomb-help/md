# 密钥 API

## 删除密钥

通过[查看密钥列表](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/密钥 API/密钥 API - 查看密钥列表.md)获取的密钥 id 删除密钥。
### 请求示例

	DELETE /api/v1/secret-keys/{id} HTTP/1.1
	Host: open.c.163.com
	Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
	Content-Type: application/json

### 请求参数

| 参数 | 类型 | 是否必填 |   描述  | 
|------|------|----------|---------|
| id   | long | 是       | 密钥 id |


### 响应示例

     200 OK

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。