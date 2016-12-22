# 桶的操作

## Delete Bucket Website.md

### 描述
删除 bucket 的静态网站托管状态。

### 语法

	DELETE /?website HTTP/1.1
	Host: ${BucketName}.{endpoint}
	Date: ${date}
	Authorization: ${signature}

### 示例
Request

	DELETE /?website HTTP/1.1
	HOST: dream.nos-eastchina1.126.net
	Date: Fri, 10 Feb 2012 21:34:55 GMT
	Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE
	
Response

	HTTP/1.1 200 OK
	x-nos-request-id: 17b21e42ac11000001390ab891440240
	Date: Wed, 01 Mar 2012 21:34:55 GMT
	Connection: close
	Server: NOS