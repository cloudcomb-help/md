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
