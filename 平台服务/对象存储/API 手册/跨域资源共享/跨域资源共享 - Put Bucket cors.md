# 跨域资源共享

## Put Bucket cors

### 描述

Put Bucket cors 操作将在指定的 bucket 上设定一个跨域资源共享（CORS）的规则，如果原规则存在则覆盖原规则。

### 请求语法

	PUT /?cors HTTP/1.1
	Host:  ${BucketName}.${endpoint}
	Content-Length: ${length}
	Date: ${date}
	Authorization: ${signature}
	Content-MD5: ${md5}

	<CORSConfiguration>
	  <CORSRule>
	     <AllowedOrigin>the origin you want allow CORS request from</AllowedOrigin>
	     <AllowedMethod>HTTP method</AllowedMethod>
	     <AllowedHeader> headers that allowed browser to send</AllowedHeader>
	     <ExposeHeader> headers in response that can access from client app</ExposeHeader>
	     <MaxAgeSeconds>time to cache pre-fight response</MaxAgeSeconds>
	  </CORSRule>
	  <CORSRule>
	     …
	  </CORSRule>
	     …
	</CORSConfiguration >

### 请求参数

|        参数       |                                                                                                                                                 描述                                                                                                                                                | 是否必须 |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| CORSConfiguration | Bucket 的 CORS 规则容器，可以指定 1-10 条 CORS 规则<br>类型：容器<br>默认：无                                                                                                                                                                                                                       | Yes      |
| CORSRule          | CORS 规则<br>类型：容器<br>默认：无                                                                                                                                                                                                                                                                 | Yes      |
| AllowedOrigin     | 指定允许的跨域请求的来源，多个则以逗号分隔。每个来源字符串中允许使用最多一个‘\*’通配符。如果来源指定为‘\*’则表示允许所有的来源的跨域请求。<br>类型：非空字符串                                                                                                                                        | Yes      |
| AllowedMethod     | 指定允许的跨域请求方法。<br>类型：枚举（GET、PUT、DELETE、POST、HEAD），多个则以逗号分隔<br>默认：无                                                                                                                                                                                                | Yes      |
| AllowedHeader     | 逗号分隔的 header 列表，控制在 OPTIONS 预取指令中 Access-Control-Request-Headers 头中指定的 header 是否允许。在 Access-Control-Request-Headers 中指定的每个 header 都必须在 AllowedHeader 中有一条对应的项。AllowedHeader 中的 header 值允许使用最多一个‘*’通配符。<br>类型：非空字符串<br>默认：无 | No       |
| ExposeHeader      | 指定允许用户从应用程序中访问的响应头（例如一个 Javascript 的 XMLHttpRequest 对象。）不允许使用‘*’通配符。<br>类型：非空字符串<br>默认：无                                                                                                                                                           | No       |
| MaxAgeSeconds     | 指定浏览器对特定资源的预取（OPTIONS）请求返回结果的缓存时间，单位为秒。<br>类型：整型 <br>默认：无                                                                                                                                                                                                  | No       |

### 示例
Request

	PUT /?cors HTTP/1.1
	Host: dream.nos-eastchina1.126.net
	Content-Length: 186
	Date: Fri, 04 May 2016 03:21:12 GMT
	Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

	<?xml version="1.0" encoding="UTF-8"?>
	<CORSConfiguration>
	  <CORSRule>
	     <AllowedOrigin>*</AllowedOrigin>
	     <AllowedMethod>PUT</AllowedMethod>
	     <AllowedHeader>Authorization</AllowedHeader>
	  </CORSRule>
	  <CORSRule>
	     <AllowedOrigin>http://www.a.com,http://www.b.com</AllowedOrigin>
	     <AllowedMethod>GET</AllowedMethod>
	     <AllowedHeader>Authorization</AllowedHeader>
	     <ExposeHeader>x-nos-test,x-nos-test1</ExposeHeader>
	     <MaxAgeSeconds>100</MaxAgeSeconds>
	  </CORSRule>
	</CORSConfiguration>

Response

	HTTP/1.1 200 OK
	x-nos-request-id: 17b21e42ac11000001390ab891440240
	Date: Wed, 01 Mar 2012 21:34:55 GMT
	Connection: close
	Server: NOS

### 细节描述
1. 为了在应用程序中使用 CORS 功能，比如从一个 www.a.com 的网址通过浏览器的 XMLHttpRequest 功能来访问 NOS，需要通过本接口上传 CORS 规则来开启。
2. 每个 bucket 的 CORS 设定是由多条 CORS 规则指定的，每个 bucket 最多允许 10 条规则，上传的 XML 文档最多允许 16 KB 大小。
3. 当 NOS 收到一个跨域请求（或者 OPTIONS 请求），会读取 bucket 对应的 CORS 规则，然后进行相应的权限检查。NOS 会依次检查每一条规则，使用第一条匹配的规则来允许请求并返回对应的 header。如果所有规则都匹配失败则不附加任何 CORS 相关的 header。
4. CORS 规则匹配成功必须满足三个条件，首先，请求的 Origin 必须匹配一项 AllowedOrigin 值，其次，请求的方法（如GET、PUT等）或者 OPTIONS 请求的 Access-Control-Request-Method 头对应的方法必须匹配一项 AllowedMethod 值，最后，OPTIONS 请求的 Access-Control-Request-Headers 头包含的每个 header 都必须匹配一项 AllowedHeader 值。