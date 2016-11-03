# Java SDK 手册


## 文件管理

你可以通过 NOS Java SDK 进行如下文件管理操作：

* 判断文件是否存在
* 文件删除
* 获取文件元数据信息
* 文件复制(copy)
* 文件重命名(move)
* 列举桶内文件
* 生成私有对象可下载的URL连接

### 判断文件是否存在
你可以通过 NosClient.doesObjectExist 判断文件是否存在

    boolean isExist = nosClient.doesObjectExist("your-bucketname","your-objectname");

### 文件删除
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

### 获取文件元数据信息
你可以通过 NOSClient.getObjectMetadata 获取文件元数据信息

    nosClient.getObjectMetadata("your-bucketname","your-objectname");

### 文件复制（copy）
你可以通过 NOSClient.copyObject 接口实现文件拷贝功能。 NOS 支持桶内 copy 以及相同用户的跨桶 copy 。

    nosClient.copyObject("source-bucket", "source-object", "dst-bucket", "dst-object");

### 文件重命名（move）
你可以通过 NOSClient.moveObject 接口实现文件重命名功能。 NOS 仅支持桶内 move。
    
    nosClient.moveObject("bucket-name", "source-object-key", "bucket-name", "dst-object-key");

### 列举桶内文件
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

#### 简单列举

简单列举只需指定需要列举的桶名，最多返回100条对象记录，建议桶内对象数较少时（小于100）使用。   

    ObjectListing objectListing = nosClient.listObjects("your-bucketname");
       List<NOSObjectSummary> sums = objectListing.getObjectSummaries();
       for (NOSObjectSummary s : sums) {
         System.out.println("\t" + s.getKey());
       }

#### 通过ListObjectsRequest列举

你还可以通过设置 ListObjectsReques 参数实现各种灵活的查询功能。ListObjectsReques 的可设置的参数如下：

|**设置方法**|          **作用**             |
|------------|-------------------------------|
|setPrefix(String prefix)|	限定返回的object key必须以prefix作为前缀|
|setDelimiter(String delimiter)|	是一个用于对 Object 名字进行分组的字符。所有名字包含指定的前缀且第一次出现 delimiter 字符之间的 object作为一组元素—— CommonPrefixes|
|setMarker(String marker)|	字典序的起始标记，只列出该标记之后的部分|
|setMaxKeys(Integer maxKeys)|	限定返回的数量，返回的结果小于或等于该值(默认值为100)|

1、分页列举桶内的所有文件

   

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

2、使用Delimiter模拟文件夹功能

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

### 生成私有对象可下载的URL链接
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