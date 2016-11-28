# Python SDK 手册

## 文件上传

在 NOS 中用户的基本操作单元是对象，亦可以理解为文件，NOS PYTHON SDK 提供了丰富的上传接口，可以通过以下的方式上传文件:

* 字符串上传
* 本地文件上传
* 分片上传

字符串上传、本地文件上传最大为 100M，分片上传对文件大小没有限制

### 字符串上传

你可以使用 put_object 上传字符串内容到文件中，具体实现如下:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    content = "Hello NOS!"
    
    client.put_object(bucket, object, content)
    *上传的字符串内容不超过 100M

### 本地文件上传

你可以使用 put_object 上传文件内容，具体实现如下:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    file_name = "待上传文件的名称"
    
    client.put_object(bucket, object, open(file_name, "rb"))
    *1.上传的文件内容不超过 100M

    *2.必须以二进制的方式打开文件

### 分片上传

除了通过 put_object 接口上传文件到 NOS 之外，NOS 还提供了另外一种上传模式-分片上传,用户可以在如下应用场景内（但不限于此），使用分片上传模式，如：

* 需支持断点上传
* 上传超过 100M 的文件
* 网络条件较差，经常和 NOS 服务器断开连接
* 上传文件之前无法确定文件的大小

#### 原始接口分片上传

* 初始化一个分片上传任务 (create_multipart_upload)
* 逐个或并行上传分片 (upload_part)
* 完成分片上传 (complete_multipart_upload) 或者取消分片上传
(abort_multipart_upload)

下面通过一个完整的示例说明了如何通过原始的 api 接口一步一步的进行分片上传操作，如果用户需要做断点续传等高级操作，可以参考下面代码:

    bucket = "使用的桶名，注意命名规则"
    object = "使用的对象名，注意命名规则"
    
    # step 1. 初始化一个分块上传，获取分块上传 ID，桶名 + 对像名 + 分块上传 ID 唯一确定一个分块上传
    result=client.create_multipart_upload(bucket, object)
    # 分块上传 ID 用于后续分块上传操作
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


<span>Attention:</span>
上面程序一共分为三个步骤：a. create_multipart_upload b. upload_part c. complete_multipart_upload
upload_part 方法要求除最后一个 Part 以外，其他的 Part 大小都要大于或等于 16K。但是 upload_part 接口并不会立即校验上传 Part 的大小（因为不知道是否为最后一块），只有当 complete_multipart_upload 的时候才会校验。
Part 号码的范围是 1~10000。如果超出这个范围，NOS 将返回 InvalidArgument 的错误码。
Part 的大小为 16K 到 100M
分片上传任务初始化或上传部分分片后，可以使用 abort_multipart_upload 接口中止分片上传事件。当分片上传事件被中止后，就不能再使用这个 upload_id 做任何操作，已经上传的分片数据也会被删除。
在完成上传时，需要在参数中提供上传块的 ETag 与块编号（PartNumber）的组合信息，具体操作参考上面代码。

#### 查看已经上传的分片

查看已经上传的分片可以罗列出指定 upload_id(create_multipart_upload 时获取) 所属的所有已经上传成功的分片，你可以通过 list_parts 接口获取已经上传的分片，可以参考以下代码:

    rParts = client.list_parts(bucket, object, upload_id)
    for k in rParts.get("response").findall("Part"):
        print k.find("PartNumber").text, k.find("ETag").text
