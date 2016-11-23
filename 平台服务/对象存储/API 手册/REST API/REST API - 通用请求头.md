# REST API

### 通用请求头
|       Header      |                                                                                描述                                                                                |
|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Authorization     | 认证信息<br>类型：字符串<br>默认：无                                                                                                                               |
| Content-Length    | RFC2616所定义的请求长度<br>类型：字符串<br>默认：无<br>                                                                                                            |
| Content-Type      | 文件的类型<br>类型：字符串<br>默认：无<br>                                                                                                                         |
| Content-MD5       | HTTP BODY MD5值base64编码后的值，与md5sum结果一致，无效的Content-MD5将返回错误：InvalidDegest<br>类型：字符串<br>示例：fbacf535f27731c9771645a39863328<br>默认：无 |
| Date              | 请求的时间戳<br>类型：字符串，格式必须符合RFC1123的日期格式<br>示例：Wed, 01 Mar 2012 12:00:00 GMT<br>默认：无                                                     |
| Host              | 请求资源的主机名，通常采用虚拟机风格描述<br>类型：字符串<br>示例：BucketName.nos-eastchina1.126.net<br>默认：无                                                    |
| x-nos-entity-type | 接口返回的格式，当前支持xml和json两种格式<br>类型：字符串<br>示例：有效取值：json、xml<br>默认：xml                                                                |