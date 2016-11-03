# Node.js SDK 手册

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

<span>Attention:</span><div class="alertContent">上述表中的参数都是可选参数</div>

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

<span>Attention:</span><div class="alertContent">支持跨桶的文件copy</div>

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

<span>Attention:</span><div class="alertContent">暂时不支持跨桶的文件move</div>

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

