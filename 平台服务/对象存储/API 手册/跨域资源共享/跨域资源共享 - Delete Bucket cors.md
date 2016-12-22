# 跨域资源共享

## Delete Bucket cors

### 描述

Delete Bucket cors 用于关闭指定 Bucket 对应的 CORS 功能并清空所有规则。

### 语法

	DELETE /?cors HTTP/1.1
	Host: ${BucketName}.{endpoint}
	Date: ${date}
	Authorization: ${signature}

### 示例
Request

	DELETE /?cors HTTP/1.1
	HOST: dream.nos-eastchina1.126.net
	Date: Wed, 01 Mar 2012 21:34:55 GMT
	Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

	HTTP/1.1 200 OK
	x-nos-request-id: 17b21e42ac11000001390ab891440240
	Date: Wed, 01 Mar 2012 21:34:55 GMT
	x-nos-acl: private
	Connection: close
	Server: NOS