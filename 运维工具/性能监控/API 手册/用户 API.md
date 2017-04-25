# 用户 API

## 生成 API Token

<span>Note:</span><div class="alertContent">Token 有效期为 24 小时。</div>

### 请求 header
 
	POST /api/v1/token 
	
	Content-Type:application/json

### 请求 payload

    {
      "app_key":"xxxxxx",
      "app_secret":"yyyyyy"
    }

|  参数说明  |        描述        |  类型  | 是否必填 |
|------------|--------------------|--------|----------|
| app_key    | 用户 Access Key    | string | 必填     |
| app_secret | 用户 Access Secret | string | 必填     |
[点我查看 APP Key 及 APP Secret](https://c.163.com/dashboard#/m/account/accesskey/)

### 响应
#### 成功响应

	201 Created
	{
	    "token":"zzzzzz",
	    "expires_in":"86400"
	}


|  参数说明  |             描述             |  类型  |
|------------|------------------------------|--------|
| token      | 访问 API 的授权码            | string |
| expires_in | API 授权码的失效时间，单位秒 | string |

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/镜像仓库/API 手册/OpenAPI 错误响应.md)。

