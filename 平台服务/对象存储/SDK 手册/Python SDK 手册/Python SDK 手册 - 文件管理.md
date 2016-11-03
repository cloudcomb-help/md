# Python SDK 手册

## 文件管理

在NOS中，用户可以通过一系列的接口管理桶(Bucket)中的文件(Object)，比如list_objects，delete_object，copy_object等。

### 列出桶中的文件

你可以使用list_objects列出桶中的文件:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        object_lists = client.list_objects(bucket)
        for object_list in object_lists["response"].findall("Contents"):
            print object_list.find("Key")
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

list_objects可以指定的可选参数如下所示:

|**参数**|	                 **说明**                    |
|--------|-----------------------------------------------|
|delimiter|	用于对Object名字进行分组的字符。所有名字包含指定的前缀且第一次出现delimiter字符之间的object作为一组元素|
|prefix|	限定返回的object key必须以prefix作为前缀。注意使用prefix查询时，返回的key中仍会包含prefix|
|limit|	限定此次返回object的最大数，如果不设定，默认为100|
|marker	|设定结果从marker之后按字母排序的第一个开始返回|

### 删除单个文件

你可以使用delete_object删除单个需要删除的文件:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
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

### 删除多个文件

你可以使用delete_objects批量删除文件:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    keys=["your-objectname1", "your-objectname2", "your-objectname3"]
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        client.delete_objects(bucket, keys)
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

### 拷贝文件

你可以使用copy_object拷贝文件:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    src_object = "拷贝来源的对象名，注意命名规则"
    dst_object = "拷贝目的的对象名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        client.copy_object(bucket, src_object, bucket, dst_object)
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
            
   
<span>Attention:</span><div class="alertContent">支持跨桶的文件copy</div>

### 移动文件

你可以使用move_object移动文件:

        import nos
        
        access_key = "你的accessKeyId"
        secret_key = "你的accessKeySecret"
        end_point = "建桶时选择的的区域域名"
        bucket = "使用的桶名，注意命名规则"
        src_object = "移动来源的对象名，注意命名规则"
        dst_object = "移动目的的对象名，注意命名规则"
        
        client = nos.Client(access_key, secret_key, end_point)
        
        try:
            client.move_object(bucket, src_object, bucket, dst_object)
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
    
<span>Attention:</span><div class="alertContent">暂时不支持跨桶的文件move</div>

