# 错误响应


当 API 请求发生错误时，服务端会返回相关错误信息。错误信息通常包含一个机器可读的错误码（code）和一个人类可读的错误信息（message），以及一个代表请求唯一性的ID（request_id）。

## 说明

### 响应语法

    {
      "code": number,
      "message": "string",
      "request_id": "string"
    }
    
### 响应元素

|    元素    |                                描述                                |
|------------|--------------------------------------------------------------------|
| code       | 日志订阅内部错误码，通常用于定位具体的错误。                       |
| message    | 请求错误原因，用于助于人类理解。                                   |
| request_id | 用于定位唯一请求ID，它能为我们提供一种机制来跟踪、诊断和调试请求。 |


### 示例

    HTTP/1.1 403 Forbidden
    Content-Type: application/json
    Content-Length: <PayloadSizeBytes>
    {
      "code": 40301,
      "message": "Request Time Too Skewed",
      "request_id": "bbffc270-1a77-4548-b995-ce729c105ba2"
    }


## 错误码

### 400 Bad Request

	40001	No Date Header Field
	40002	Invalid Date Format, Use: rfc-1123
	40003	No Content-Type Header Field
	40004	No Content Found
	40005	Request Content Format Error
	40006	Invalid Request Content
	40007	No Stored Position
	40008	No Host Header Field
	40009	Invalid Host

### 401 Unauthorized

	40101	No Authorization Header Field
	40102	No Authorization Tag
	40103	Authorization Format Error
	40104	Authorized Failed

### 403 Forbidden

	40301	Request Time Too Skewed

### 404 Not Found

	40401	Not Found
	40402	Subscription Not Exist

### 405 Method Not Allowed

	40501	Method Not Allowed

### 413 Request Entity Too Large

	41301	Content Length Too Large
	41302	Request Entity Too Large

### 414 Request URI Too Long

	41401	Request-URI Too Long

### 500 Internal Server Error

	50001	Internal Server Error
	50002	Read Entity Body Error
