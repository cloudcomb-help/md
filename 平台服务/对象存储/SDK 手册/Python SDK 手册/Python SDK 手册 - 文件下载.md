# Python SDK 手册

## 文件下载

用户可以通过以下方式从NOS获取文件:

* 下载文件

### 下载文件

以下源代码实现下载文件到内存中:

        import nos
        
        access_key = "你的accessKeyId"
        secret_key = "你的accessKeySecret"
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

<span>Attention:</span><div class="alertContent">下载内容也可以存储到文件中</div>

