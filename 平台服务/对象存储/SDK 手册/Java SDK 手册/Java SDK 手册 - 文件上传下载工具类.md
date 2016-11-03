# Java SDK 手册

## 文件上传下载工具类：TransferManager

前文提到的是 NOS Java SDK 提供的基础接口，为方便用户进行文件上传下载，NOS Java SDK 提供了封装更好、使用更方便的工具类：TransferManager。

### TransferManager的初始化

    //先实例化一个NosClient
    String accessKey = "your-accesskey";
    String secretKey = "your-secretKey ";
    Credentials credentials = new BasicCredentials(accessKey, secretKey);
    NosClient nosClient = new NosClient(credentials);
    nosClient.setEndpoint(endPoint);
    //然后通过nosClient对象来初始化TransferManager
    TransferManager transferManager = new TransferManager(nosClient);

### 使用TransferManager进行文件上传
TransferManager 会根据文件大小，选择是否进行分块上传。当文件小于等于 16M 时，TransferManager 会自动调用 PutObject 接口，否则 TransferManager 会自动对文件进行分块上传。 

1、上传本地文件

如果指定上传的本地文件大于 16M，TransferManager 会自动对文件进行分块，并发调用分块上传接口进行上传，大大提高上传文件的速度。

     //上传文件
       Upload upload = transferManager.upload("your-bucketname", "your-objectname", new File("your-file"));
       UploadResult  result = upload.waitForUploadResult();

2、流式上传

你也可以使用 TransferManager 进行流式上传，但是相比本地文件上传，流式上传无法做到多个分块并发上传，只能一个分块一个分块顺序上传。

Attention:
如果你调用 TransferManager 流式上传的文件大于 100M，必须指定对象的 ContentLength

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

