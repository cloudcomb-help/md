# Node.js SDK 手册

## php 使用 openssl 相关配置
php curl 使用 ssl 需要安装和配置 php_openssl 的扩展，具体的安装及配置方式请查看 [php document openssl安装/配置](http://php.net/manual/zh/openssl.setup.php)。

## 使用https
只需要将 endpoint 从 `http://nos-eastchina1.126.net` 修改为 `https://nos-eastchina1.126.net` 就可正常使用 https 的方式访问 NOS。

## 实例
以下代码实现以 https 的方式上传本地文件，具体实现如下：

	<?php
	//以 https 方式上传指定的本地文件内容
 
	use NOS\NosClient;

	$nosClient = new NosClient("xxxxx", "xxxxx", "https://nos-eastchina1.126.net");
	$bucket = "test-https-bucket"
	$object = "nos-php-sdk-test/upload-test-object-name.txt";
	$filePath = __FILE__;
	try{
	    $nosClient->uploadFile($bucket, $object, $filePath);
	} catch(NosException $e) {
	    printf(__FUNCTION__ . ": FAILED\n");
	    printf($e->getMessage() . "\n");
	    return;
	}
	print(__FUNCTION__ . ": OK" . "\n");