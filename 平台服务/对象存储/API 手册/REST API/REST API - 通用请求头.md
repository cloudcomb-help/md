# REST API

以下几部分详细介绍 NOS Open API 的定义：前三章定义通用请求头、响应头、错误码；第四 章定义了桶相关操作 API；第五章定义了对象相关的操作 API；第六章定义了大对象分块上传 相关的操作 API；

### **通用请求头**
| **Header** |	             **描述**                |   **是否必须**   |
|------------|---------------------------------------|------------------|
|Authorization|	认证信息类型：字符串默认：无|	Yes|
|Content-Length|	RFC2616所定义的请求长度类型：字符串默认：无|	Conditional|
|Content-Type|	文件的类型类型：字符串默认：无|	No|
|Content-MD5	|HTTP BODYMD5值base64编码后的值，与md5sum结果一致，无效的Content-MD5将返回错误：InvalidDegest类型：字符串示例：fbacf535f27731c9771645a39863328默认：无|	No|
|Date|	请求的时间戳类型：字符串，格式必须符合RFC1123的日期格式示例：Wed, 01 Mar 2012 12:00:00 GMT默认：无|	Yes|
|Host|	请求资源的主机名，通常采用虚拟机风格描述类型：字符串示例：BucketName.nos-eastchina1.126.net默认：无|	Yes|
|x-nos-entity-type|	接口返回的格式，当前支持 xml 和 json 两种格式类型：字符串示例：有效取值：json、xml默认：xml|	No    |

