### **安装**

#### **Java环境**
JDK 6 及以上版本

#### **Maven项目中使用**
在 Maven 工程中使用 NOS Java SDK 只需在 pom.xml 中加入相应依赖即可

   

    <dependency>
         <groupId>com.netease.cloud</groupId>
         <artifactId>nos-sdk-java-publiccloud</artifactId>
         <version>0.0.1</version>
       </dependency>

#### **工程中直接引用jar**
* 下载包含Java SDK及其依赖的开发包： nos-sdk-java-publiccloud-0.0.1.tar.gz；
* 解压该开发包；
* 将解压后文件夹下 lib 文件夹中的 nos-sdk-java-publiccloud-0.0.1.jar 以及 third-party 文件夹下的所有 jar 文件拷贝到你的项目中；
* 在 Eclipse 中选择你的工程，右击 -> Properties -> Java Build Path -> Add JARs；
* 选中你在第三步拷贝的所有 JAR 文件；

### **前言**

Java SDK 提供的接口都在 NosClient 中实现，并以成员方法的方式对外提供调用。因此使用 Java SDK 前必须实例化一个 NosClient 对象。

#### **关于请求参数**
NosClient中的方法一般都提供两种参数传入方式：

* 普通传参方式

   

     nosClient.createBucket(bucketName);

* request对象传参方式
 

    CreateBucketRequest request = new CreateBucketRequest(bucketName);
     request.setCannedAcl(cannedAcl);
     nosClient.createBucket(request);

后面的使用指南只以其中的一种传参方式作为例子。

#### **关于异常**
所有错误异常包装在两个异常类型中，在调用 Java SDK 接口的时候，捕捉这些异常并打印必要的信息有利于定位问题( ps:在 JAVA SDK 使用指南的简单示例代码没有重复赘述，使用时注意添加)。

    try{
        nosClient.XXX("XXX");
    //捕捉 NOS 服务器异常错误
    }catch (ServiceException e1){
        System.out.println("Error Message:    " + e1.getMessage());    //错误描述信息
        System.out.println("HTTP Status Code: " + e1.getStatusCode()); //错误http状态码
        System.out.println("NOS Error Code:   " + e1.getErrorCode());  //NOS 服务器定义错误码
        System.out.println("Error Type:       " + e1.getErrorType());  //NOS 服务器定义错误类型
        System.out.println("Request ID:       " + e1.getRequestId());  //请求 ID,非常重要，有利于对象存储开发人员跟踪异常请求的错误原因
    //捕捉客户端错误
    }catch(ClientException e2){
        System.out.println("Error Message: " + e2.getMessage());       //客户端错误信息
    }

### **初始化**

1.确定 Endpoint

    目前有效的Endpoint为：nos-eastchina1.126.net

2.获取密钥对

使用 NOS-Java-SDK 前，你需要拥有一个有效的 Access Key (包括 Access Key 和 Access Secret )用来进行签名认证。可以通过如下步骤获得：

    1）登录 https://c.163.com/ 注册用户

    2）注册后，蜂巢会颁发 Access Key 和 Secret Key 给客户，你可以在蜂巢“用户中心”的“Access Key”查看并管理你的Access Key

3. 在代码中实例化 NosClient

   

     import com.netease.cloud.ClientConfiguration;
        import com.netease.cloud.auth.BasicCredentials;
        import com.netease.cloud.auth.Credentials;
        import com.netease.cloud.services.nos.NosClient;
     
        String accessKey = "your-accesskey";
        String secretKey = "your-secretKey ";
        Credentials credentials = new BasicCredentials(accessKey, secretKey);
        NosClient nosClient = new NosClient(credentials);
        nosClient.setEndpoint(endPoint);

注：NosClient是线程安全的，可以并发使用

4. 配置 NosClient 如果你需要修改 NosClient 的默认参数，可以在实例化 NosClient 时传入 ClientConfiguration 实例。 ClientConfiguration 是 NosClient 的配置类，可配置连接超时、最大连接数等参数。通过 ClientConfiguration 可以设置的参数见下表：

|**参数**|	         **描述**     	  |**调用方法**|
|--------|----------------------------|------------|
|connectionTimeout|	请求失败后最大的重试次数 默认：3次|	setConnectionTimeout|
|maxConnections|	允许打开的最大HTTP连接数 默认：50|	setMaxConnections|
|socketTimeout|	Socket层传输数据超时时间（单位：毫秒） 默认：50000毫秒|	setSocketTimeout|
|

        maxErrorRetry|	请求失败后最大的重试次数 默认：3次|	setMaxErrorRetry|
        带 ClientConfiguration 参数实例化 NosClient 的示例代码：
        
        import com.netease.cloud.ClientConfiguration;
        import com.netease.cloud.auth.BasicCredentials;
        import com.netease.cloud.auth.Credentials;
        import com.netease.cloud.services.nos.NosClient;
         
        String accessKey = "your-accesskey";
        String secretKey = "your-secretKey ";
        Credentials credentials = new BasicCredentials(accessKey, secretKey);
        ClientConfiguration conf = new ClientConfiguration();
        // 设置NosClient使用的最大连接数
        conf.setMaxConnections(200);
        // 设置socket超时时间
        conf.setSocketTimeout(10000);
        // 设置失败请求重试次
    
    数
    conf.setMaxErrorRetry(2);
    NosClient nosClient = new NosClient(credentials,conf);
    nosClient.setEndpoint(endPoint);

注意：后面的示例代码默认你已经实例化了所需的NosClient对象

### **桶管理**

#### **创建桶**
你可以通过 NosClient.createBucket 创建一个桶。示例代码如下：

    //设置你要创建桶的名称
    CreateBucketRequest request = new CreateBucketRequest(bucketName);
    //设置桶的权限，如果不设置，默认为Private
    request.setCannedAcl(CannedAccessControlList.PublicRead);
    nosClient.createBucket(request);
    
**注意**：

1. 桶的命名规范参见 API 文档

2. NOS 中的桶名是全局唯一的，你或者他人已经创建了同名桶，你无法再创建该名称的桶

3. 目前通过 SDK 创建桶可能会有 5 分钟缓存时间

#### **列举桶**
你可以通过 NosClient.listBuckets 列举出当前用户拥有的所有桶。示例代码如下：

    for (Bucket bucket : nosClient.listBuckets()) {
         System.out.println(" - " + bucket.getName());
    }
    
#### **删除桶**
你可以通过 NosClient.deleteBucket 删除指定的桶。示例代码如下：

nosClient.deleteBucket(bucketName);

**注意**：

如果指定的桶不为空（桶中有文件或者未完成的分块上传），则桶无法删除；

查看桶是否存在[编辑]
你可以通过 NosClient.doesBucketExist 查看指定的桶是否存在。示例代码如下：

boolean exists = nosClient.doesBucketExist(bucketName);
注意：

你或者他人已经创建了指定名称的桶，doesBucketExist 都会返回 true。否则返回 false

#### **设置桶的ACL**
桶的 ACL 包含两类：Private（私有）, PublicRead（公共读私有写）。你可以通过 NosClient.setBucketAcl 设置桶的权限。

|**权限**|	       **SDK中的对应值**         |
|--------|-----------------------------------|
|私有|	CannedAccessControlList.Private|
|公共读私有写	|CannedAccessControlList.PublicRead|
示例代码如下：

    nosClient.setBucketAcl(bucketName, CannedAccessControlList.Private);

#### **查看桶的ACL**
你可以通过NosClient.getBucketAcl查看桶的权限。示例代码如下：

    CannedAccessControlList acl = nosClient.getBucketAcl(bucketName);
        // bucket权限
        System.out.println(acl.toString());

### **文件上传**

在 NOS 中，用户的每个文件都是一个 Object (对象)。

NOS 提供两种文件上传方式：普通上传（PutObject)，上传小于或等于 100M 的文件；分块上传（MultiUpload），大文件可以采用该方式上传。

NOS Java SDK 提供了丰富的文件上传接口与功能，主要有：

* 本地文件普通上传
* 支持上传文件时设置文件元数据信息
* 流式上传
* 分块上传

#### **本地文件普通上传**

对于小对象可以使用 putObject 接口进行上传，putObject 上传支持的最大文件大小为100M，如果上传大于100M的文件需要使用分块上传。本地文件普通上传的示例代码如下：\

    //要上传文件的路径
    String filePath = "your-local-file-path";
    try {
       nosClient.putObject("your-bucketname","your-objectname", new File(filePath));
    }catch (Exception e){
       System.out.println(e.getMessage());
    }

#### **上传文件时设置文件元数据信息**
你可以在上传文件时设置文件元数据信息。可以设置的元数据主要有文件的Content-Type和用户自定义元数据信息。 这里以普通上传为例：

   

    String filePath = "your-local-file-path";
       ObjectMetadata objectMetadata = new ObjectMetadata();
       //设置Content-Type
       objectMetadata.setContentType("application/xml");
       //设置用户自定义元数据信息
       Map<String, String> userMeta = new HashMap<String, String>();
       userMeta.put("ud", "test");
       objectMetadata.setUserMetadata(userMeta);
       PutObjectRequest putObjectRequest = new PutObjectRequest("your-bucketname","your-objectname", new File(filePath));
       putObjectRequest.setMetadata(objectMetadata);
       nosClient.putObject(putObjectRequest);

#### **流式上传**
   

    try {
          ObjectMetadata objectMetadata = new ObjectMetadata();
          //设置流的长度，你还可以设置其他文件元数据信息
          objectMetadata.setContentLength(streamLength);
          nosClient.putObject("your-bucketname","your-objectname", inputStream, objectMetadata)
       }catch (Exception e){
          System.out.println(e.getMessage());
       }

#### **分块上传**
对于大于 100M 的对象必须进行分块上传，分块上传的最小单位单位为 16K ，最后一块可以小于 16K，最大单位为 100M，较大文件使用分块上传失败的代价比较小，只需要重新上传失败的分块即可； 在文件已经全部存在情况下可以进行分块并发上传。

* 初始化分块上传


    //初始化一个分块上传，获取分块上传ID，桶名 + 对像名 + 分块上传ID 唯一确定一个分块上传
    is = new FileInputStream("youFilePath");
    InitiateMultipartUploadRequest  initRequest = new InitiateMultipartUploadRequest("your-bucketname", "your-objectname");
    //你还可以在初始化分块上传时，设置文件的Content-Type
    ObjectMetadata objectMetadata = new ObjectMetadata();
    objectMetadata.setContentType("application/xml");
    initRequest.setObjectMetadata(objectMetadata);
    InitiateMultipartUploadResult initResult = nosClient.initiateMultipartUpload(initRequest);
    String uploadId = initResult.getUploadId();

* 进行分块上传
下面是顺序上传所有分块的示例，你也可以进行并发上传。

 

    //分块上传的最小单位为16K，最后一块可以小于16K，每个分块都得标识一个唯一的分块partIndex
     while ((readLen = is.read(buffer, 0, buffSize)) != -1 ){
       InputStream partStream = new ByteArrayInputStream(buffer);
       nosClient.uploadPart(new UploadPartRequest().withBucketName("your-bucketname")
                .withUploadId(uploadId).withInputStream(partStream)
                .withKey("you-objectname").withPartSize(readLen).withPartNumber(partIndex));
       partIndex++;
     }

* 列出所有分块
  <pre><code>
    //这里可以检查分块是否全部上传，分块MD5是否与本地计算相符，如果不符或者缺少可以重新上传
    
    List<PartETag> partETags = new ArrayList<PartETag>();
    
    int nextMarker = 0;
    while (true) {
       ListPartsRequest listPartsRequest = new ListPartsRequest("your-bucketname", 
                                                     "your-objectname", uploadId);
       listPartsRequest.setPartNumberMarker(nextMarker);
    
       PartListing partList = nosClient.listParts(listPartsRequest);
    
       for (PartSummary ps : partList.getParts()) {
           nextMarker++;
           partETags.add(new PartETag(ps.getPartNumber(), ps.getETag()));
       }
    
       if (!partList.isTruncated()) {
           break;
       }
    }
</code></pre>

* 完成分块上传
   

    CompleteMultipartUploadRequest completeRequest =  new CompleteMultipartUploadRequest(
                                 "your-bucketname","your-objectname", uploadId, partETags);
       CompleteMultipartUploadResult completeResult = nosClient.completeMultipartUpload(completeRequest);

### **文件下载**

你可以通过指定桶名和对象名调用 getObject 接口进行文件下载。NOS Java SDK 提供了如下下载方式：

* 流式下载
* 下载到本地文件
* Range下载
* 指定If-Modified-Since进行下载

#### **流式下载**
  

     NOSObject nosObject = nosClient.getObject("your-bucketname","your-objectname");
       //可以通过NOSObject对象的getObjectMetadata方法获取对象的ContentType等元数据信息
       String contentType = nosObject.getObjectMetadata().getContentType();
       //流式获取文件内容
       InputStream in = nosObject.getObjectContent();
       BufferedReader reader = new BufferedReader(new InputStreamReader(in));
       while (true) {
         String line;
         try {
           line = reader.readLine();
           if (line == null) break;
             System.out.println("\n" + line);
         } catch (IOException e) {
           e.printStackTrace();
         }
       }
       try {
         reader.close();
       } catch (IOException e) {
         e.printStackTrace();
       }

**注意**：

NosClient.getObjec t获取的流一定要显式的 close，否则会造成资源泄露。

#### **下载到本地文件**
你可以通过调用 NOS Java SDK 的 getObject 接口直接将 NOS 中的对象下载到本地文件

   

    String destinationFile = "your-local-filepath";
       GetObjectRequest getObjectRequest = new GetObjectRequest("your-bucketname","your-objectname");
       ObjectMetadata objectMetadata = nosClient.getObject(getObjectRequest, new File(destinationFile));
    Range 下载[编辑]
    NOS Java SDK 支持范围( Range )下载，即下载指定对象的指定范围的数据。
    
       GetObjectRequest getObjectRequest = new GetObjectRequest("your-bucketname","your-objectname");
       getObjectRequest.setRange(0, 100);
       NOSObject nosObject = nosClient.getObject(getObjectRequest);
       BufferedReader reader = new BufferedReader(new InputStreamReader(in));
       while (true) {
         String line;
         try {
           line = reader.readLine();
           if (line == null) break;
             System.out.println("\n" + line);
         } catch (IOException e) {
           e.printStackTrace();
         }
       }
       try {
         reader.close();
       } catch (IOException e) {
         e.printStackTrace();
       }

#### **指定 If-Modified-Since 进行下载**
下载文件时，你可以指定 If-Modified-Since 参数，满足文件的最后修改时间小于等于 If-Modified-Since 参数指定的时间，则不进行下载，否则正常下载文件。

   

    //假设需要下载的文件的最后修改时间为: Date lastModified;
       //lastModified小于等于指定If-Modified-Since参数
       GetObjectRequest getObjectRequest = new GetObjectRequest("your-bucketname","your-objectname");
       Date afterTime = new Date(lastModified.getTime() + 1000);
       getObjectRequest.setModifiedSinceConstraint(afterTime);
       //此时nosObject等于null
       NOSObject nosObject = client.getObject(getObjectRequest);
       Date beforeTime = new Date(lastModified.getTime() -1000);
       getObjectRequest.setModifiedSinceConstraint(beforeTime);
       //此时nosObject不等于null，可以正常获取文件内容
       nosObject = client.getObject(getObjectRequest);
       BufferedReader reader = new BufferedReader(new InputStreamReader(in));
       while (true) {
         String line;
         try {
           line = reader.readLine();
           if (line == null) break;
             System.out.println("\n" + line);
         } catch (IOException e) {
           e.printStackTrace();
         }
       }
       try {
         reader.close();
       } catch (IOException e) {
         e.printStackTrace();
       }

#### **文件管理**

你可以通过 NOS Java SDK 进行如下文件管理操作：

* 判断文件是否存在
* 文件删除
* 获取文件元数据信息
* 文件复制(copy)
* 文件重命名(move)
* 列举桶内文件
* 生成私有对象可下载的URL连接

#### **判断文件是否存在**
你可以通过 NosClient.doesObjectExist 判断文件是否存在。

   

    boolean isExist = nosClient.doesObjectExist("your-bucketname","your-objectname");
    文件删除[编辑]
    你可以通过 NOSClient.deleteObject 删除单个文件
    
       nosClient.deleteObject("your-bucketname","your-objectname");
    你还可以通过 NOSClient.deleteObjects 一次删除多个文件
    
       try {
           DeleteObjectsResult result = nosClient.deleteObjects(deleteObjectsRequest);
           List<DeletedObject>  deleteObjects = result.getDeletedObjects();
           //print the delete results
           for (DeletedObject items: deleteObjects){
             System.out.println(items.getKey());
           }
       // 部分对象删除失败
       } catch (MultiObjectDeleteException e) { 
           List<DeleteError> deleteErrors = e.getErrors();
           for (DeleteError error : deleteErrors) {
               System.out.println(error.getKey());
           }
       } catch (ServiceException  e) {
               //捕捉nos服务器异常错误
       } catch (ClientException ace) {
              //捕捉客户端错误
       }

#### **获取文件元数据信息**
你可以通过 NOSClient.getObjectMetadata 获取文件元数据信息

   

    nosClient.getObjectMetadata("your-bucketname","your-objectname");

#### **文件复制（copy）**
你可以通过 NOSClient.copyObject 接口实现文件拷贝功能。 NOS 支持桶内 copy 以及相同用户的跨桶 copy 。

   

    nosClient.copyObject("source-bucket", "source-object", "dst-bucket", "dst-object");

#### **文件重命名（move）**
你可以通过 NOSClient.moveObject 接口实现文件重命名功能。 NOS 仅支持桶内 move 。

   

    nosClient.moveObject("bucket-name", "source-object-key", "bucket-name", "dst-object-key");

#### **列举桶内文件**
你可以通过 NOSClient.listObjects 列出桶里的文件。listObjects 接口如果调用成功，会返回一个 ObjectListing 对象，列举的结果保持在该对象中。

ObjectListing 的具体信息如下表所示：

|**方法**|	     **含义**       |
|--------|----------------------|
|List<NOSObjectSummary> getObjectSummaries()|	返回的文件列表（包含文件的名称、Etag的元数据信息）|
|String getPrefix()|	本次查询的文件名前缀|
|String getDelimiter()|	文件分界符|
|String getMarker()	|这次List Objects的起点|
|int getMaxKeys()|	响应请求内返回结果的最大数目|
|String getNextMarker()	|下一次List Object的起点|
|boolean isTruncated()|	是否截断，如果因为设置了limit导致不是所有的数据集都返回，则该值设置为true|
|List<String> getCommonPrefixes()|如果请求中指定了delimiter参数，则返回的包含CommonPrefixes元素。该元素标明以delimiter结尾，并有共同前缀的对象的集合|
NOSClient.listObjects 接口提供两种调用方式：简单列举、通过 ListObjectsRequest 列举

**简单列举**

简单列举只需指定需要列举的桶名，最多返回100条对象记录，建议桶内对象数较少时（小于100）使用。

   

    ObjectListing objectListing = nosClient.listObjects("your-bucketname");
       List<NOSObjectSummary> sums = objectListing.getObjectSummaries();
       for (NOSObjectSummary s : sums) {
         System.out.println("\t" + s.getKey());
       }

**通过ListObjectsRequest列举**

你还可以通过设置 ListObjectsReques 参数实现各种灵活的查询功能。ListObjectsReques 的可设置的参数如下：

|**设置方法**|          **作用**             |
|------------|-------------------------------|
|setPrefix(String prefix)|	限定返回的object key必须以prefix作为前缀|
|setDelimiter(String delimiter)|	是一个用于对 Object 名字进行分组的字符。所有名字包含指定的前缀且第一次出现 delimiter 字符之间的 object作为一组元素—— CommonPrefixes|
|setMarker(String marker)|	字典序的起始标记，只列出该标记之后的部分|
|setMaxKeys(Integer maxKeys)|	限定返回的数量，返回的结果小于或等于该值(默认值为100)|

**分页列举桶内的所有文件**

   

    List<NOSObjectSummary> listResult = new ArrayList<NOSObjectSummary>();
       ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
       listObjectsRequest.setBucketName("your-bucketname");
       listObjectsRequest.setMaxKeys(50);
       ObjectListing listObjects = nosClient.listObjects(listObjectsRequest);
       do {
         listResult.addAll(listObjects.getObjectSummaries());
         if (listObjects.isTruncated()) {
           ListObjectsRequest request = new ListObjectsRequest();
           request.setBucketName(listObjectsRequest.getBucketName());
           request.setMarker(listObjects.getNextMarker());
           listObjects =  nosClient.listObjects(request);
         } else {
           break;
         }
       } while (listObjects != null);

**使用Delimiter模拟文件夹功能**

假设桶内有如下对象：a/1.jpg、a/2.jpg、a/b/1.txt、a/b/2.txt，列举a文件夹下的文件及子文件夹的示例代码如下：

   

    ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
       listObjectsRequest.setBucketName("your-bucketname");
       listObjectsRequest.setDelimiter("/");
       listObjectsRequest.setPrefix("a/");
       ObjectListing listing = nosClient.listObjects(listObjectsRequest);
       // 遍历所有Object
       System.out.println("Objects:");
       for (NOSObjectSummary objectSummary : listing.getObjectSummaries()) {
           System.out.println(objectSummary.getKey());
       }
       // 遍历所有CommonPrefix
       System.out.println("CommonPrefixs:");
       for (String commonPrefix : listing.getCommonPrefixes()) {
           System.out.println(commonPrefix);
       }

示例代码的输出如下：

Objects:

a/1.jpg

a/2.jpg

CommonPrefixs:

a/b/

#### **生成私有对象可下载的URL链接**
NOS Java SDK 支持生成可下载私有对象的 URL 连接，你可以将该链接提供给第三方进行文件下载：

   

    Credentials credentials;
       credentials = new BasicCredentials(accessKey, secretKey);
       NosClient client = new NosClient(credentials);
       // 配置client
       String bucketName = "your-bucketname";
       String key = "object-name";
       GeneratePresignedUrlRequest generatePresignedUrlRequest = new GeneratePresignedUrlRequest(bucketName, key);
       generatePresignedUrlRequest.setExpiration(new Date(System.currentTimeMillis()+3600*1000*24));
       // 设置可下载URL的过期时间为1天后
       URL url = nosClient.generatePresignedUrl(generatePresignedUrlRequest);
       System.out.println(url);

### **文件上传下载工具类：TransferManager**

前文提到的是 NOS Java SDK 提供的基础接口，为方便用户进行文件上传下载，NOS Java SDK 提供了封装更好、使用更方便的工具类：TransferManager。

#### **TransferManager的初始化**
   

    //先实例化一个NosClient
       String accessKey = "your-accesskey";
       String secretKey = "your-secretKey ";
       Credentials credentials = new BasicCredentials(accessKey, secretKey);
       NosClient nosClient = new NosClient(credentials);
       nosClient.setEndpoint(endPoint);
       //然后通过nosClient对象来初始化TransferManager
       TransferManager transferManager = new TransferManager(nosClient);

#### **使用TransferManager进行文件上传**
TransferManager 会根据文件大小，选择是否进行分块上传。当文件小于等于 16M 时，TransferManager 会自动调用 PutObject 接口，否则 TransferManager 会自动对文件进行分块上传。 1、上传本地文件：

如果指定上传的本地文件大于 16M，TransferManager 会自动对文件进行分块，并发调用分块上传接口进行上传，大大提高上传文件的速度。

  

     //上传文件
       Upload upload = transferManager.upload("your-bucketname", "your-objectname", new File("your-file"));
       UploadResult  result = upload.waitForUploadResult();

2、流式上传：

你也可以使用 TransferManager 进行流式上传，但是相比本地文件上传，流式上传无法做到多个分块并发上传，只能一个分块一个分块顺序上传。

**注意**: 如果你调用 TransferManager 流式上传的文件大于 100M，必须指定对象的 ContentLength

   

    //流式上传文件
       ObjectMetadata objectMetadata = new ObjectMetadata();
       objectMetadata.setContentLength(file.length());
       Upload upload = transferManager.upload("your-bucketname", "your-objectname", inputStream, objectMetadata);
       UploadResult  result = upload.waitForUploadResult();

3、上传目录

你可以使用 TransferManager 将某个目录下的文件全部上传到 NOS ,对象名即文件名，不支持多级目录

   

    MultipleFileUpload result = transferManager.uploadDirectory("your-buckename", null, new File("dirPath"), false);
       result.waitForCompletion();

4、下载文件

  

     File file = new  File("your-destFile");
       Download download = transferManager.download("your-bucketname", "your-objectname", file);
       download.waitForCompletion();

