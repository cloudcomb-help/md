# Java SDK 手册

## 文件上传

在 NOS 中，用户的每个文件都是一个 Object (对象)。

NOS 提供两种文件上传方式：普通上传（PutObject)，上传小于或等于 100M 的文件；分块上传（MultiUpload），大文件可以采用该方式上传。

NOS Java SDK 提供了丰富的文件上传接口与功能，主要有：

* 本地文件普通上传
* 支持上传文件时设置文件元数据信息
* 流式上传
* 分块上传

### 本地文件普通上传

对于小对象可以使用 putObject 接口进行上传，putObject 上传支持的最大文件大小为100M，如果上传大于100M的文件需要使用分块上传。本地文件普通上传的示例代码如下：

    //要上传文件的路径
    String filePath = "your-local-file-path";
    try {
       nosClient.putObject("your-bucketname","your-objectname", new File(filePath));
    }catch (Exception e){
       System.out.println(e.getMessage());
    }

### 上传文件时设置文件元数据信息
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

### 流式上传
   

    try {
          ObjectMetadata objectMetadata = new ObjectMetadata();
          //设置流的长度，你还可以设置其他文件元数据信息
          objectMetadata.setContentLength(streamLength);
          nosClient.putObject("your-bucketname","your-objectname", inputStream, objectMetadata)
       }catch (Exception e){
          System.out.println(e.getMessage());
       }

### 分块上传
对于大于 100M 的对象必须进行分块上传，分块上传的最小单位单位为 16K ，最后一块可以小于 16K，最大单位为 100M，较大文件使用分块上传失败的代价比较小，只需要重新上传失败的分块即可； 在文件已经全部存在情况下可以进行分块并发上传。

* 初始化分块上传

<pre>//初始化一个分块上传，获取分块上传ID，桶名 + 对像名 + 分块上传ID 唯一确定一个分块上传
is = new FileInputStream("youFilePath");
InitiateMultipartUploadRequest  initRequest = new InitiateMultipartUploadRequest("your-bucketname", "your-objectname");
//你还可以在初始化分块上传时，设置文件的Content-Type
ObjectMetadata objectMetadata = new ObjectMetadata();
objectMetadata.setContentType("application/xml");
initRequest.setObjectMetadata(objectMetadata);
InitiateMultipartUploadResult initResult = nosClient.initiateMultipartUpload(initRequest);
String uploadId = initResult.getUploadId();</pre>

* 进行分块上传
下面是顺序上传所有分块的示例，你也可以进行并发上传。

<pre>//分块上传的最小单位为16K，最后一块可以小于16K，每个分块都得标识一个唯一的分块partIndex
 while ((readLen = is.read(buffer, 0, buffSize)) != -1 ){
   InputStream partStream = new ByteArrayInputStream(buffer);
   nosClient.uploadPart(new UploadPartRequest().withBucketName("your-bucketname")
            .withUploadId(uploadId).withInputStream(partStream)
            .withKey("you-objectname").withPartSize(readLen).withPartNumber(partIndex));
   partIndex++;
 }</pre>

* 列出所有分块
  
<pre>//这里可以检查分块是否全部上传，分块MD5是否与本地计算相符，如果不符或者缺少可以重新上传    
List<PartETag> partETags = new ArrayList<PartETag>();

int nextMarker = 0;
while (true) {
   ListPartsRequest listPartsRequest = new ListPartsRequest("your-bucketname", "your-objectname", uploadId);
   listPartsRequest.setPartNumberMarker(nextMarker);

   PartListing partList = nosClient.listParts(listPartsRequest);

   for (PartSummary ps : partList.getParts()) {
       nextMarker++;
       partETags.add(new PartETag(ps.getPartNumber(), ps.getETag()));
   }

   if (!partList.isTruncated()) {
       break;
   }
}</pre>

* 完成分块上传
   
<pre>CompleteMultipartUploadRequest completeRequest =  new CompleteMultipartUploadRequest("your-bucketname","your-objectname", uploadId, partETags);
CompleteMultipartUploadResult completeResult = nosClient.completeMultipartUpload(completeRequest);</pre>