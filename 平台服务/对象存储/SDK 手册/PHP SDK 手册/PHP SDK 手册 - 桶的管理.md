# PHP SDK 手册
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

<span>Attention:</span>
桶的命名规范，请参见 基本概念 桶命名规范 
桶的名字全局唯一，不同用户之间的桶名也不能重复    
关于权限更加详细的说明，请参见: 桶的属性

 
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

<span>Attention:</span>
如果存储空间不为空（存储空间中有文件或者分片上传的分片），则存储空间无法删除；
必须先删除存储空间中的所有文件和分片后，存储空间才能成功删除。

### 设置桶的ACL属性

除了在创建桶的时候可以指定桶的ACL属性之外，也可以根据自己的业务需求对桶的ACL进行修改，这个操作只有桶的拥有者有权限修改，关于桶的权限修改请参考: 桶的属性修改
桶存在两种权限：

|   **权限**  |              **备注**            |
|-------------|--------------------------------|
|私有读写|  NosClient::NOS_ACL_TYPE_PRIVATE|
|公共读私有写|    NosClient::NOS_ACL_TYPE_PUBLIC_READ|

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
