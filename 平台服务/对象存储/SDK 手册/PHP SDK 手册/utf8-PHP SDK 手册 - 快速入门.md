# PHP SDK 手册
## 快速入门

请确认您已经熟悉 NOS 的基本概念，如 Bucket、Object 、EndPoint 、AccessKeyId 和 AccessKeySecret 等。 本节您将看到如何快速的使用 NOS PHP SDK ,完成常用的操作，创建桶、上传文件、下载文件等。

### 常用类

|**常用类**|                  **备注**                    |
|----------|-----------------------------------------------|
|NOSNosClient|  NOS 客户端类，用户通过 NosClient 调用服务|
|NOSCoreNosException|   NOS 异常，在调用过程中去捕获这个异常，查看失败原因|
### 基本操作

#### 创建桶

您可以使用以下代码新建一个桶:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的 accessKeyId";
    $accessKeySecret = "您的 accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $nosClient->createBucket($bucket);
    } catch(NosException e){
            print e->getMessage();
    }

<span>Attention:</span><div class="alertContent">桶名命名规则请参见 [API 手册桶命名规范](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md)</div>

#### 上传文件

对象（Object）是 NOS 中最基本的数据单元，您可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的 accessKeyId";
    $accessKeySecret = "您的 accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    $object = "使用的对象名，注意命名规则";
    $content = "Hello NOS!";
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $nosClient->putObject($bucket,$object,$content);
    } catch(NosException e){
            print e->getMessage();
    }

<span>Attention:</span><div class="alertContent">对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/对象操作.md)</div>

#### 下载文件

上传对象成功之后，您可以读取它的内容，以下代码可以实现文件的下载:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的 accessKeyId";
    $accessKeySecret = "您的 accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    $object = "使用的对象名，注意命名规则";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $content = $nosClient->getObject($bucket,$object);
            print("object content: " . $content);
    } catch(NosException e){
            print e->getMessage();
    }

#### 列举文件

当上传文件成功之后，可以查看桶中包含的文件列表，以下代码展示如何列举桶内的文件:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的 accessKeyId";
    $accessKeySecret = "您的 accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $listObjectInfo = $nosClient->listObjects($bucket);
            if (!empty($objectList)) {
                    foreach ($objectList as $objectInfo) {
                            print($objectInfo->getKey() . "\t" . $objectInfo->getSize() . "\t" . $objectInfo->getLastModified() . "\n");
                    }
            }
    } catch(NosException e){
            print e->getMessage();
    }

<span>Note:</span><div class="alertContent">上面的代码默认列举 100 个 object</div>

#### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的 accessKeyId";
    $accessKeySecret = "您的 accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    $object = "使用的对象名，注意命名规则";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $content = $nosClient->deleteObject($bucket,$object);
    } catch(NosException e){
            print e->getMessage();
    }

#### 返回结果处理

NosClient 中的接口对应返回数据分为两类:

* Put，Delete 类接口返回 null，如果没有 NosException，即可认为操作成功
* Get，List 类接口返回对应的数据，如果没有 NosException，即可认为操作成功
例如:

<pre><?php
    $bucketListInfo = $nosClient->listBuckets();
    $bucketList = $bucketListInfo->getBucketList();
    foreach($bucketList as $bucket) {
        print($bucket->getLocation() . "\t" . $bucket->getName() . "\t" . $bucket->getCreatedate() . "\n");
    }</pre>

上面代码中的 $bucketListInfo 的数据类型是 NOS\Model\BucketListInfo
