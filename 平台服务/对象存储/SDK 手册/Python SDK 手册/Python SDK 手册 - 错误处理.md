# Python SDK 手册

## 错误处理

### 异常处理

调用Client类的相关接口时，如果抛出异常，则表明操作失败，否则操作成功。抛出异常时，方法返回的数据无效。SDK中所有异常均属于NOSException类，其下分为两个子类：ClientException、ServiceException。在调用PYTHON SDK接口的时候，捕捉这些异常并打印必要的信息有利于定位问题。

### 异常处理实例

错误处理代码如下所示:

    try:
        resp = client.XXX(bucket=bucket, key=key)
    except nos.exceptions.ServiceException as e:
        print (
            "ServiceException: %s\n"
            "status_code: %s\n"
            "error_type: %s\n"
            "error_code: %s\n"
            "request_id: %s\n"
            "message: %s\n"
        ) % (
            e,
            e.status_code,  # 错误http状态码
            e.error_type,   # NOS服务器定义错误类型
            e.error_code,   # NOS服务器定义错误码
            e.request_id,   # 请求ID，有利于nos开发人员跟踪异常请求的错误原因
            e.message       # 错误描述信息
        )
    except nos.exceptions.ClientException as e:
        print (
            "ClientException: %s\n"
            "message: %s\n"
        ) % (
            e,
            e.message       # 客户端错误信息
        )

### NOSException

#### ClientException

ClientException包含SDK客户端的异常。比如，上传对象时对象名为空，就会抛出该异常。 ClientException类下有如下子类，用于细分客户端异常：

|      **类名**      |              **抛出异常的原因**              |
|--------------------|----------------------------------------------|
| InvalidBucketName  | 传入的桶名为空                               |
| InvalidObjectName  | 传入的对象名为空                             |
| FileOpenModeError  | 出入的对象为文件且没有使用二进制文件方式打开 |
| XmlParseError      | 解析服务端响应的XML内容失败                  |
| SerializationError | 上传对象序列化失败                           |
| ConnectionError    | 连接服务端异常                               |
| ConnectionTimeout  | 连接服务端超时                               |

#### ServiceException

ServiceException包含NOS服务器返回的异常。当NOS服务器返回4xx或5xx的HTTP错误码时，PYTHON SDK会将NOS Server的响应转换为ServiceException。 ServiceException类下有如下子类，用于细分NOS服务器返回的异常：

|    **类名**    |	                  **抛出异常的原因**                      |
|----------------|------------------------------------------------------------|
|MultiObjectDeleteException|	批量删除对象时，存在部分对象无法删除|
|BadRequestError	|服务端返回 HTTP 400 响应|
|ForbiddenError|	服务端返回 HTTP 403 响应|
|NotFoundError	|服务端返回 HTTP 404 响应|
|MethodNotAllowedError|	服务端返回 HTTP 405 响应|
|ConflictError	|服务端返回 HTTP 409 响应|
|LengthRequiredError|	服务端返回 HTTP 411 响应|
|RequestedRangeNotSatisfiableError	|服务端返回 HTTP 416 响应|
|InternalServerErrorError|	服务端返回 HTTP 500 响应|
|NotImplementedError	|服务端返回 HTTP 501 响应|
|ServiceUnavailableError	|服务端返回 HTTP 503 响应|
