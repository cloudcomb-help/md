# 用户 API

## 生成 API Token

通过 Access Key 和 Access Secret 获取 Token。[点我查看 APP Key 及 APP Secret](https://c.163.com/dashboard#/m/account/accesskey/)

<span>Note:</span><div class="alertContent">Token 有效期为 24 小时。</div>

### 请求示例

	POST /api/v1/token HTTP/1.1
	Host: open.c.163.com
	Content-Type: application/json

	{
	    "app_key": "19275e8b113f48e1b0c5ce0d6f1647a8", 
	    "app_secret": "e9846f12c8e44edc8b0d4df065e5cd89"
	}

### 请求参数

|    参数    |  类型  | 是否必填 |        描述        |              示例值              |
|------------|--------|----------|--------------------|----------------------------------|
| app_key    | String | 是       | 用户 Access Key    | 19275e8b113f48e1b0c5ce0d6f1647a8 |
| app_secret | String | 是       | 用户 Access Secret | e9846f12c8e44edc8b0d4df065e5cd89 |



### 响应示例

	201 Created
	{
	  "token": "48e6b1bdb5fb4a28a680a97adffb3c30",
	  "expires_in": "86399"
	}

### 响应参数

|    参数    |  类型  |             描述             |              示例值              |
|------------|--------|------------------------------|----------------------------------|
| token      | String | 访问 API 的授权码            | 48e6b1bdb5fb4a28a680a97adffb3c30 |
| expires_in | String | API 授权码的失效时间，单位秒 | 86399                            |

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。