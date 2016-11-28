
## 文件下载

NOS Node SDK 提供了丰富的文件下载接口，用户可以通过以下方式从 NOS 获取文件:

* 下载文件到内存
* 下载到本地文件
* 指定范围下载
* 条件下载

### 下载文件到内存

你可以通过 NosClient.get_object_stream 接口下载文件到内存，可以参考以下代码:

    ivar map = {
            bucket: 'bucketName', //桶名
            key: 'objectName' //对象名
    };
    var cb = function(result) {
            //打印 statusCode
            console.log(result['statusCode']);
            //打印 content-length
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

回调函数的参数 result 中包含的内容示例:

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

你可以通过 NosClient.get_object_file 接口下载文件到本地文件，可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath' //本地文件路径 (包括文件名)
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

回调函数的参数 result 中包含的内容示例:

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

如果存储在 NOS 中的文件较大，并且你只需要其中的一部分内容，你可以使用范围下载，下载指定范围的数据，如果指定的下载范围为”0-100”，则返回结果为第 0 字节到第 100 字节的数据，返回的数据包含第 100 字节，即 bytes=0-100，如果指定的范围无效则下载整个文件，以下源代码获取 bytes=0-100 字节的内容,可以参考以下代码:

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath', //本地文件路径 (包括文件名)
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

回调函数的参数 result 中包含的内容示例:

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

<span>Attention:</span>
下载内容也可以存储到文件中
注意下载的区间为闭区间

### 条件下载

下载文件时，可以指定限定条件，满足限定条件时下载，不满足时报错，不下载文件。可以使用的限定条件如下：

|**参数**|	                   **说明**                       |
|--------|----------------------------------------------------|
|if_modified_since|如果指定的时间早于实际修改时间，则正常传送。否则返回错误|

    var map = {
        bucket: 'bucketName', //桶名
        key: 'objectName', //对象名
        path: 'destpath', //本地文件路径 (包括文件名)
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

回调函数的参数 result 中包含的内容示例:

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

<span>Attention:</span><div class="alertContent">下载内容也可以存储到文件中</div>
