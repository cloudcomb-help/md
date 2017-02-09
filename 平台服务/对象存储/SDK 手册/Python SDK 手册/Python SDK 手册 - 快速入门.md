# Python SDK 手册


## 快速入门

请确认你已经熟悉 NOS 的基本概念，如 Bucket、Object、EndPoint、AccessKeyId 和 AccessKeySecret 等。 本节你将看到如何快速的使用 NOS PYTHON SDK，完成常用的操作，上传文件、下载文件等。

### 常用类

|**常用类**|	           **备注**                |
|----------|---------------------------------------|
|nos.Client|	NOS 客户端类，用户通过 Client 调用服务|
|nos.exceptions.ServiceException|	NOS 服务器返回的异常|
|nos.exceptions.ClientException|	NOS 客户端抛出的异常|

### 基本操作

#### 上传文件

对象（Object）是 NOS 中最基本的数据单元，你可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

    import nos
    
    access_key = "你的 accessKeyId"
    secret_key = "你的 accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    content = "Hello NOS!"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        client.put_object(bucket, object, content)
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
            e.status_code,  # 错误 http 状态码
            e.error_type,   # NOS 服务器定义错误类型
            e.error_code,   # NOS 服务器定义错误码
            e.request_id,   # 请求 ID，有利于 nos 开发人员跟踪异常请求的错误原因
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

<span>Note:</span><div class="alertContent">对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/对象操作/对象操作 - PUT Object.md)</div>

#### 下载文件

上传对象成功之后，你可以读取它的内容，以下代码可以实现文件的下载:

    import nos
    
    access_key = "你的 accessKeyId"
    secret_key = "你的 accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        result = client.get_object(bucket, object)
        fp = result.get("body")
        object_str = fp.read()
        print "object content: ", object_str
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
            e.status_code,  # 错误 http 状态码
            e.error_type,   # NOS 服务器定义错误类型
            e.error_code,   # NOS 服务器定义错误码
            e.request_id,   # 请求 ID，有利于 nos 开发人员跟踪异常请求的错误原因
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


#### 列举文件

当上传文件成功之后，可以查看桶中包含的文件列表，以下代码展示如何列举桶内的文件:

    import nos
    
    access_key = "你的 accessKeyId"
    secret_key = "你的 accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        object_lists = client.list_objects(bucket)
        for object_list in object_lists["response"].findall("Contents"):
            print object_list.find("Key").text, object_list.find("Size").text, object_list.find("LastModified").text
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
            e.status_code,  # 错误 http 状态码
            e.error_type,   # NOS 服务器定义错误类型
            e.error_code,   # NOS 服务器定义错误码
            e.request_id,   # 请求 ID，有利于 nos 开发人员跟踪异常请求的错误原因
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

#### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

    import nos
    
    access_key = "你的 accessKeyId"
    secret_key = "你的 accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        client.delete_object(bucket, object)
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
            e.status_code,  # 错误 http 状态码
            e.error_type,   # NOS 服务器定义错误类型
            e.error_code,   # NOS 服务器定义错误码
            e.request_id,   # 请求 ID，有利于 nos 开发人员跟踪异常请求的错误原因
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

