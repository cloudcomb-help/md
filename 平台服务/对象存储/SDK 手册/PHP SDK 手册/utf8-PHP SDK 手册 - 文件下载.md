# PHP SDK 手册
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
     * 获取 object 的内容
     *
     * @param NosClient $nosClient NosClient 实例
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
     * 获取 object
     * 将 object 下载到指定的文件
     *
     * @param NosClient $nosClient NosClient 实例
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

如果存储在 NOS 中的文件较大，并且您只需要其中的一部分内容，您可以使用范围下载，下载指定范围的数据，如果指定的下载范围为”0-100”，则返回结果为第 0 字节到第 100 字节的数据，返回的数据包含第 100 字节，即 [0,100]，如果指定的范围无效则下载整个文件，以下源代码获取 [0,100] 字节的内容:

    <?php
    /**
     * 获取 object 的内容
     *
     * @param NosClient $nosClient NosClient 实例
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

<span>Attention:</span>
下载内容也可以存储到文件中
注意下载的区间为闭区间

### 条件下载

下载文件时，可以指定限定条件，满足限定条件时下载，不满足时报错，不下载文件。可以使用的限定条件如下：

|**参数**|             **说明**             |**NosClient 对应值|
|--------|--------------------------------|-----------------|
|If-Modified-Since| 如果指定的时间早于实际修改时间，则正常传送。否则返回错误|   NosClient::NOS_IF_MODIFIED_SINCE|

    <?php
    /**
     * 如果文件在指定的时间之后修改过，则下载文件
     *
     * @param NosClient $nosClient NosClient 实例
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

<span>Attention:</span><div class="alertContent">下载内容也可以存储到文件中</div>
