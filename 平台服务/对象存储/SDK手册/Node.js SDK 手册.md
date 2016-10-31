## 安装

### SDK

历史版本: 无

### 环境要求

建议node.js v4.4+ 使用以下命令显示当前的node.js版本:

    $ node -v

### 安装

#### 使用NPM安装

首先使用npm安装SDK的开发包:

    npm install nos-node-sdk

## 初始化

### 确定EndPoint

EndPoint 是NOS各个区域的地址，目前支持以下形式

|**EndPoint类型**|	          **备注**             |
|----------------|---------------------------------|
|NOS区域域名地址|	使用桶所在的区域的NOS域名地址|

#### NOS区域域名地址

进入NOS控制台，在桶的 [属性](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/%E6%8E%A7%E5%88%B6%E5%8F%B0%E6%89%8B%E5%86%8C/%E7%AE%A1%E7%90%86%E5%AD%98%E5%82%A8%E7%A9%BA%E9%97%B4.md) 中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如:test-logging.nos-eastchina1.126.net中的nos-eastchina1.126.net 为该桶的公网EndPoint。

#### 配置秘钥

要接入NOS服务，你需要一对有效的AccessKey（包括AccessKeyId与AccessKeySecret）来进行 签名验证，开通服务与AccessKey请参考 [访问控制](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/API%E6%89%8B%E5%86%8C/%E8%AE%BF%E9%97%AE%E6%8E%A7%E5%88%B6.md)

在获取到AccessKeyId与AccessKeySecret之后，可以按照以下的步骤进行初始化

使用方法

使用步骤

1.安装nos-node-sdk模块:

    npm install nos-node-sdk

2.引入模块 nos-node-sdk 模块:

    var NosClient = require('nos-node-sdk');

3.初始化 NosClient:

    var nosclient = new NosClient();
    nosclient.setAccessId('你的accessKeyId');
    nosclient.setSecretKey('你的accessKeySecret');
    nosclient.setEndpoint('建桶时选择的的区域域名');
    nosclient.setPort('80');

使用说明

    1.nos-node-sdk提供callback风格的api接口，所有的api都有两个参数，示例如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path' //本地文件路径
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }
    *第一个参数是map，不同的接口要求传入的map参数不一样。

    *第二个参数是回调函数cb，cb中的操作由用户自行定义，在收到响应的时候由sdk自动调用，并传入一个result参数，该参数提供的内容在不同的api中有所不同。用户可以在自定义cb的时候利用该参数获取响应的内容，如uploadid，etag等等。

    2.使用sdk时，用户只需要按照文档要求提供合法的map参数和定义cb，就能方便调用nos接口通过node管理资源。NOS Node SDK主要描述各个api的map参数和cb函数的result参数的内容，并提供使用示例。

    3.当接口调用失败，返回状态码不在[200,400)范围时，sdk会抛出异常，异常包含的信息请参考 [异常信息](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/Node.js%20SDK%20%E6%89%8B%E5%86%8C.md)

## 快速入门

使用NOS Node SDK前，你可以先参照 [API 手册](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/API%E6%89%8B%E5%86%8C/%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5.md) 熟悉NOS的基本概念，如Bucket、Object、EndPoint、AccessKeyId和AccessKeySecret等。 本节你将看到如何快速的使用NOS Node SDK，完成常用的操作，上传文件、下载文件等。

### 基本操作

#### 上传文件

对象（Object）是NOS中最基本的数据单元，你可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path' //本地文件路径
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

对象命名规则请参见 [API 手册 对象](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/API%E6%89%8B%E5%86%8C/%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5.md)

更多的上传文件信息，请参见 [NOS Node SDK上传文件](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/Node.js%20SDK%20%E6%89%8B%E5%86%8C.md)

#### 下载文件

上传对象成功之后，你可以读取它的内容，以下代码可以实现文件的下载:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath' //下载到的本地文件路径（包含文件名）
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.get_object_file(map, cb) //这里的destpath包括了文件名
    }
        catch(err) {
        console.log("Failed with code: " + err.code);
    }

更多的下载文件信息，请参见 [NOS Node SDK下载文件](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/Node.js%20SDK%20%E6%89%8B%E5%86%8C.md)

#### 列举文件

当上传文件成功之后，可以查看桶中包含的文件列表，以下代码展示如何列举桶内的文件:

    var map = {
        bucket: 'bucketName' //桶名
    };
    var cb = function(result) {
        //获取对象列表
        var objectlist = result['bucketInfo']['objectlist'];
        //遍历对象列表
        for (var i = 0; i < objectlist.length; i++) {
            //打印对象信息
            console.log(objectlist[i]['key']);
            console.log(objectlist[i]['lastmodified']);
            console.log(objectlist[i]['etag']);
            console.log(objectlist[i]['size']);
        }
    }
    
    try {
        nosclient.list_objects(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

上面的代码默认列举100个object

更多的管理文件信息，请参见 [NOS Node SDK 文件管理](https://github.com/cloudcomb-help/md/blob/master/%E5%B9%B3%E5%8F%B0%E6%9C%8D%E5%8A%A1/%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8/SDK%E6%89%8B%E5%86%8C/Node.js%20SDK%20%E6%89%8B%E5%86%8C.md)

#### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName' //对象名
    };
    var cb = function(result) {
        //打印statusCode
        console.log(result['statusCode']);
        //打印requestId
        console.log(result['headers']['x-nos-request-id'])
    }
    
    try {
        nosclient.delete_object(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

#### 返回结果处理

* api接口的第二个参数回调函数cb，cb中的操作由用户自行定义，在收到响应的时候由sdk自动调用，并传入一个result参数，该参数是调用api接口返回的结果对象，所有的返回参数都在这个result对象中。
* 用户可以在自定义cb的时候利用该参数获取响应的内容，如uploadid，etag等等
例如:
<pre><code>
var map = {
    bucket: 'bucketName' //桶名
};
var cb = function(result) {
    //获取对象列表
    var objectlist = result['bucketInfo']['objectlist'];
    //遍历对象列表
    for (var i = 0; i < objectlist.length; i++) {
        //打印对象信息
        console.log(objectlist[i]['key']);
        console.log(objectlist[i]['lastmodified']);
        console.log(objectlist[i]['etag']);
        console.log(objectlist[i]['size']);
    }
}

nosclient.list_objects(map, cb);
</code></pre>

## 文件上传

在NOS中用户的基本操作单元是对象，亦可以理解为文件，NOS Node SDK提供了丰富的上传接口，可以通过以下的方式上传文件:

* 流式上传
* 单块上传
* 分块上传
流式上传、单块上传最大为100M；分块上传除最后一块外，分块不能小于16k，每一个分块不能大于100M，最多能上传10000个分块，即分块上传的文件最大支持1T。

### 流式上传

你可以使用NosClient.put_object_stream上传一个Stream中的内容，具体实现如下:

    var readStream = fs.createReadStream('filepath');
        var size = fs.statSync('filepath').size;
    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        body: readStream, //上传的流
        length: size //流的长度
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_object_stream(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers:{
     'x-nos-request-id': '2aa8555c0af100000155fb83034c15fb',
     etag: 'b1335fbca4c89d12719cf99fdcab707e',
     'x-nos-object-name': 'objectName',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

**注：**

* 上传的流内容不超过100M
### 单块上传

你可以使用NosClient.put_file上传文件内容，具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path' //文件路径
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers:{
     'x-nos-request-id': '2aa8555c0af100000155fb83034c15fb',
     etag: 'b1335fbca4c89d12719cf99fdcab707e',
     'x-nos-object-name': 'objectName',
     'content-length': '0',
     connection: 'close',
     erver: 'Jetty(6.1.11)' }

**注**：

上传的文件内容不超过100M
### 分块上传

除了通过put_file接口上传文件到NOS之外，NOS还提供了另外一种上传模式-分块上传,用户可以在如下应用场景内（但不限于此），使用分块上传模式，如：

* 需支持断点上传
* 上传超过100M的文件
* 网络条件较差，经常和NOS服务器断开连接
* 上传文件之前无法确定文件的大小
#### 分块上传本地文件

你可以使用NosClient.put_big_file来上传一个大文件，具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'bigFileName', //对象名
        filepath: 'path' //文件路径
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_big_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容实例:

    statusCode: 200
    headers:{
     'x-nos-request-id': 'af253f210af100000155fb97d3ad15fb',
     etag: 'ff9360dc18c5e09a80db8f0aa115d52c',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }
    multipart_upload_result:{
     location:bucketName.nos.netease.com/bigFileName,
     bucket:bucketName,
     key:bigFileName,
     etag:"3858f62230ac3c915f300c664312c11f-9"
    }

#### 原始接口分块上传

你可以使用原始的分块上传接口进行分块上传，一般流程如下所示:

* 初始化一个分块上传任务
* 上传分块
* 完成分块上传或者取消分块上传
#### 初始化分块上传

你可以使用NosClient.create_multipart_upload初始化分块上传，具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName' //对象名
    };
    var cb = function(result) {
        var upload_id = result.multipart_upload_info.upload_id;
    };
    
    try {
        nosclient.create_multipart_upload(map, cb)
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200,
    headers: {
     server: 'openresty/1.9.15.1',
     date: 'Fri, 30 Sep 2016 02:59:40 GMT',
     'content-type': 'application/xml;charset=UTF-8',
     'content-length': '206',
     connection: 'close',
     'x-nos-request-id': 'a5659e760ab000000157790878a33f0c' },
    multipart_upload_info: {
     bucket: 'bucketName',
     key: 'objectName',
     upload_id: '4752043808200245495'
    }

## 上传分块

你可以使用NosClient.upload_part上传文件内容，分块不能小于16k，每一个分块不能大于100M。具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        part_num: 1, //分块数量
        upload_id: '4752043808200245495', //分块上传标识号(调用初始化分块上传接口create_multipart_upload得到)
        body: readStream，//每个分块的内容
        length: 1415 //每个分块的大小
    }
    var cb = function(result) {
        partNum = result.partNumber;
        etag = result.headers.etag;
    };
    
    try {
        nosclient.upload_part(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200,
    partNumber: 1,
    headers: {
     server: 'openresty/1.9.15.1',
     date: 'Fri, 30 Sep 2016 02:59:40 GMT',
     'content-type': 'application/octet-stream',
     'content-length': '0',
     connection: 'close',
     'x-nos-request-id': '4ad419590ab000000157790878a30e11',
     etag: 'b3fecdb324e0ba4f1f89f7bfbeae7635'
    }

#### 完成分块上传

你可以使用NosClient.complete_multipart_upload完成分块上传，最多能上传10000个分块，即分块上传的文件最大支持1T。具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        upload_id: '4752043808200245495', //分块上传标识号(调用初始化分块上传接口create_multipart_upload得到得到)
        info: [{ //调用分块上传接口upload_part得到每个分块的PartNumber和ETag
            PartNumber: '1',
            ETag: 'b3fecdb324e0ba4f1f89f7bfbeae7635'
        }]
    }
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.complete_multipart_upload(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200,
    headers: {
     server: 'openresty/1.9.15.1',
     date: 'Fri, 30 Sep 2016 02:59:40 GMT',
     'content-type': 'application/xml;charset=UTF-8',
     'content-length': '284',
     connection: 'close',
     'x-nos-request-id': 'c9ee554f0ab000000157790878a30e12' },
    multipart_upload_result: {
     bucket: 'sdktest-private',
     etag: '5eb6b0a8c51e865c716306fdaf8cd1bc',
     key: 'objectName',
     location: 'bucketName.nos.netease.com/objectName'
    }

#### 分块上传实例

下面通过一个完整的示例说明了如何通过原始的api接口一步一步的进行分块上传操作（以每个分块100M为例），如果用户需要做断点续传等高级操作，可以参考下面代码:

    var filepath = map.filepath;
    var fileStat = fs.statSync(filepath);
    var total_length = fileStat.size;
    var nosclient = this;
    var _100M = 100 * 1024 * 1024;
    var start = 0;
    var end = _100M - 1;
    var complete_info = [];
    var fad_count = 0;
    var count = 0;
    var upload_id = null;
    var Q = require('q');
    var defer = Q.defer();
    var partnum = (total_length % _100M == 0) ? (total_length / _100M) : Math.floor(total_length / _100M) + 1;
    
    nosclient.create_multipart_upload(map,
    function(result) {
        upload_id = result.multipart_upload_info.upload_id;
        var send10Parts = function() {
            for (var i = 0; i < 10; i++) {
                if (start >= total_length) {
                    break;
                }
                if (end >= total_length) {
                    end = total_length - 1;
                }
                var readStream = fs.createReadStream(filepath, {
                    start: start,
                    end: end
                });
                nosclient.upload_part({
                    bucket: map.bucket,
                    key: map.key,
                    part_num: ++fad_count,
                    upload_id: upload_id,
                    body: readStream,
                    length: end - start + 1
                },
                function(result) {
                    complete_info[result.partNumber - 1] = {
                        PartNumber: result.partNumber,
                        ETag: result.headers.etag
                    };
                    count++;
    
                    if (count % 10 == 0) {
                        if (start < total_length) {
                            defer.promise.then(function(fulfilled) {
                                send10Parts();
                            }) defer.resolve();
                        }
                    }
    
                    if (count == partnum) {
                        nosclient.complete_multipart_upload({
                            bucket: map.bucket,
                            key: map.key,
                            expires: map.expires,
                            disposition: map.disposition,
                            contentType: map.contentType,
                            encoding: map.encoding,
                            cacheControl: map.cacheControl,
                            language: map.language,
                            contentMD5: map.contentMD5,
                            upload_id: upload_id,
                            object_md5: map.object_md5,
                            info: complete_info
                        },
                        func);
                    }
                });
                start = end + 1;
                end = end + _100M;
            }
        }
        defer.promise.then(function(fulfilled) {
            send10Parts();
        });
        defer.resolve();
    })

**注**：

* 上面程序一共分为三个步骤：1. initiate 2. uploadPart 3. complete
* Part号码的范围是1~10000。如果超出这个范围，NOS将返回InvalidArgument的错误码。
* 初始化上传之后，获取upload_id。
* 每次上传分块时都要把流定位到此次上传块开头所对应的位置。
* 每次上传分块之后，NOS的返回结果会包含一个complete_info对象，它是上传块的ETag与块编号（PartNumber）的组合。在后续完成分片上传的步骤中会用到它，因此我们需要将其保存起来，然后在第三步complete的时候使用，具体操作参考上面代码。
* 这个示例为了防止过多的并发，使用promise进行了限制，每次最多只有10个并发上传，这样可以防止在网络环境不好的状况下并发连接太多，上传失败。
#### 取消正在上传的分块

分块上传任务初始化或上传部分分块后，可以使用NosClient.abort_multipart_upload接口中止分块上传事件。当分块上传事件被中止后，就不能再使用这个upload_id做任何操作，已经上传的分块数据也会被删除，可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        upload_id: '4688949732940019989' //分块上传标识号
    }
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.abort_multipart_upload(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'f381b02c0af100000155fba0d89e15fb',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

#### 查看已经上传的分块

查看已经上传的分块可以罗列出指定upload_id(create_multipart_upload时获取)所属的所有已经上传成功的分块，你可以通过NosClient.list_parts接口获取已经上传的分块，可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        upload_id: '4688949732940019989' //分块上传标识号
    }
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.list_parts(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

上述代码中使用的map可选参数如下:

|**参数**|	               **描述**                  |
|--------|-------------------------------------------|
|limit|	响应中的limit个数. 类型：整型|
|part_number_marker|	分块号的界限，只有更大的分块号会被列出来。 类型：字符串|
回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': '5292fe910af100000155fba5740515fb',
     'content-type': 'application/xml; charset=UTF-8',
     'content-length': '1123',
     connection: 'close',
     server: 'Jetty(6.1.11)' }
    list_parts_info:{
     bucket:'bucketName',
     key:'objectName',
     upload_id:'4685815523730016248',
     owner:{productid:'productid'},
     storageclass:'archive-standard',
     part_number_marker:'0',
     next_part_number_marker:'4',
     max_parts:'1000',
     is_truncated:'false',
     part_list:[{part_number:1,last_modified:2016-07-15T19:20:27 +0800,etag:b33df4c9833e4dcba58e72ea0a9fcd7f,size:12}......]
     //part_list是parts的数组，数据每个元素是一个map，包含part_number,last_modified,etag,size信息
    }

#### 查看当前正在进行的分块上传任务

查看正在进行的分块上传任务可以罗列出正在进行，还未完成的分块上传任务，你可以通过NosClient.list_multipart_upload接口当前的上传任务，可以参考以下代码:

    var map = {
        bucket: 'bucketName' //桶名
    }
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.list_multipart_upload(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

上述代码中使用的map参数如下:

|**参数值**|	          **描述**                 |
|----------|---------------------------------------|
|key_marker	|指定某一key_marker，只有大于该key_marker的才会被列出。类型：字符串|
|limit|	最多返回limit条记录,默认1000。类型：整型|
回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: { 'x-nos-request-id': '6213b3d00af100000155fbabcf8115fb',
     'content-type': 'application/xml; charset=UTF-8',
     'content-length': '455',
     connection: 'close',
     server: 'Jetty(6.1.11)' }
    multipart_upload_result:{
     bucket:'bucketName',
     next_key_marker:'4685815523730016248',
     is_truncated:'false',
     uploads:[{key:'objectName',upload_id:'4685815523730016248',storage_class:'archive-standard',owner:{name:'name',productid:'productid'},
            initiated:'2016-07-15T19:19:12 +0800'}......]
     //展示每个上传信息的数组，数组的每个元素都是一个map，包含key,upload_id,storage_class,owner,initiated信息
    }

### 设置文件元信息

文件元数据(object meta)，是上传到NOS的文件属性描述信息:分为http标准属性和用户自定义元数据。文件元信息可以在各种上传方式(流式上传、单块上传、分块上传)进行设置，元数据大小写不敏感。

设定http header

NOS允许用户自定义http Header。http header相关信息请参考 RFC2616，几个常用的header说明如下:

|**参数**|	                   **说明**                       |
|--------|----------------------------------------------------|
|meta_data|	用户自定义的元数据，通过键值对的形式上报，键名和值均为字符串，且键名需以x-nos-meta-开头。er字符之间的object作为一组元素|
|disposition|	指示MINME用户代理如何显示附加的文件，打开或下载，及文件名称|
|contentType|	文件的MIME，定义文件的类型及网页编码，决定浏览器将以什么形式、什么编码读取文件。如果用户没有指定则根据Key或文件名的扩展名生成，如果没有扩展名则填默认值|
|encoding|	文件的编码|
|cacheControl|	指定该Object被下载时的网页的缓存行为|
|language|	文件的语言|
|contentMD5|	文件的MD5|
|object_md5|	仅对上传大对象文件时有效，与complete_multipart_upload接口中的object_md5含义相同|
下面的源代码实现了上传文件时设置Http header:

    var meta_data = {
        'x-nos-meta-my-meta': 'user define meta info'
    }
    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path', //文件路径
        contentType: "image/jpeg", //文件的MIME类型
        meta_data: meta_data //用户自定义元数据
    };
    var cb = function(result) {
        console.log(result);
    };
    
    try {
        nosclient.put_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200,
    headers: {
     server: 'openresty/1.9.15.1',
     date: 'Thu, 29 Sep 2016 06:00:01 GMT',
     'content-type': 'image/jpeg',
     'content-length': '0',
     connection: 'close',
     'x-nos-request-id': '3a17fd700ab00000015774873a023f0c',
     etag: 'dc28229fb48cc93025ce862e79c4623f',
     'x-nos-object-name': 'objectName' }

**注:**

* 各种上传方式（包括流式上传、单块上传、分块上传）都可以设置元数据信息，设置的方式相同。
* 通过设置文件的contentType，可以修改文件的类型。
* 通过设置文件的disposition，可以控制文件的下载行为。
## 文件下载

NOS Node SDK提供了丰富的文件下载接口，用户可以通过以下方式从NOS获取文件:

* 下载文件到内存
* 下载到本地文件
* 指定范围下载
* 条件下载
### 下载文件到内存

你可以通过NosClient.get_object_stream接口下载文件到内存，可以参考以下代码:

    ivar map = {
            bucket: 'bucketName', //桶名
            key: 'objectName' //对象名
    };
    var cb = function(result) {
            //打印statusCode
            console.log(result['statusCode']);
            //打印content-length
            console.log(result['headers']['content-length']);
            //获取流
            var stream = result['stream'];
            //处理流
            ......
    }
    
    try {
            nosclient.get_object_stream(map, cb);
    }
    catch(err) {
            console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'aa2402d20af100000155fb6d6cd915fb',
     'content-type': 'application/octet-stream; charset=UTF-8',
     etag: '926d74ef88054b6586a5530c5c6606b3',
     'content-disposition': 'inline; filename="objectName"',
     'last-modified': 'Mon, 18 Jul 2016 08:33:12 Asia/Shanghai',
     'cache-control': 'no-cache',
     'content-length': '18',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

### 下载文件到本地文件

你可以通过NosClient.get_object_file接口下载文件到本地文件，可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath' //本地文件路径(包括文件名)
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.get_object_file(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'aa2402d20af100000155fb6d6cd915fb',
     'content-type': 'application/octet-stream; charset=UTF-8',
     etag: '926d74ef88054b6586a5530c5c6606b3',
     'content-disposition': 'inline; filename="objectName"',
     'last-modified': 'Mon, 18 Jul 2016 08:33:12 Asia/Shanghai',
     'cache-control': 'no-cache',
     'content-length': '18',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

### 指定范围下载

如果存储在NOS中的文件较大，并且你只需要其中的一部分内容，你可以使用范围下载，下载指定范围的数据，如果指定的下载范围为”0-100”，则返回结果为第0字节到第100字节的数据，返回的数据包含第100字节，即bytes=0-100，如果指定的范围无效则下载整个文件，以下源代码获取bytes=0-100字节的内容,可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath', //本地文件路径(包括文件名)
        rang: 'bytes=0-100' //文件范围
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.get_object_file(map, cb);
    }
        catch(err) {
        console.log(""Failed with code: " + err.code");

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'aa2402d20af100000155fb6d6cd915fb',
     'content-type': 'application/octet-stream; charset=UTF-8',
     etag: '926d74ef88054b6586a5530c5c6606b3',
     'content-disposition': 'inline; filename="objectName"',
     'last-modified': 'Mon, 18 Jul 2016 08:33:12 Asia/Shanghai',
     'cache-control': 'no-cache',
     'content-length': '180',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

**注:**

* 下载内容也可以存储到文件中
* 注意下载的区间为闭区间
### 条件下载

下载文件时，可以指定限定条件，满足限定条件时下载，不满足时报错，不下载文件。可以使用的限定条件如下：

|**参数**|	                   **说明**                       |
|--------|----------------------------------------------------|
|if_modified_since|如果指定的时间早于实际修改时间，则正常传送。否则返回错误|

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath', //本地文件路径(包括文件名)
        if_modified_since: 'Fri, 13 Nov 2016 14:47:53 GMT' //指定时间
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.get_object_file(map, cb);
    }
        catch(err) {
        console.log(""Failed with code: " + err.code");
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'aa2402d20af100000155fb6d6cd915fb',
     'content-type': 'application/octet-stream; charset=UTF-8',
     etag: '926d74ef88054b6586a5530c5c6606b3',
     'content-disposition': 'inline; filename="objectName"',
     'last-modified': 'Mon, 18 Jul 2016 08:33:12 Asia/Shanghai',
     'cache-control': 'no-cache',
     'content-length': '18',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

**注:**

* 下载内容也可以存储到文件中
## 文件管理

在NOS中，用户可以通过一系列的接口管理桶(Bucket)中的文件(Object)，比如列举桶内文件、删除文件、拷贝文件等。

### 列出桶中的文件

你可以使用NosClient.list_objects列出存储在桶中的文件:

    var map = {
        bucket: 'bucketName' //桶名
    };
    var cb = function(result) {
        //获取对象列表
        var objectlist = result['bucketInfo']['objectlist'];
        //遍历对象列表
        for (var i = 0; i < objectlist.length; i++) {
            //打印对象信息
            console.log(objectlist[i]['key']);
            console.log(objectlist[i]['lastmodified']);
            console.log(objectlist[i]['etag']);
            console.log(objectlist[i]['size']);
        }
    }
    
    try {
        nosclient.list_objects(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

上述代码中的map中的参数如下所示:

|**参数**|	                    **说明**                      |
|--------|----------------------------------------------------|
|delimiter|	用于对Object名字进行分组的字符。所有名字包含指定的前缀且第一次出现delimiter字符之间的object作为一组元素|
|prefix|	限定返回的Key必须以prefix作为前缀。注意使用prefix查询时，返回的Key中仍会包含prefix|
|limit	|限定此次返回object的最大数，如果不设定，默认为100|
|marker	|设定结果从marker之后按字母排序的第一个开始返回|
回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'db9524a10af100000155fb7ab73d15fb',
     'content-type': 'application/xml; charset=UTF-8',
     'content-length': '1343',
     connection: 'close',
     server: 'Jetty(6.1.11)' }
    bucketInfo:{
     name:'bucket',
     prefix:'',
     marker:'',
     maxkeys:100,
     is_truncated:false,
     objectList:[{
     //object-list是一个数组，每个数据元素都是一个map，包含key,lastmodify,etag,size,storageclass 5项信息，代表桶里面的对象
      key:'a.txt',
      lastmodified:'2016-07-18T08:49:03 +0800',
      etag:'926d74ef88054b6586a5530c5c6606b3',
      size:18,storageclass:archive-standard},......]
    }

**注:**

* 上述表中的参数都是可选参数
### 删除单个文件

你可以使用NosClient.delete_object删除单个需要删除的文件:

    var map = {
        bucket:'bucketName', //桶名
        key:'objectName' //对象名
    };
    var cb = function(result) {
        //打印statusCode
        console.log(result['statusCode']);
        //打印requestId
        console.log(result['headers']['x-nos-request-id'])
    }
    
    try {
        nosclient.delete_object(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'e2f97ce70af100000155fb63f9fc15fb',
     'x-nos-version-id': '0',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

### 删除多个文件

你可以使用NosClient.delete_objects删除多个需要删除的文件:

    var map = {
        bucket: 'bucketName', //桶名
        keys: [{Key: 'objectName1'},{Key: 'objectName2'},{Key: 'objectName3'},{Key: 'objectName4'}] //需要删除的对象名
    };
    var cb = function(result) {
        //打印statusCode
        console.log(result['statusCode']);
        //打印requestId
        console.log(result['headers']['x-nos-request-id'])
        //打印所有删除成功的对象名
        var deleteSuccess = result['deleteSuccess']
        for (var i = 0; i < deleteSuccess.length; i++) {
            console.log(deleteSuccess[i])
        }
        //打印所有删除失败的对象名
        var deleteFail = result['deleteFail']
        for (var i = 0; i < deleteFail; i++) {
            console.log(deleteFail[i]['Key']);
            console.log(deleteFail[i]['Message']);
        }
    }
    
    try {
        nosclient.delete_objects(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'ab6f6cce0af100000155fb68571115fb',
     'content-type': 'application/xml; charset=UTF-8',
     'content-length': '55',
     connection: 'close',
     server: 'Jetty(6.1.11)' }
     delete-success:['objectName1','objectName3']
     delete-fail:[{Key:'objectName2',Message:'NoSuchBucket'},{Key:'objectName4',Message:'AccessDenied'}]

### 拷贝文件

你可以使用NosClient.copy_object拷贝文件:

    var map = {
        src_bucket:'srcBucketName', //源桶名
        src_key:'srcObjectName', //源对象名
        dest_bucket:'destBucketName', //目标桶名
        dest_key:'destObjectName' //目标对象名
    };
    var cb = function(result){
        console.log(result);
    }
    
    try{
        nosclient.copy_object(map,cb);
    }
    catch(err){
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
    'x-nos-request-id': 'aa1c14690af100000155fb8d577415fb',
    'content-length': '0',
    connection: 'close',
    server: 'Jetty(6.1.11)' }

**注:**

* 支持跨桶的文件copy
### 移动文件

你可以使用NosClient.move_object移动文件:

    var map = {
        src_bucket: 'srcBucketName', //源桶名
        src_key: 'srcObjectName', //源对象名
        dest_bucket: 'destBucketName', //目标桶名
        dest_key: 'destObjectName' //目标对象名
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.move_object(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'aa1c14690af100000155fb8d577415fb',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

**注:**

* 暂时不支持跨桶的文件move
### 修改文件元信息

暂时不提供此类方法

### 获取文件的文件元信息

你可以使用NosClient.head_object获取文件元信息:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName' //对象名
    };
    var cb = function(result) {
        console.log(result);
    }
    
    try {
        nosclient.head_object(map, cb);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
    }

回调函数的参数result中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': '346251790af100000155fb76baac15fb',
     etag: '926d74ef88054b6586a5530c5c6606b3',
     'content-length': '18',
     'last-modified': 'Mon, 18 Jul 2016 08:33:12 Asia/Shanghai',
     'content-type': 'application/octet-stream',
     'cache-control': 'no-cache',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

## 错误处理

### 异常处理

调用NosClient类的相关接口时，如果抛出异常，则表明操作失败，否则操作成功。抛出异常时，方法返回的数据无效。

### 异常处理实例

错误处理代码如下所示:

    try {
        nosclient.delete_objects({
            bucket: 'bucketName',
            keys: [{Key: 'objectName1'},{Key: 'objectName2'}]
        },
        func);
    }
        catch(err) {
        console.log("Failed with code:" + err.code);
        console.log("Failed with statusCode:" + err.statusCode + "\terrorCode:" + err.errorCode + "\tmessage:" + err.message + "\trequestId:" + err.requestId + "\tresource:" + err.resource);
    }

### 异常包含的信息

异常包括两类:

A.客户端异常，包括参数无效、文件不存在等错误。该类错误可以通过err.code获取错误信息。

B.服务器端异常，指NOS返回的错误，比如无权限、文件不存在等。该类异常包含以下信息：

* 1.statusCode: HTTP状态码，通过方法err.statusCode获取。
* 2.errorCode： NOS返回给用户的错误码，通过方法err.errorCode获取。
* 3.message： NOS提供的错误描述，通过方法err.message获取。
* 4.requestId： 用于唯一标识该请求的UUID；当你无法解决问题时，可以凭这个来请求NOS开发工程师的帮助。通过方法err.requestId获取。
* 5.resource： NOS返回的包含了Bucket或Object的请求资源描述符。通过方法err.resource获取。
