# REST API

## 错误码定义

|                 错误码                  |             HTTP 状态码             |                     描述                    |
|-----------------------------------------|-------------------------------------|---------------------------------------------|
| AccessDenied                            | 403 Forbidden                       | 权限错误，拒绝访问                          |
| BadDigest                               | 400 Bad Request                     | 提供的 MD5 值与服务器收到的二进制内容不匹配 |
| BucketAlreadyExist                      | 409 Conflict                        | 创建桶时，桶名已存在                        |
| BucketAlreadyOwnedByYou                 | 409 Conflict                        | 创建桶时，该桶已经属于你，重复创建了        |
| BucketNotEmpty                          | 409 Conflict                        | 尝试删的桶非空                              |
| EntityTooSmall                          | 400 Bad Request                     | 提交的请求小于允许的对象的最小值            |
| EntityTooLarge                          | 400 Bad Request                     | 提交的请求大于允许的对象的最大值            |
| IllegalVersioningConfigurationException | 400 Bad Request                     | 版本号配置无效                              |
| IncompleteBody                          | 400 Bad Request                     | 上传的数据量小于 HTTP 头中的 Content-Length |
| InternalError                           | 500 Internal Server Error           | 服务器内部错误，请重试                      |
| InvalidAccessKeyId                      | 403 Forbidden                       | AccessKey 找不到匹配的记录                  |
| InvalidArgument                         | 400 Bad Request                     | 无效参数                                    |
| InvalidBucketName                       | 400 Bad Request                     | 无效桶名称                                  |
| InvalidDigest                           | 400 Bad Request                     | 不是有效的 Content-MD5                      |
| InvalidPart                             | 400 Bad Request                     | 无效的上传块                                |
| InvalidPartOrder                        | 400 Bad Request                     | 上传块的顺序有错误                          |
| InvalidRange                            | 416 Requested Range Not Satisfiable | 请求的 Range 不合法                         |
| InvalidRequest                          | 400 Bad Request                     | 非法请求                                    |
| InvalidStorageClass                     | 400 Bad Request                     | 无效的存储级别                              |
| KeyTooLong                              | 400 Bad Request                     | Object Key 长度太长                         |
| MalformedXML                            | 400 Bad Request                     | XML 格式错误                                |
| MetadataTooLarge                        | 400 Bad Request                     | 元数据过大                                  |
| MethodNotAllowed                        | 405 Method Not Allowed              | 请求的 HTTP Method 不允许访问               |
| MissingContentLength                    | 411 Length Required                 | 缺少 HTTP Header Content-Length             |
| MissingRequestBodyError                 | 400 Bad Request                     | 缺少请求体                                  |
| NoSuchBucket                            | 404 Not Found                       | 请求的桶不存在                              |
| NoSuchKey                               | 404 Not Found                       | 没有这个 key                                |
| NoSuchUpload                            | 404 Not Found                       | 对应的分块上传不存在                        |
| NoSuchVersion                           | 400 Bad Request                     | 没有这个版本号                              |
| NotImplemented                          | 501 Not Implemented                 | 该项功能尚未实现                            |
| RequestTimeout                          | 400 Bad Request                     | 请求超时                                    |
| RequestTimeTooSkewed                    | 403 Forbidden                       | 请求时间戳和服务器时间戳差距过大            |
| SignatureDoesNotMatch                   | 403 Forbidden                       | 请求的签名与服务器计算的签名不符            |
| ServiceUnavailable                      | 503 Service Unavailable             | 服务不可用                                  |
| TooManyBuckets                          | 400 Bad Request                     | 创建了过多的桶                              |

