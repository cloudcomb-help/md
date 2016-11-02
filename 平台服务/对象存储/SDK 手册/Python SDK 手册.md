# Python SDK 手册

## 安装

### SDK

* github地址: https://github.com/NetEase-Object-Storage/nos-python-sdk
* pypi地址: https://pypi.python.org/pypi/nos-python-sdk/

### 环境要求

此版本的 Python SDK 适用于 Python 2.7 版本。首先请根据 Python官网 的引导安装合适的 Python 版本。

### 安装

#### pip方式

如果你通过pip管理你的项目依赖，可以在你的控制台运行:

    sudo pip install nos-python-sdk

#### 源码方式

使用SDK源码安装，可以克隆github上SDK项目的master分支，或者到pypi上下载相应版本的源码包并解压，最后执行安装命令:

    sudo python setup.py install

## 初始化

### 确定EndPoint

[EndPoint](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/数据中心和域名.md) 是 NOS 各个区域的地址，目前支持以下形式

|**EndPoint类型**|	            **备注**              |
|----------------|------------------------------------|
|NOS区域域名地址|	使用桶所在的区域的NOS域名地址|

#### NOS区域域名地址

进入NOS控制台，在桶的 [属性](http://support.c.163.com/md.html#!平台服务/对象存储/控制台手册/管理存储空间.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如:test-logging.nos-eastchina1.126.net中的nos-eastchina1.126.net 为该桶的公网EndPoint。

### 配置密钥

要接入NOS服务，你需要一对有效的AccessKey（包括AccessKeyId与AccessKeySecret）来进行 签名验证，开通服务与AccessKey请参考 [访问控制](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/访问控制.md)

在获取到AccessKeyId与AccessKeySecret之后，可以按照以下的步骤进行初始化

### 新建Client

使用NOS地区域名创建Client

初始化代码如下所示:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    client = nos.Client(access_key, secret_key, end_point)

### 设置额外参数

如果你需要修改Client的默认配置，可以在实例化Client时添加其他可选参数:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    client = nos.Client(
        access_key,
        secret_key,
        end_point,
        num_pools=10,
        timeout=5,
        max_retries=4
    )

具体参数见下表：

|**参数**|      	**描述**            |	   **默认值**       |
|--------|------------------------------|-----------------------|
|timeout|	建立连接的超时时间（单位：秒）|	默认：Socket的全局Timeout值|
|num_pools|	允许打开的最大HTTP连接数|	默认：16|
|max_retries|	请求失败后最大的重试次数|	默认：2|
## 快速入门

请确认你已经熟悉NOS的基本概念，如Bucket、Object、EndPoint、AccessKeyId和AccessKeySecret等。 本节你将看到如何快速的使用NOS PYTHON SDK，完成常用的操作，上传文件、下载文件等。

### 常用类

|**常用类**|	           **备注**                |
|----------|---------------------------------------|
|nos.Client|	NOS客户端类，用户通过Client调用服务|
|nos.exceptions.ServiceException|	NOS服务器返回的异常|
|nos.exceptions.ClientException|	NOS客户端抛出的异常|

### 基本操作

#### 上传文件

对象（Object）是NOS中最基本的数据单元，你可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
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

对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/对象操作.md)

#### 下载文件

上传对象成功之后，你可以读取它的内容，以下代码可以实现文件的下载:

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


#### 列举文件

当上传文件成功之后，可以查看桶中包含的文件列表，以下代码展示如何列举桶内的文件:

    import nos
    
    access_key = "你的accessKeyId"
    secret_key = "你的accessKeySecret"
    end_point = "建桶时选择的的区域域名"
    bucket = "使用的桶名，注意命名规则"
    
    client = nos.Client(access_key, secret_key, end_point)
    
    try:
        object_lists = client.list_objects(bucket)
        for object_list in object_lists["response"].findall("Contents"):
            print object_list.find("Key"), object_list.find("Size"), object_list.find("LastModified")
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

#### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

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

## 文件上传

在NOS中用户的基本操作单元是对象，亦可以理解为文件，NOS PYTHON SDK提供了丰富的上传接口，可以通过以下的方式上传文件:

* 字符串上传
* 本地文件上传
* 分片上传
字符串上传、本地文件上传最大为100M，分片上传对文件大小没有限制

### 字符串上传

你可以使用put_object上传字符串内容到文件中，具体实现如下:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    content = "Hello NOS!"
    
    client.put_object(bucket, object, content)
    *上传的字符串内容不超过100M

### 本地文件上传

你可以使用put_object上传文件内容，具体实现如下:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    file_name = "待上传文件的名称"
    
    client.put_object(bucket, object, open(file_name, "rb"))
    *1.上传的文件内容不超过100M

    *2.必须以二进制的方式打开文件

### 分片上传

除了通过put_object接口上传文件到NOS之外，NOS还提供了另外一种上传模式-分片上传,用户可以在如下应用场景内（但不限于此），使用分片上传模式，如：

* 需支持断点上传
* 上传超过100M的文件
* 网络条件较差，经常和NOS服务器断开连接
* 上传文件之前无法确定文件的大小

#### 原始接口分片上传

* 初始化一个分片上传任务(create_multipart_upload)
* 逐个或并行上传分片(upload_part)
* 完成分片上传(complete_multipart_upload)或者取消分片上传
(abort_multipart_upload)

下面通过一个完整的示例说明了如何通过原始的api接口一步一步的进行分片上传操作，如果用户需要做断点续传等高级操作，可以参考下面代码:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    
    # step 1. 初始化一个分块上传，获取分块上传ID，桶名 + 对像名 + 分块上传ID 唯一确定一个分块上传
    result=client.create_multipart_upload(bucket, object)
    # 分块上传ID用于后续分块上传操作
    upload_id=result["response"].find("UploadId").text
    
    # step 2. 上传分块
    index = 0
    slice_size = 100 * 1024 * 1024
    file_name = "待上传文件的名称"
    with open(file_name, "rb") as fp:
        while True:
            index += 1
            part = fp.read(slice_size)
            if not part:
                break
            client.upload_part(bucket, object, index, upload_id, part)
    
    # step 3. 列出所有分块，完成分块上传
    rParts = client.list_parts(bucket, object, upload_id)
    Parts=rParts["response"]
    partETags=[]
    for k in Parts.findall("Part"):
        partETags.append({"part_num":k.find("PartNumber").text,"etag":k.find("ETag").text})
    
    client.complete_multipart_upload(bucket, object, upload_id, partETags)


Attention: 
1.上面程序一共分为三个步骤：a. create_multipart_upload b. upload_part c. complete_multipart_upload
2.upload_part 方法要求除最后一个Part以外，其他的Part大小都要大于或等于16K。但是upload_part接口并不会立即校验上传Part的大小（因为不知道是否为最后一块），只有当complete_multipart_upload的时候才会校验。
3.Part号码的范围是1~10000。如果超出这个范围，NOS将返回InvalidArgument的错误码。
4.Part的大小为16K到100M
5.分片上传任务初始化或上传部分分片后，可以使用abort_multipart_upload接口中止分片上传事件。当分片上传事件被中止后，就不能再使用这个upload_id做任何操作，已经上传的分片数据也会被删除。
6.在完成上传时，需要在参数中提供上传块的ETag与块编号（PartNumber）的组合信息，具体操作参考上面代码。

#### 查看已经上传的分片

查看已经上传的分片可以罗列出指定upload_id(create_multipart_upload时获取)所属的所有已经上传成功的分片，你可以通过list_parts接口获取已经上传的分片，可以参考以下代码:

    rParts = client.list_parts(bucket, object, upload_id)
    for k in rParts.get("response").findall("Part"):
        print k.find("PartNumber").text, k.find("ETag").text

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

Attention:
下载内容也可以存储到文件中

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
            
   
Attention:
支持跨桶的文件copy

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
    
Attention:
暂时不支持跨桶的文件move

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

|**类名**|	                  **抛出异常的原因**                   |
|InvalidBucketName|	传入的桶名为空|
|InvalidObjectName	|传入的对象名为空|
|FileOpenModeError|	出入的对象为文件且没有使用二进制文件方式打开|
|XmlParseError	|解析服务端响应的XML内容失败|
|SerializationError|	上传对象序列化失败|
|ConnectionError	|连接服务端异常|
|ConnectionTimeout|	连接服务端超时|

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
