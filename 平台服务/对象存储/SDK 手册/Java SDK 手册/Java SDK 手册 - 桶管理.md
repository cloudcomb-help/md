# Java SDK 手册

## 桶管理

### 创建桶
你可以通过 NosClient.createBucket 创建一个桶。示例代码如下：

    //设置你要创建桶的名称
    CreateBucketRequest request = new CreateBucketRequest(bucketName);
    //设置桶的权限，如果不设置，默认为Private
    request.setCannedAcl(CannedAccessControlList.PublicRead);
    nosClient.createBucket(request);
    
<span>Attention:</span>
1.桶的命名规范参见 API 文档
2.NOS 中的桶名是全局唯一的，你或者他人已经创建了同名桶，你无法再创建该名称的桶
3.目前通过 SDK 创建桶可能会有 5 分钟缓存时间

### 列举桶
你可以通过 NosClient.listBuckets 列举出当前用户拥有的所有桶。示例代码如下：

    for (Bucket bucket : nosClient.listBuckets()) {
         System.out.println(" - " + bucket.getName());
    }
    
### 删除桶
你可以通过 NosClient.deleteBucket 删除指定的桶。示例代码如下：

    nosClient.deleteBucket(bucketName);

<span>Attention:</span><div class="alertContent">如果指定的桶不为空（桶中有文件或者未完成的分块上传），则桶无法删除</div>

### 查看桶是否存在
你可以通过 NosClient.doesBucketExist 查看指定的桶是否存在。示例代码如下：

    boolean exists = nosClient.doesBucketExist(bucketName);

<span>Attention:</span><div class="alertContent">你或者他人已经创建了指定名称的桶，doesBucketExist 都会返回 true。否则返回 false</div>

### 设置桶的ACL
桶的 ACL 包含两类：Private（私有）, PublicRead（公共读私有写）。你可以通过 NosClient.setBucketAcl 设置桶的权限。

|**权限**|	       **SDK中的对应值**         |
|--------|-----------------------------------|
|私有|	CannedAccessControlList.Private|
|公共读私有写	|CannedAccessControlList.PublicRead|

示例代码如下：

    nosClient.setBucketAcl(bucketName, CannedAccessControlList.Private);

### 查看桶的ACL
你可以通过NosClient.getBucketAcl查看桶的权限。示例代码如下：

    CannedAccessControlList acl = nosClient.getBucketAcl(bucketName);
        // bucket权限
        System.out.println(acl.toString());
