# Node.js SDK 手册

## 使用 https

NOS Node.js SDK 支持使用 https 的方式调用相关的接口，以保证安全性。

### 使用 https
NOS Node.js SDK 默认使用 http 协议，若需使用 https 协议，只需在初始化 NosClient 实例时设置传输协议和客户端证书路径，代码如下：

	var nosclient = new NosClient();
	nosclient.setAccessId('你的 accessKeyId');
	nosclient.setSecretKey('你的 accessKeySecret');
	nosclient.setEndpoint('建桶时选择的的区域域名');
	nosclient.setProtocol('https');
	nosclient.setCaPath('你提供的证书的路径');
	nosclient.setPort('443');

<span>Attention:</span>
客户端也可不配置证书，NOS Node.js SDK 会忽略客户端证书验证；
NOS Node.js SDK 默认使用 http 协议，也可以通过 nosclient.setProtocol(‘http’); 设置 http 协议。

### 实例
以下代码实现以 https 的方式上传本地文件，具体实现如下：

	var nosclient = new NosClient();
	nosclient.setAccessId('你的 accessKeyId');
	nosclient.setSecretKey('你的 accessKeySecret');
	nosclient.setEndpoint('建桶时选择的的区域域名');
	nosclient.setProtocol('https');
	nosclient.setCaPath('你提供的证书的路径');
	nosclient.setPort('443');

	var map = {
	    bucket: 'bucketName', //桶名
	    key: 'objectName', //对象名
	    filepath: 'path' //文件路径（包含文件名）
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