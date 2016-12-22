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