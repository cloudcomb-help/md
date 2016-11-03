# Node.js SDK 手册

## 快速入门

使用NOS Node SDK前，你可以先参照 [API 手册](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md) 熟悉NOS的基本概念，如Bucket、Object、EndPoint、AccessKeyId和AccessKeySecret等。 本节你将看到如何快速的使用NOS Node SDK，完成常用的操作，上传文件、下载文件等。

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

对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md)

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

