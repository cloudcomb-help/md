# PHP SDK 手册

## 安装

### SDK

GitHub 地址: https://github.com/NetEase-Object-Storage/nos-php-sdk

ChangLog: https://github.com/NetEase-Object-Storage/nos-php-sdk/blob/master/README.md

历史版本: 无

### 环境要求

php5.3+ 使用以下命令显示当前的 php 版本:

    php -v

cURL 扩展 使用以下命令查看 curl 扩展是否已经安装好:

    php -m

Windows下用户，请参考 Windows下使用NOS PHP SDK

### 安装

#### composer方式

如果您通过 composer 管理您的项目依赖，可以在你的项目根目录运行:

    composer require netease/nos-php-sdk

或者在你的 composer.json 中声明对 NOS SDK for PHP 的依赖:

    "require": {
    "netease/nos-php-sdk": "1.0.0"
    }

然后通过 conposer install 安装依赖，安装完成后形成如下目录结构:

    .
    ├── app.php
    ├── composer.json
    ├── composer.lock
    └── vendor

其中 app.php 是用户的应用程序，vendor/ 目录下包含了所依赖的库，用户需要在 app.php 中引入如下依赖:

    require_once __DIR__ . '/vendor/autoload.php';

1. 如果项目中已经引用过 autoload.php，则加入了 sdk 依赖之后，不需要再引入 autoload.php 了

2. 如果使用 composer 出现网络错误，可以使用 composer 中国区的镜像源，方法是在命令行执行: composer config -g repositories.packagist composer http://packagist.phpcomposer.com

#### phar 方式

使用 phar 单文件方式，可以在以下 链接,下载已经打好包的 phar 文件，或者根据源文件自行编译，然后在你的源代码中引入 phar 文件:

    require_once '/path/to/nos-sdk-php.phar';

#### 源码方式

使用 SDK 源码，在发布页面，选择相应的版本，下载打好包的 zip 文件，解压后的根目录中包含一个 autoload.php 文件，在您的代码中引入这个文件:

    require_once '/path/to/nos-sdk/autoload.php';

### 运行 Samples

* 解压下载到的 sdk 包
* 修改samples目录中的 Config.php 文件
1. 修改 NOS_ACCESS_ID, 您从 NOS 获得的AccessKeyId

2. 修改 NOS_ACCESS_KEY, 您从 NOS 获得的AccessKeySecret

3. 修改 NOS_ENDPOINT, 您选定的 NOS 数据中心访问域名，例如: nos-eastchina1.126.net

4. 修改 NOS_TEST_BUCKET, 您要用来运行 sample 使用的 bucket，sample 程序会在这个bucket中创建一些文件,注意不能用生产环境的 bucket，以 免污染用户数据

* 到 samples 目录中执行 php RunAll.php， 也可以单个运行某个 Sample 文件

## 初始化

### 确定 EndPoint

EndPoint 是 NOS 各个区域的地址，目前支持以下形式

|**EndPoint 类型**|	               **备注**                 |
|-----------------|-----------------------------------------|
|NOS区域域名地址|	使用桶所在的区域的NOS域名地址|
#### NOS 区域域名地址

进入 NOS 控制台，在桶的属性中可以查找到当前桶所在的区域及域名，桶的域名的后缀部分为 该桶的公网域名，例如: test-logging.nos-eastchina1.126.net 中的 nos-eastchina1.126.net 为该桶的公网 EndPoint 。

### 配置秘钥

要接入 NOS 服务，您需要一对有效的 AccessKey（包括 AccessKeyId 与 AccessKeySecret）来进行 签名验证，开通服务与 AccessKey 请参考 访问控制

在获取到 AccessKeyId 与 AccessKeySecret 之后，可以按照以下的步骤进行初始化

### 新建 NosClient

使用 NOS 地区域名创建 NosClient

初始化代码如下所示:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
    } catch(NosException e){
            print e->getMessage();
    }

### 设置网络参数

我们可以通过 Client 设置一些基本的网络参数:

    <?php
    $nosClient->setTimeout(3600 /* seconds */);
    $nosClient->setConnectTimeout(10 /* seconds */);

其中：

* setTimeout 设置请求超时时间，单位秒，默认是 5184000 秒, 这里建议不要设置太小，如果上传文件很大，消耗的时间会比较长
* setConnectTimeout 设置连接超时时间，单位秒，默认是10秒

## 快速入门

请确认您已经熟悉 NOS 的基本概念，如 Bucket、Object 、EndPoint 、AccessKeyId 和 AccessKeySecret 等。 本节您将看到如何快速的使用 NOS PHP SDK ,完成常用的操作，创建桶、上传文件、下载文件等。

### 常用类

|**常用类**|	               **备注**                    |
|----------|-----------------------------------------------|
|NOSNosClient|	NOS 客户端类，用户通过NosClient调用服务|
|NOSCoreNosException|	NOS异常，在调用过程中去捕获这个异常，查看失败原因|
### 基本操作

#### 创建桶

您可以使用以下代码新建一个桶:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
    $endPoint = "建桶时选择的的区域域名";
    $bucket = "使用的桶名，注意命名规则";
    
    try{
            $nosClient = new NosClient($accessKeyId,$accessKeySecret,$endPoint);
            $nosClient->createBucket($bucket);
    } catch(NosException e){
            print e->getMessage();
    }

Attention:桶名命名规则请参见 [API 手册桶命名规范](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/基本概念.md)

#### 上传文件

对象（Object）是 NOS 中最基本的数据单元，您可以把它简单的理解为文件，以下代码可以实现简单的对象上传:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
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

Attention: 对象命名规则请参见 [API 手册 对象](http://support.c.163.com/md.html#!平台服务/对象存储/API 手册/对象操作.md)

#### 下载文件

上传对象成功之后，您可以读取它的内容，以下代码可以实现文件的下载:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
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
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
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

Note:
上面的代码默认列举100个object

#### 删除文件

文件上传成功后，可以指定删除桶中的文件，以下代码实现桶中文件的删除:

    <?php
    use NOS\NosClient;
    use NOS\Core\NosException;
    
    $accessKeyId = "您的accessKeyId";
    $accessKeySecret = "您的accessKeySecret";
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

NosClient中的接口对应返回数据分为两类:

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

## 桶的管理

桶是 NOS 上的存储空间，也是计费、权限控制、日志记录等高级功能的管理实体。

新建桶

您可以使用 NosClient::createBucket 新建桶：

    <?php
    /**
     * 创建一个桶
     * acl 指的是bucket的访问控制权限，有两种，私有读写，公共读私有写。
     * 私有读写就是只有bucket的拥有者或授权用户才有权限操作
     * 公共读私有写，任意用户可以读，只有授权用户才能写
     * 两种权限分别对应NosClient::NOS_ACL_TYPE_PRIVATE，
     *               NosClient::NOS_ACL_TYPE_PUBLIC_READ,
     *
     * @param NosClient $nosClient NosClient实例
     * @param string    $bucket 要创建的bucket名字
     * @return null
     */
    function createBucket($nosClient, $bucket)
    {
        try {
            $nosClient->createBucket($bucket, NosClient::NOS_ACL_TYPE_PRIVATE);
        } catch (NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention：
 

    1. 桶的命名规范，请参见 基本概念 桶命名规范 
    
     2. 桶的名字全局唯一，不同用户之间的桶名也不能重复
    
     3. 关于权限更加详细的说明，请参见: 桶的属性

 
### 判断桶是否存在

您可以使用 NosClient::doesBucketExist 判断桶是否存在:

    <?php
    /**
     *  判断Bucket是否存在
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 桶名称
     */
    function doesBucketExist($nosClient, $bucket)
    {
        try {
            $res = $nosClient->doesBucketExist($bucket);
        } catch (NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        if ($res === true) {
            print(__FUNCTION__ . ": OK" . "\n");
        } else {
            print(__FUNCTION__ . ": FAILED" . "\n");
        }
    }

### 列出用户所有的桶

您可以使用 NosClient::listBuckets 列出当前用户所有的桶:

    <?php
    /**
     * 列出用户所有的Bucket
     *
     * @param NosClient $nosClient NosClient实例
     * @return null
     */
    function listBuckets($nosClient)
    {
        $bucketList = null;
        try{
            $bucketListInfo = $nosClient->listBuckets();
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        $bucketList = $bucketListInfo->getBucketList();
        foreach($bucketList as $bucket) {
            print($bucket->getName() . "\t" . $bucket->getCreatedate() . "\n");
        }
    }

### 删除桶

您可以使用NosClient::deleteBucket 删除空桶:

    <?php
    /**
     * 删除存储空间
     *
     * @param NosClient $nosClient NosClient实例
     * @param string    $bucket 待删除的桶名称
     * @return null
     */
    function deleteBucket($nosClient, $bucket)
    {
        try{
            $nosClient->deleteBucket($bucket);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:
 

    1. 如果存储空间不为空（存储空间中有文件或者分片上传的分片），则存储空间无法删除；
    
     2. 必须先删除存储空间中的所有文件和分片后，存储空间才能成功删除。

### 设置桶的ACL属性

除了在创建桶的时候可以指定桶的ACL属性之外，也可以根据自己的业务需求对桶的ACL进行修改，这个操作只有桶的拥有者有权限修改，关于桶的权限修改请参考: 桶的属性修改
桶存在两种权限：

|   **权限**  |	           **备注**            |
|-------------|--------------------------------|
|私有读写|	NosClient::NOS_ACL_TYPE_PRIVATE|
|公共读私有写|	NosClient::NOS_ACL_TYPE_PUBLIC_READ|
您可以使用 NosClient::putBucketAcl 设置桶的访问权限:

    <?php
    /**
     * 设置bucket的acl配置
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 桶名称
     * @return null
     */
    function putBucketAcl($nosClient, $bucket)
    {
        $acl = NosClient::NOS_ACL_TYPE_PRIVATE;
        try {
            $nosClient->putBucketAcl($bucket, $acl);
        } catch (NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 获取桶的ACL属性

您可以使用 NosClient::getBucketAcl 获取桶的访问权限:

    <?php
    /**
     * 获取bucket的acl配置
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 桶名称
     * @return null
     */
    function getBucketAcl($nosClient, $bucket)
    {
        try {
            $res = $nosClient->getBucketAcl($bucket);
        } catch (NosException $e) {
    
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
        print('acl: ' . $res);
    }

### 获取桶所处的分区

您可以使用 NosClient::getBucketLocation 获取桶所处的分区:

    <?php
    /**
     * 获取bucket的location配置
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 桶名称
     * @return null
     */
    function getBucketAcl($nosClient, $bucket)
    {
        try {
            $res = $nosClient->getLocation($bucket);
        } catch (NosException $e) {
    
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
        print('location: ' . $res);
    }

## 文件上传

在 NOS 中用户的基本操作单元是对象，亦可以理解为文件，NOS PHP SDK提供了丰富的上传接口，可以通过以下的方式上传文件:

* 字符串上传
* 本地文件上传
* 分片上传
字符串上传、本地文件上传最大为100M，分片上传没有限制

### 字符串上传

您可以使用 NosClient::putObject 上传字符串内容到文件中，具体实现如下:

    <?php
    /**
     * 上传字符串作为object的内容
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function putObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        $content = file_get_contents(__FILE__);
        try{
            $nosClient->putObject($bucket, $object, $content);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 本地文件上传

您可以使用 NosClient::uploadFile 上传文件内容，具体实现如下:

    <?php
    /**
     * 上传指定的本地文件内容
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function uploadFile($nosClient, $bucket)
    {
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
    }

Attention:

 

    1. 上传的文件内容不超过100M

### 分片上传

除了通过putObject接口上传文件到NOS之外，NOS还提供了另外一种上传模式-分片上传,用户可以在如下应用场景内（但不限于此），使用分片上传模式，如：

* 需支持断点上传
* 上传超过100M的文件
* 网络条件较差，经常和NOS服务器断开连接
* 上传文件之前无法确定文件的大小
#### 分片上传本地文件

您可以使用 NosClient::multiuploadFile 来上传一个文件，该方法封装了细节，会根据传入的文件及分片的大小自动选择上传方式,对于分片大小小于文件大下的情况下会使用分片上传:

    <?php
    /**
     * 通过multipart上传文件
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function multiuploadFile($nosClient, $bucket)
    {
        $object = "test/multipart-test.txt";
        $file = __FILE__;
        try{
            $nosClient->multiuploadFile($bucket, $object, $file);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ":  OK" . "\n");
    }

Attention:

 

    1. 默认的分片大小为5M

### 原始接口分片上传

您可以使用原始的分片上传接口进行分片上传，一般流程如下所示:

* 初始化一个分片上传任务(InitiateMultipartUpload)
* 逐个或并行上传分片(UploadPart)
* 完成分片上传(CompleteMultipartUpload)或者取消分片上传(AbortMultipartUpload)
下面通过一个完整的示例说明了如何通过原始的api接口一步一步的进行分片上传操作，如果用户需要做断点续传等高级操作，可以参考下面代码:
<pre><code>
     <?php
        /**
         * 使用基本的api分阶段进行分片上传
         *
         * @param NosClient $nosClient NosClient实例
         * @param string $bucket 存储空间名称
         * @throws NosException
         */
        function putObjectByRawApis($nosClient, $bucket)
        {
            $object = "test/multipart-test.txt";
            /**
             *  step 1. 初始化一个分块上传事件, 也就是初始化上传Multipart, 获取upload id
             */
            try{
                $uploadId = $nosClient->initiateMultipartUpload($bucket, $object);
            } catch(NosException $e) {
                printf(__FUNCTION__ . ": initiateMultipartUpload FAILED\n");
                printf($e->getMessage() . "\n");
                return;
            }
            print(__FUNCTION__ . ": initiateMultipartUpload OK" . "\n");
            /*
             * step 2. 上传分片
             */
            // 分片大小10M
            $partSize = 10 * 1024 * 1024;
            $uploadFile = __FILE__;
            $uploadFileSize = filesize($uploadFile);
            $pieces = $nosClient->generateMultiuploadParts($uploadFileSize, $partSize);
            $responseUploadPart = array();
            $uploadPosition = 0;
            $isCheckMd5 = true;
            foreach ($pieces as $i => $piece) {
                $fromPos = $uploadPosition + (integer)$piece[NosClient::NOS_SEEK_TO];
                $toPos = (integer)$piece[NosClient::NOS_LENGTH] + $fromPos - 1;
                $upOptions = array(
                    $nosClient::NOS_FILE_UPLOAD => $uploadFile,
                    $nosClient::NOS_PART_NUM => ($i + 1),
                    $nosClient::NOS_SEEK_TO => $fromPos,
                    $nosClient::NOS_LENGTH => $toPos - $fromPos + 1,
                    $nosClient::NOS_CHECK_MD5 => $isCheckMd5,
                );
                if ($isCheckMd5) {
                    $contentMd5 = NosUtil::getMd5SumForFile($uploadFile, $fromPos, $toPos);
                    $upOptions[$nosClient::NOS_CONTENT_MD5] = $contentMd5;
                }
                //2. 将每一分片上传到 NOS
                try {
                    $responseUploadPart[] = $nosClient->uploadPart($bucket, $object, $uploadId, $upOptions);
                } catch(NosException $e) {
                    printf(__FUNCTION__ . ": initiateMultipartUpload, uploadPart - part#{$i} FAILED\n");
                    printf($e->getMessage() . "\n");
                    return;
                }
                printf(__FUNCTION__ . ": initiateMultipartUpload, uploadPart - part#{$i} OK\n");
            }
            $uploadParts = array();
            foreach ($responseUploadPart as $i => $eTag) {
                $uploadParts[] = array(
                    'PartNumber' => ($i + 1),
                    'ETag' => $eTag,
                );
            }
            /**
             * step 3. 完成上传
             */
            try {
                $nosClient->completeMultipartUpload($bucket, $object, $uploadId, $uploadParts);
            }  catch(NosException $e) {
                printf(__FUNCTION__ . ": completeMultipartUpload FAILED\n");
                printf($e->getMessage() . "\n");
                return;
            }
            printf(__FUNCTION__ . ": completeMultipartUpload OK\n");
        }

</code></pre>

Attention:
1. 上面程序一共分为三个步骤：1. initiate 2. uploadPart 3. complete

2. UploadPart 方法要求除最后一个Part以外，其他的Part大小都要大于或等于5M。但是Upload Part接口并不会立即校验上传Part的大小（因为不知道是否为最后一块）；只有当Complete Multipart Upload的时候才会校验。

3. Part号码的范围是1~10000。如果超出这个范围，NOS 将返回InvalidArgument的错误码。

4. 每次上传Part时都要把流定位到此次上传块开头所对应的位置。

5. 分片上传任务初始化或上传部分分片后，可以使用abortMultipartUpload接口中止分片上传事件。当分片上传事件被中止后，就不能再使用这个Upload ID做任何操作，已经上传的分片数据也会被删除。

6. 每次上传Part之后，NOS 的返回结果会包含一个 PartETag 对象，它是上传块的ETag与块编号（PartNumber）的组合。在后续完成分片上传的步骤中会用到它，因此我们需要将其保存起来，然后在第三步complete的时候使用，具体操作参考上面代码。

#### 查看已经上传的分片

查看已经上传的分片可以罗列出指定 Upload ID ( InitiateMultipartUpload 时获取)所属的所有已经上传成功的分片，您可以通过 NosClient::listParts 接口获取已经上传的分片，可以参考以下代码:

 

    /**
        * 查看已上传的分片
        *
        * @param NosClient $nosClient NosClient实例
        * @param string $bucket 存储空间名称
        * @param string $uploadId  upload Id
        * @return null
        */
       function listParts($nosClient, $bucket, $uploadId)
       {
           $object = "nos-php-sdk-test/upload-test-object-name.txt";
           try{
               $options = array();
               $options['max-parts'] = 100;
               $optiosn['part-number-marker'] = '10';
               $listPartsInfo = $nosClient->listParts($bucket, $object, $upload_id,$options);
               foreach ($listPartsInfo->getListPart() as $partInfo) {
                   print($partInfo->getPartNumber() . "\t" . $partInfo->getSize() . "\t" . $partInfo->getETag() . "\t" . $partInfo->getLastModified() . "\n");
               }
           } catch(NosException $e) {
               printf(__FUNCTION__ . ": FAILED\n");
               printf($e->getMessage() . "\n");
               return;
           }
           print(__FUNCTION__ . ": OK" . "\n");
       }

查看已经上传的分片可以指定以下参数:

|  **参数**  |          	**描述**               |
|------------|-------------------------------------|
|max-parts|	响应中的limit个数 类型：整型|
|part-number-marker|	分块号的界限，只有更大的分块号会被列出来。 类型：字符串|
#### 查看当前正在进行的分片上传任务

查看正在进行的分片上传任务可以罗列出正在进行，还未完成的分片上传任务，您可以通过 NosClient::listMultipartUploads 接口当前的上传任务，可以参考以下代码:

    <?php
    /**
     * 获取当前未完成的分片上传列表
     *
     * @param $nosClient NosClient
     * @param $bucket   string
     */
    function listMultipartUploads($nosClient, $bucket) {
        $options = array(
                    'max-uploads' => 100,
                    'key-marker' => ''
                );
        try {
            $listMultipartUploadInfo = $nosClient->listMultipartUploads($bucket, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": listMultipartUploads FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        printf(__FUNCTION__ . ": listMultipartUploads OK\n");
        $listUploadInfo = $listMultipartUploadInfo->getUploads();
        var_dump($listUploadInfo);
    }

上述代码中使用的options参数如下:

|**参数值**|	            **描述**                |
|----------|----------------------------------------|
|key-marker|	指定某一uploads key，只有大于该key-marker的才会被列出|
|max-uploads	|最多返回max-uploads条记录,默认1000|

### 设置文件元信息

文件元数据( object meta )，是上传到 NOS 的文件属性描述信息:分为 http 标准属性和用户自定义元数据。文件元信息可以在各种上传方式(字符串上传、文件上传、分片上传)或 copy 文件时进行设置，元数据大小写不敏感。

设定http header NOS 允许用户自定义http Header。http header相关信息请参考 RFC2616，几个常用的header说明如下:

|**名称**|	                    **描述**                        |
|--------|------------------------------------------------------|
|Content-MD5|	文件数据校验，设置了该值后 NOS 会启用文件内容MD5校验，把您提供的MD5与文件的MD5比较，不一致会抛出错误|
|Content-Type|	文件的MIME，定义文件的类型及网页编码，决定浏览器将以什么形式、什么编码读取文件。如果用户没有指定则根据Key或文件名的扩展名生成，如果没有扩展名则填默认值|
|Content-Disposition|	指示MINME用户代理如何显示附加的文件，打开或下载，及文件名称|
|Content-Length|	上传的文件的长度，超过流/文件的长度会截断，不足为实际值|
|Expires|	缓存过期时间，NOS 未使用，格式是格林威治时间（GMT）|
|Cache-Control|	指定该Object被下载时的网页的缓存行为|
下面的源代码实现了上传文件时设置Http header:

    /**
     * 上传时设置文件的元数据
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function putObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        $content = file_get_contents(__FILE__);
        $options = array(
            NosClient::NOS_HEADERS => array(
                'Expires' => '2016-12-12 08:00:00',
                'Content-Disposition' => 'attachment; filename="xxxxxx"',
        ));
        try{
            $nosClient->putObject($bucket, $object, $content, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

#### 用户自定义元数据

NOS 支持用户自定义对象元数据，上传时可以指定对象自定义元数据，数据放在http头中传输，以 x-nos-meta-开头，以下源代码实现对象自定义元数据上传:

    <?php
    /**
     * 上传时设置文件的自定义元数据
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function putObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        $content = file_get_contents(__FILE__);
        $options = array(NosClient::NOS_HEADERS => array(
            'x-nos-meta-self-define-title' => 'user define meta info',
        ));
        try{
            $nosClient->putObject($bucket, $object, $content, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 上传时校验MD5

为了确保 PHP SDK 发送的数 NOS 服务端接收到的数据一致，NOS 支持MD5校验。文件上传时（字符串上传、文件上传、分片上传）默认关闭 MD5，如果您需要打开 MD5 校验，请上传文件的 options 设置。

下面的代码实现了上传时开启 MD5 校验:

    <?php
    /**
     * 上传时开启MD5校验
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function putObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        $options = array(NosClient::NOS_CHECK_MD5 => true);
        try{
            $nosClient->uploadFile($bucket, $object, __FILE__, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:

 

    1. 校验MD5会有一定的性能损失;

## 文件下载

NOS PHP SDK 提供了丰富的文件下载接口，用户可以通过以下方式从 NOS 获取文件:

* 下载文件到内存
* 下载到本地文件
* 分段下载
* 条件下载
### 下载文件到内存

以下源代码实现下载文件到内存中:

    <?php
    /**
     * 获取object的内容
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 桶名称
     * @return null
     */
    function getObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try{
            $content = $nosClient->getObject($bucket, $object);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 下载文件到本地文件

    <?php
    /**
     * get_object_to_local_file
     *
     * 获取object
     * 将object下载到指定的文件
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function getObjectToLocalFile($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/download-test-object-name.txt";
        $localfile = "download-test-object-name.txt";
        $options = array(
            NosClient::NOS_FILE_DOWNLOAD => $localfile,
        );
        try{
            $nosClient->getObject($bucket, $object, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK, please check localfile: 'upload-test-object-name.txt'" . "\n");
    }

### 范围下载

如果存储在NOS中的文件较大，并且您只需要其中的一部分内容，您可以使用范围下载，下载指定范围的数据，如果指定的下载范围为”0-100”，则返回结果为第0字节到第100字节的数据，返回的数据包含第100字节，即[0,100]，如果指定的范围无效则下载整个文件，以下源代码获取[0,100]字节的内容:

    <?php
    /**
     * 获取object的内容
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function getObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try{
            $options = array(NosClient::NOS_RANGE => '0-100');
            $content = $nosClient->getObject($bucket, $object, $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:

 

    1. 下载内容也可以存储到文件中
     2. 注意下载的区间为闭区间

### 条件下载

下载文件时，可以指定限定条件，满足限定条件时下载，不满足时报错，不下载文件。可以使用的限定条件如下：

|**参数**|	         **说明**             |**NosClient对应值|
|--------|--------------------------------|-----------------|
|If-Modified-Since|	如果指定的时间早于实际修改时间，则正常传送。否则返回错误|	NosClient::NOS_IF_MODIFIED_SINCE|

    <?php
    /**
     * 如果文件在指定的时间之后修改过，则下载文件
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function getObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try{
            $options = array(
                NosClient::NOS_HEADERS => array(
                    NosClient::NOS_IF_MODIFIED_SINCE => "Fri, 13 Nov 2016 14:47:53 GMT"),
        );
            $content = $nosClient->getObject($bucket, $object， $options);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:

 

    1. 下载内容也可以存储到文件中

## 文件管理

在NOS中，用户可以通过一系列的接口管理桶(Bucket)中的文件(Object)，比如ListObjects，DeleteObject，CopyObject，DoesObjectExist等。

### 列出桶中的文件

您可以使用NosClient::listObjects列出存储中间中的文件:

    <?php
    /**
     * 列出Bucket内所有目录和文件， 根据返回的nextMarker循环调用listObjects接口得到所有文件
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function listAllObjects($nosClient, $bucket)
    {
        for ($i = 0; $i < 100; $i += 1) {
            $nosClient->putObject($bucket, "dir/obj" . strval($i), "hi");
        }
        $prefix = 'dir/';
        $delimiter = '/';
        $nextMarker = '';
        $maxkeys = 30;
        while (true) {
            $options = array(
                'delimiter' => $delimiter,
                'prefix' => $prefix,
                'max-keys' => $maxkeys,
                'marker' => $nextMarker,
            );
            var_dump($options);
            try {
                $listObjectInfo = $nosClient->listObjects($bucket, $options);
            } catch (NosException $e) {
                printf(__FUNCTION__ . ": FAILED\n");
                printf($e->getMessage() . "\n");
                return;
            }
            var_dump($listObjectInfo);
            // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表
            $nextMarker = $listObjectInfo->getNextMarker();
            $listObject = $listObjectInfo->getObjectList();
            var_dump($listObject);
            if ($nextMarker === '') {
                break;
            }
        }
    
    }

上述代码中的$options中的参数如下所示:

|**参数**|	              **说明**               |
|--------|---------------------------------------|
|delimiter|	用于对Object名字进行分组的字符。所有名字包含指定的前缀且第一次出现delimiter字符之间的object作为一组元素|
|prefix|	限定返回的object key必须以prefix作为前缀。注意使用prefix查询时，返回的key中仍会包含prefix|
|max-keys|	限定此次返回object的最大数，如果不设定，默认为100|
|marker|	设定结果从marker之后按字母排序的第一个开始返回|
Note：

上述表中的参数都是可选参数
### 判断文件是否存在

您可以使用NosClient::doesObjectExist判断文件是否存在:

    <?php
    /**
     * 判断object是否存在
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket bucket名字
     * @return null
     */
    function doesObjectExist($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try{
            $exist = $nosClient->doesObjectExist($bucket, $object);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
        var_dump($exist);
    }

### 删除单个文件

您可以使用NosClient::deleteObject删除单个需要删除的文件:

    <?php
    /**
     * 删除object
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket bucket名字
     * @return null
     */
    function deleteObject($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try{
            $nosClient->deleteObject($bucket, $object);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 删除多个文件

您可以使用NosClient::deleteObjects批量删除文件:

    <?php
    /**
     * 批量删除object
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket bucket名字
     * @return null
     */
    function deleteObjects($nosClient, $bucket)
    {
        $objects = array();
        $objects[] = "nos-php-sdk-test/upload-test-object-name.txt";
        $objects[] = "nos-php-sdk-test/upload-test-object-name.txt.copy";
        try{
            $nosClient->deleteObjects($bucket, $objects);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

### 拷贝文件

您可以使用NosClient::copyObject拷贝文件:

    <?php
    /**
     * 拷贝object
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket bucket名字
     * @return null
     */
    function copyObject($nosClient, $bucket)
    {
        $from_bucket = $bucket;
        $from_object = "nos-php-sdk-test/upload-test-object-name.txt";
        $to_bucket = $bucket;
        $to_object = $from_object . '.copy';
        try{
            $nosClient->copyObject($from_bucket, $from_object, $to_bucket, $to_object);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:

     1. 支持跨桶的文件copy

### 移动文件

您可以使用NosClient::moveObject移动文件:

    <?php
    /**
     * 移动Object
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket bucket名字
     * @return null
     */
    function copyObject($nosClient, $bucket)
    {
        $from_bucket = $bucket;
        $from_object = "nos-php-sdk-test/upload-test-object-name.txt";
        $to_bucket = $bucket;
        $to_object = $from_object . '.move';
        try{
            $nosClient->moveObject($from_bucket, $from_object, $to_bucket, $to_object);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

Attention:

 

    1. 暂时不支持跨桶的文件move

### 修改文件元信息

暂时不提供此类方法

### 获取文件的文件元信息

您可以使用NosClient::getObjectMeta获取对象的元数据信息:

    <?php
    /**
     * 获取object meta, 也就是getObjectMeta接口
     *
     * @param NosClient $nosClient NosClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    function getObjectMeta($nosClient, $bucket)
    {
        $object = "nos-php-sdk-test/upload-test-object-name.txt";
        try {
            $objectMeta = $nosClient->getObjectMeta($bucket, $object);
        } catch (NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
        if (isset($objectMeta[strtolower('Content-Disposition')]) &&
            'attachment; filename="xxxxxx"' === $objectMeta[strtolower('Content-Disposition')]
        ) {
            print(__FUNCTION__ . ": ObjectMeta checked OK" . "\n");
        } else {
            print(__FUNCTION__ . ": ObjectMeta checked FAILED" . "\n");
        }
    }

Attention:

 

    1. 获取的元数据通过一个array返回，返回值为HTTP头类型的元数据与用户自定义元数据
     2. 元数据名的大小均为小写

## 授权访问

通过生成签名URL的形式提供给用户一个临时的访问URL。在生成URL时，您可以指定URL过期的时间，从而限制用户长时间访问。

生成私有下载链接 生成 GetObject 的签名 url 示例如下:

    <?php
    /**
     * 生成GetObject的签名url,主要用于私有权限下的读访问控制
     *
     * @param $nosClient NosClient NosClient实例
     * @param $bucket string bucket名称
     * @return null
     */
    function getSignedUrlForGettingObject($nosClient, $bucket)
    {
        $object = "test/test-signature-test-upload-and-download.txt";
        $timeout = 3600; // URL的有效期是3600秒
        try{
            $signedUrl = $nosClient->signUrl($bucket, $object, $timeout);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": signedUrl: " . $signedUrl. "\n");
        /**
         * 可以类似的代码来访问签名的URL，也可以输入到浏览器中去访问
         */
        $request = new RequestCore($signedUrl);
        $request->set_method('GET');
        $request->send_request();
        $res = new ResponseCore($request->get_response_header(), $request->get_response_body(), $request->get_response_code());
        if ($res->isOK()) {
            print(__FUNCTION__ . ": OK" . "\n");
        } else {
            print(__FUNCTION__ . ": FAILED" . "\n");
        };
    }

