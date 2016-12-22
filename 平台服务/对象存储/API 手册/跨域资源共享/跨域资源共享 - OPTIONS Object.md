# 跨域资源共享

## OPTIONS Object

### 描述

对于非简单跨域请求，浏览器在发送跨域请求之前会发送一个 preflight 请求（OPTIONS）并带上特定的来源域、HTTP 方法和 header 信息等给 NOS 以决定是否发送真正的请求。 NOS 可以通过 Put Bucket cors 接口来开启 Bucket 的 CORS 支持，开启 CORS 功能之后，NOS 在收到浏览器 preflight 请求时会根据设定的规则评估是否允许本次请求。如果不允许或者 CORS 功能没有开启，返回 403 Forbidden。

### 语法

	OPTIONS /ObjectName HTTP/1.1
	Date: ${date}
	Host: ${BucketName}.{endpoint}
	Origin: origin
	Access-Control-Request-Method: HTTP method
	Access-Control-Request-Headers: Request Headers

### 请求头

|              元素              |                                                    描述                                                    | 是否必须 |
|--------------------------------|------------------------------------------------------------------------------------------------------------|----------|
| Origin                         | 请求来源域，用来标示跨域请求。<br>类型：字符串<br>默认：无                                                 | Yes      |
| Access-Control-Request-Method  | 表示在实际请求中将会用到的方法。<br>类型：字符串<br>默认：无                                               | Yes      |
| Access-Control-Request-Headers | 表示在实际请求中会用到的除了简单头部之外的 headers，多个 header 则逗号分隔，大小写不敏感。<br>类型：字符串 | No       |

### 响应头
返回 200 OK 时，携带如下响应消息头：

|              元素             |                                                           描述                                                          |                       是否必须                       |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| Access-Control-Allow-Origin   | 请求中的 Origin 值，如果不允许的话将不包含该头部。<br>类型：字符串                                                      | Yes                                                  |
| Access-Control-Allow-Methods  | 允许请求的 HTTP 方法，返回请求中 Access-Control-Request-Method 的值。如果不允许该请求，则不包含该头部。<br>类型：字符串 | Yes                                                  |
| Access-Control-Allow-Headers  | 允许请求携带的 header 的列表，逗号分隔，如果请求中有不被允许的 header，则不包含该头部，请求也将被拒绝。<br>类型：字符串 | 返回请求中Access-Control-Request-Headers的值（若有） |
| Access-Control-Expose-Headers | 允许在客户端 JavaScript 程序中访问的 headers 的列表，逗号分隔。返回匹配到的 CORS 规则的 ExposeHeader。<br>类型：字符串  | 有则返回                                             |
| Access-Control-Max-Age        | 允许浏览器缓存 preflight 结果的时间，单位为秒。返回匹配到的 CORS 规则的 MaxAgeSeconds。<br>类型：整型                   | 有则返回                                             |

### 示例
Request

	OPTIONS /testobject HTTP/1.1
	Host: dream.nos-eastchina1.126.net
	Date: Fri, 24 Feb 2012 05:45:34 GMT
	Origin:http://www.example.com
	Access-Control-Request-Method:PUT
	Access-Control-Request-Headers:x-nos-token

Response

	HTTP/1.1 200 OK
	Access-Control-Allow-Origin: http://www.example.com
	Access-Control-Allow-Methods: PUT
	Access-Control-Expose-Headers: x-nos-token

### 细节描述

1. 桶不存在时，返回 404，错误码 NOSuchBucket。