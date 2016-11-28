# Node.js SDK 手册

## 文件上传

在 NOS 中用户的基本操作单元是对象，亦可以理解为文件，NOS Node SDK 提供了丰富的上传接口，可以通过以下的方式上传文件:

* 流式上传
* 单块上传
* 分块上传

流式上传、单块上传最大为 100M；分块上传除最后一块外，分块不能小于 16 k，每一个分块不能大于 100M，最多能上传 10000 个分块，即分块上传的文件最大支持 1T。

### 流式上传

你可以使用 NosClient.put_object_stream 上传一个 Stream 中的内容，具体实现如下:

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

回调函数的参数 result 中包含的内容示例:

    statusCode: 200
    headers:{
     'x-nos-request-id': '2aa8555c0af100000155fb83034c15fb',
     etag: 'b1335fbca4c89d12719cf99fdcab707e',
     'x-nos-object-name': 'objectName',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

<span>Attention:</span><div class="alertContent">上传的流内容不超过 100M</div>

### 单块上传

你可以使用 NosClient.put_file 上传文件内容，具体实现如下:

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

回调函数的参数 result 中包含的内容示例:

    statusCode: 200
    headers:{
     'x-nos-request-id': '2aa8555c0af100000155fb83034c15fb',
     etag: 'b1335fbca4c89d12719cf99fdcab707e',
     'x-nos-object-name': 'objectName',
     'content-length': '0',
     connection: 'close',
     erver: 'Jetty(6.1.11)' }

<span>Attention:</span><div class="alertContent">上传的文件内容不超过 100M</div>

### 分块上传

除了通过 put_file 接口上传文件到 NOS 之外，NOS 还提供了另外一种上传模式-分块上传,用户可以在如下应用场景内（但不限于此），使用分块上传模式，如：

* 需支持断点上传
* 上传超过 100M 的文件
* 网络条件较差，经常和 NOS 服务器断开连接
* 上传文件之前无法确定文件的大小

#### 分块上传本地文件

你可以使用 NosClient.put_big_file 来上传一个大文件，具体实现如下:

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

回调函数的参数 result 中包含的内容实例:

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

你可以使用 NosClient.create_multipart_upload 初始化分块上传，具体实现如下:

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

回调函数的参数 result 中包含的内容示例:

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

#### 上传分块

你可以使用 NosClient.upload_part 上传文件内容，分块不能小于 16 k，每一个分块不能大于 100M。具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        part_num: 1, //分块数量
        upload_id: '4752043808200245495', //分块上传标识号 (调用初始化分块上传接口 create_multipart_upload 得到)
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

回调函数的参数 result 中包含的内容示例:

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

你可以使用 NosClient.complete_multipart_upload 完成分块上传，最多能上传 10000 个分块，即分块上传的文件最大支持 1T。具体实现如下:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        upload_id: '4752043808200245495', //分块上传标识号 (调用初始化分块上传接口 create_multipart_upload 得到得到)
        info: [{ //调用分块上传接口 upload_part 得到每个分块的 PartNumber 和 ETag
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

回调函数的参数 result 中包含的内容示例:

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

下面通过一个完整的示例说明了如何通过原始的 api 接口一步一步的进行分块上传操作（以每个分块 100M 为例），如果用户需要做断点续传等高级操作，可以参考下面代码:

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

<span>Attention:</span>
上面程序一共分为三个步骤：1. initiate 2. uploadPart 3. complete
Part 号码的范围是 1~10000。如果超出这个范围，NOS 将返回 InvalidArgument 的错误码。
初始化上传之后，获取 upload_id。
每次上传分块时都要把流定位到此次上传块开头所对应的位置。
每次上传分块之后，NOS 的返回结果会包含一个 complete_info 对象，它是上传块的 ETag 与块编号（PartNumber）的组合。在后续完成分片上传的步骤中会用到它，因此我们需要将其保存起来，然后在第三步 complete 的时候使用，具体操作参考上面代码。
这个示例为了防止过多的并发，使用 promise 进行了限制，每次最多只有 10 个并发上传，这样可以防止在网络环境不好的状况下并发连接太多，上传失败。

#### 取消正在上传的分块

分块上传任务初始化或上传部分分块后，可以使用 NosClient.abort_multipart_upload 接口中止分块上传事件。当分块上传事件被中止后，就不能再使用这个 upload_id 做任何操作，已经上传的分块数据也会被删除，可以参考以下代码:

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

回调函数的参数 result 中包含的内容示例:

    statusCode: 200
    headers: {
     'x-nos-request-id': 'f381b02c0af100000155fba0d89e15fb',
     'content-length': '0',
     connection: 'close',
     server: 'Jetty(6.1.11)' }

#### 查看已经上传的分块

查看已经上传的分块可以罗列出指定 upload_id(create_multipart_upload 时获取) 所属的所有已经上传成功的分块，你可以通过 NosClient.list_parts 接口获取已经上传的分块，可以参考以下代码:

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

上述代码中使用的 map 可选参数如下:

|**参数**|	               **描述**                  |
|--------|-------------------------------------------|
|limit|	响应中的 limit 个数. 类型：整型|
|part_number_marker|	分块号的界限，只有更大的分块号会被列出来。 类型：字符串|
回调函数的参数 result 中包含的内容示例:

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
     //part_list 是 parts 的数组，数据每个元素是一个 map，包含 part_number,last_modified,etag,size 信息
    }

#### 查看当前正在进行的分块上传任务

查看正在进行的分块上传任务可以罗列出正在进行，还未完成的分块上传任务，你可以通过 NosClient.list_multipart_upload 接口当前的上传任务，可以参考以下代码:

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

上述代码中使用的 map 参数如下:

|**参数值**|	          **描述**                 |
|----------|---------------------------------------|
|key_marker	|指定某一 key_marker，只有大于该 key_marker 的才会被列出。类型：字符串|
|limit|	最多返回 limit 条记录,默认 1000。类型：整型|
回调函数的参数 result 中包含的内容示例:

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
     //展示每个上传信息的数组，数组的每个元素都是一个 map，包含 key,upload_id,storage_class,owner,initiated 信息
    }

### 设置文件元信息

文件元数据 (object meta)，是上传到 NOS 的文件属性描述信息:分为 http 标准属性和用户自定义元数据。文件元信息可以在各种上传方式 (流式上传、单块上传、分块上传) 进行设置，元数据大小写不敏感。

设定 http header

NOS 允许用户自定义 http Header。http header 相关信息请参考 RFC2616，几个常用的 header 说明如下:

|**参数**|	                   **说明**                       |
|--------|----------------------------------------------------|
|meta_data|	用户自定义的元数据，通过键值对的形式上报，键名和值均为字符串，且键名需以 x-nos-meta-开头。er 字符之间的 object 作为一组元素|
|disposition|	指示 MINME 用户代理如何显示附加的文件，打开或下载，及文件名称|
|contentType|	文件的 MIME，定义文件的类型及网页编码，决定浏览器将以什么形式、什么编码读取文件。如果用户没有指定则根据 Key 或文件名的扩展名生成，如果没有扩展名则填默认值|
|encoding|	文件的编码|
|cacheControl|	指定该 Object 被下载时的网页的缓存行为|
|language|	文件的语言|
|contentMD5|	文件的 MD5|
|object_md5|	仅对上传大对象文件时有效，与 complete_multipart_upload 接口中的 object_md5 含义相同|

下面的源代码实现了上传文件时设置 Http header:

    var meta_data = {
        'x-nos-meta-my-meta': 'user define meta info'
    }
    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        filepath: 'path', //文件路径
        contentType: "image/jpeg", //文件的 MIME 类型
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

回调函数的参数 result 中包含的内容示例:

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

<span>Attention:</span>
各种上传方式（包括流式上传、单块上传、分块上传）都可以设置元数据信息，设置的方式相同。
通过设置文件的 contentType，可以修改文件的类型。
通过设置文件的 disposition，可以控制文件的下载行为。
