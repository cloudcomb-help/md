# 跨域资源共享

## Get Bucket cors

### 描述

Get Bucket cors 操作用于获取指定的 Bucket 目前的 CORS 规则，返回 PUT Bucket cors 请求的 body。

### 语法

	GET /?cors HTTP/1.1
	Host: ${BucketName}.{endpoint}
	Content-Length: ${length}
	Date: ${date}
	Authorization: ${signature}

### 响应元素


|        参数       |                                                                                                                                                 描述                                                                                                                                                | 是否必须 |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| CORSConfiguration | Bucket 的 CORS 规则容器，可以指定 1-10 条 CORS 规则<br>类型：容器<br>默认：无                                                                                                                                                                                                                       | Yes      |
| CORSRule          | CORS 规则<br>类型：容器<br>默认：无                                                                                                                                                                                                                                                                 | Yes      |
| AllowedOrigin     | 指定允许的跨域请求的来源，多个则以逗号分隔。每个来源字符串中允许使用最多一个‘\*’通配符。如果来源指定为‘\*’则表示允许所有的来源的跨域请求。<br>类型：非空字符串                                                                                                                                        | Yes      |
| AllowedMethod     | 指定允许的跨域请求方法。<br>类型：枚举（GET、PUT、DELETE、POST、HEAD），多个则以逗号分隔<br>默认：无                                                                                                                                                                                                | Yes      |
| AllowedHeader     | 逗号分隔的 header 列表，控制在 OPTIONS 预取指令中 Access-Control-Request-Headers 头中指定的 header 是否允许。在 Access-Control-Request-Headers 中指定的每个 header 都必须在 AllowedHeader 中有一条对应的项。AllowedHeader 中的 header 值允许使用最多一个‘*’通配符。<br>类型：非空字符串<br>默认：无 | No       |
| ExposeHeader      | 指定允许用户从应用程序中访问的响应头（例如一个 Javascript 的 XMLHttpRequest 对象）。不允许使用‘*’通配符。<br>类型：非空字符串<br>默认：无                                                                                                                                                           | No       |
| MaxAgeSeconds     | 指定浏览器对特定资源的预取（OPTIONS）请求返回结果的缓存时间，单位为秒。<br>类型：整型 <br>默认：无                                                                                                                                                                                                  | No       |

### 示例
Request

	GET /cors HTTP/1.1
	HOST: dream.nos-eastchina1.126.net
	Date: Wed, 01 Mar 2012 21:34:55 GMT
	Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

HTTP/1.1 200

	<CORSConfiguration>
	   <CORSRule>
	      <AllowedOrigin>{origin}</AllowedOrigin>
	      <AllowedMethod>{method}</AllowedMethod>
	      <AllowedHeader>{header}</AllowedHeader>
	      <ExposeHeader>{exposeheader}</ExposeHeader>
	      <MaxAgeSeconds>{age}</MaxAgeSeconds>
	   </CORSRule>
	   <CORSRule>
	      ...
	   </CORSRule>
	      ...
	</CORSConfiguration>

### 细节描述
1. 如果 CORS 规则不存在，返回 404 Not Found 错误，错误码 NoSuchCORSConfiguration。