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
	wR871yAOR5Y6GNZmsNcHTqGgLwtrq9tQl36nTkfQVMnnSU7fvVsAzgqLrkWULSr+
	hWtNYyBqyhNQvzDADYFfBS3a8e7uGfvYYu+707jgijC1ZRELzTLw8LU2hKh/XRw5
	WLTwTkLxjarHZienNisAKGT5LB/155B57R4Zw1+cDqOD6PCz9DOUG6gE13nTGVdB
	aRx/v8QK6HRHB+9Kzeg25+PRIpNo2AF3/ASEx/eyyQVrOseautHHXfJ0f60Nja4z
	0EQpdIRvO/hrfxm+8UBH1qAbNOQvYVFLSdINjwIDAQABAoIBAQCMhNi52ypB5zAU
	bMpjN8FdLU6xSuip1SMz5xIEXiR4eePHfhTlA5VNjy7CKl8+hJnwDna7CavpjJip
	a8wUV8XfT2pqb04zXnb7bA1ZQrKdtu19dTbXKO3ZGLSXet4OeNw2r1tj/nzd2GFk
	c9/+ptek9Ds++AvN4hsXrCIcfsIw4Ut001zv8U0NiKtQjljUUGBbyZ1baDYjpWsb
	bkKWO+ugFG/p0XBMiWe+E0yHy4jP+TK/IIPUV+h7BaDFNpCks6uK21JqIODMzhzn
	CDKRr79FOvFq9bmuQ7TXWSNjj2kxVOq+xRyWABUgNd6x8haKYtyrsg7vU4tvu6QW
	SdLgLcD5AoGBAN+0naAhoZdgrqUQReZZBcbjSy52ypMVf+65GJGk3G9ZNq3tt9lf
	cVMy1HNn5QXii3xhsnYo1cZ9wo17o26YH6eN3eze9Hx8rLfNjZGe3SKz740s80Mg
	oUh1GKwAQfDR0GzFEsi63sujbXRlULn5MHlO+mQj/eLsnBobdXwtSNWVAoGBAMBF
	uyA3nvTG+TP6PGlI6QqT7S0k171lf+B3uGTo/O3fQY7q1Vvdnvy7ePGnpCYCiVHa
	j1P+JYMKuWGv6EdL+N5apQBb3CTpT+96BzLC5+yHYDehF1VWP8VdascO97IFoZKc
	HZ05WifFnTfFniPKqki6VlFRzPdcGmyYO/1lpYWTAoGAPbw0e8qMM6Bk0fypraYH
	qBl11/7EbM7UHWdLVnYutzPhmSIvSHfEaHdwleCoHXWllM/JVj5ysHJoTG9AbPbi
	VXUbN5FX2zr010yMsxEqabdKdqVfBLluiPZ3to/jorfkUwAX7PkufDA/to13N7uD
	GxcmlpgwKn2tnq7RP1Gn9fkCgYAAuYKOCYeg1osj5gKKRwsRziLrs6LYhORpfSoF
	v1cMsnW1yy7IrNoni7FV/9K/jezkkRVPNLsBdm3ib15JvoCOnfrXOIFo5jQ169jR
	GSj0nEIBk6rZ2HxfCw4W9/h5BEpqmgoGiKvNUJJaHnWNHvtrUMB4h/1kxUUYOa6o
	MtTf3wKBgQDPbSYqqOX+0+zuXsAVAtaRBJGg5yBpfHGG/J9569WKuD3WFYFbaqSs
	lN8p5mYuKX2tk713gjkuTteua6Ldhc4VAoB+b8GTFS9bipE4zgI6Ttxxu0du/B6Q
	vkLu1Imf0etmoa+J9icqdEO2tBSCl67R1gBmM1BjY2tVEBOa8wNRYQ==
	-----END RSA PRIVATE KEY-----

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。