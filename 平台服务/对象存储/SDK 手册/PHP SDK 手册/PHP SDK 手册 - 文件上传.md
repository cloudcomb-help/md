# PHP SDK 手册
## 文件上传

在 NOS 中用户的基本操作单元是对象，亦可以理解为文件，NOS PHP SDK 提供了丰富的上传接口，可以通过以下的方式上传文件:

* 字符串上传
* 本地文件上传
* 分片上传
字符串上传、本地文件上传最大为 100M，分片上传没有限制

### 字符串上传

您可以使用 NosClient::putObject 上传字符串内容到文件中，具体实现如下:

    <?php
    /**
     * 上传字符串作为 object 的内容
     *
     * @param NosClient $nosClient NosClient 实例
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
     * @param NosClient $nosClient NosClient 实例
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

<span>Attention:</span><div class="alertContent">上传的文件内容不超过 100M</div>

### 分片上传

除了通过 putObject 接口上传文件到 NOS 之外，NOS 还提供了另外一种上传模式-分片上传,用户可以在如下应用场景内（但不限于此），使用分片上传模式，如：

* 需支持断点上传
* 上传超过 100M 的文件
* 网络条件较差，经常和 NOS 服务器断开连接
* 上传文件之前无法确定文件的大小
#### 分片上传本地文件

您可以使用 NosClient::multiuploadFile 来上传一个文件，该方法封装了细节，会根据传入的文件及分片的大小自动选择上传方式,对于分片大小小于文件大下的情况下会使用分片上传:

    <?php
    /**
     * 通过 multipart 上传文件
     *
     * @param NosClient $nosClient NosClient 实例
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

<span>Attention:</span><div class="alertContent">默认的分片大小为 5M</div>

### 原始接口分片上传

您可以使用原始的分片上传接口进行分片上传，一般流程如下所示:

* 初始化一个分片上传任务 (InitiateMultipartUpload)
* 逐个或并行上传分片 (UploadPart)
* 完成分片上传 (CompleteMultipartUpload) 或者取消分片上传 (AbortMultipartUpload)
下面通过一个完整的示例说明了如何通过原始的 api 接口一步一步的进行分片上传操作，如果用户需要做断点续传等高级操作，可以参考下面代码:
<pre><code>
     <?php
        /**
         * 使用基本的 api 分阶段进行分片上传
         *
         * @param NosClient $nosClient NosClient 实例
         * @param string $bucket 存储空间名称
         * @throws NosException
         */
        function putObjectByRawApis($nosClient, $bucket)
        {
            $object = "test/multipart-test.txt";
            /**
             *  step 1. 初始化一个分块上传事件, 也就是初始化上传 Multipart, 获取 upload id
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
            // 分片大小 10M
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

<span>Attention:</span>
上面程序一共分为三个步骤：initiate ;uploadPart ;complete
UploadPart 方法要求除最后一个 Part 以外，其他的 Part 大小都要大于或等于 5M。但是 Upload Part 接口并不会立即校验上传 Part 的大小（因为不知道是否为最后一块）；只有当 Complete Multipart Upload 的时候才会校验。
Part 号码的范围是 1~10000。如果超出这个范围，NOS 将返回 InvalidArgument 的错误码。
每次上传 Part 时都要把流定位到此次上传块开头所对应的位置。
分片上传任务初始化或上传部分分片后，可以使用 abortMultipartUpload 接口中止分片上传事件。当分片上传事件被中止后，就不能再使用这个 Upload ID 做任何操作，已经上传的分片数据也会被删除。
每次上传 Part 之后，NOS 的返回结果会包含一个 PartETag 对象，它是上传块的 ETag 与块编号（PartNumber）的组合。在后续完成分片上传的步骤中会用到它，因此我们需要将其保存起来，然后在第三步 complete 的时候使用，具体操作参考上面代码。

#### 查看已经上传的分片

查看已经上传的分片可以罗列出指定 Upload ID ( InitiateMultipartUpload 时获取) 所属的所有已经上传成功的分片，您可以通过 NosClient::listParts 接口获取已经上传的分片，可以参考以下代码:

 

    /**
        * 查看已上传的分片
        *
        * @param NosClient $nosClient NosClient 实例
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

|  **参数**  |            **描述**               |
|------------|-------------------------------------|
|max-parts| 响应中的 limit 个数 类型：整型|
|part-number-marker|    分块号的界限，只有更大的分块号会被列出来。 类型：字符串|

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

上述代码中使用的 options 参数如下:

|**参数值**|               **描述**                |
|----------|----------------------------------------|
|key-marker|    指定某一 uploads key，只有大于该 key-marker 的才会被列出|
|max-uploads    |最多返回 max-uploads 条记录,默认 1000|

### 设置文件元信息

文件元数据 ( object meta )，是上传到 NOS 的文件属性描述信息:分为 http 标准属性和用户自定义元数据。文件元信息可以在各种上传方式 (字符串上传、文件上传、分片上传) 或 copy 文件时进行设置，元数据大小写不敏感。

设定 http header NOS 允许用户自定义 http Header。http header 相关信息请参考 RFC2616，几个常用的 header 说明如下:

|**名称**|                        **描述**                        |
|--------|------------------------------------------------------|
|Content-MD5|   文件数据校验，设置了该值后 NOS 会启用文件内容 MD5 校验，把您提供的 MD5 与文件的 MD5 比较，不一致会抛出错误|
|Content-Type|  文件的 MIME，定义文件的类型及网页编码，决定浏览器将以什么形式、什么编码读取文件。如果用户没有指定则根据 Key 或文件名的扩展名生成，如果没有扩展名则填默认值|
|Content-Disposition|   指示 MINME 用户代理如何显示附加的文件，打开或下载，及文件名称|
|Content-Length|    上传的文件的长度，超过流/文件的长度会截断，不足为实际值|
|Expires|   缓存过期时间，NOS 未使用，格式是格林威治时间（GMT）|
|Cache-Control| 指定该 Object 被下载时的网页的缓存行为|
下面的源代码实现了上传文件时设置 Http header:

    /**
     * 上传时设置文件的元数据
     *
     * @param NosClient $nosClient NosClient 实例
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

NOS 支持用户自定义对象元数据，上传时可以指定对象自定义元数据，数据放在 http 头中传输，以 x-nos-meta-开头，以下源代码实现对象自定义元数据上传:

    <?php
    /**
     * 上传时设置文件的自定义元数据
     *
     * @param NosClient $nosClient NosClient 实例
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

### 上传时校验 MD5

为了确保 PHP SDK 发送的数 NOS 服务端接收到的数据一致，NOS 支持 MD5 校验。文件上传时（字符串上传、文件上传、分片上传）默认关闭 MD5，如果您需要打开 MD5 校验，请上传文件的 options 设置。

下面的代码实现了上传时开启 MD5 校验:

    <?php
    /**
     * 上传时开启 MD5 校验
     *
     * @param NosClient $nosClient NosClient 实例
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

<span>Attention:</span><div class="alertContent">校验 MD5 会有一定的性能损失</div>
