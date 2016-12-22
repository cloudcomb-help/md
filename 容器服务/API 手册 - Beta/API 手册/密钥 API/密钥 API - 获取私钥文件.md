# 密钥 API

## 获取私钥文件

<span>Note:</span><div class="alertContent">此接口每用户每秒访问次数为 300 次。</div>

### 请求示例

	GET /api/v1/secret-keys/{id} HTTP/1.1
	Host: open.c.163.com
	Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
	Content-Type: application/json

### 请求参数

| 参数 | 类型 | 是否必填 |   描述  | 
|------|------|----------|---------|
| id   | long | 是       | 密钥 id |


### 响应示例

    200 OK
    -----BEGIN RSA PRIVATE KEY-----
	MIIEpAIBAAKCAQEAqARla6u0o+hDkoZ6xXRq1IiuAEwL4q1UpAXzMMthXIfllu38
	wR871yAOR5Y`````私钥文件内容`````oB+b8GTFS9bipE4zgI6Ttxxu0du/B6Q
	vkLu1Imf0etmoa+J9icqdEO2tBSCl67R1gBmM1BjY2tVEBOa8wNRYQ==
	-----END RSA PRIVATE KEY-----

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。