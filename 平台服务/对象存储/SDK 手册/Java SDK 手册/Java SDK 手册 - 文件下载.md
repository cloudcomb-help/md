# Java SDK 手册

## 文件下载

你可以通过指定桶名和对象名调用 getObject 接口进行文件下载。NOS Java SDK 提供了如下下载方式：

* 流式下载
* 下载到本地文件
* Range下载
* 指定If-Modified-Since进行下载

### 流式下载

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

Attention:
NosClient.getObjec t获取的流一定要显式的 close，否则会造成资源泄露。

### 下载到本地文件
你可以通过调用 NOS Java SDK 的 getObject 接口直接将 NOS 中的对象下载到本地文件   

    String destinationFile = "your-local-filepath";
    GetObjectRequest getObjectRequest = new GetObjectRequest("your-bucketname","your-objectname");
    ObjectMetadata objectMetadata = nosClient.getObject(getObjectRequest, new File(destinationFile));

### Range 下载
NOS Java SDK 支持范围(Range)下载，即下载指定对象的指定范围的数据。
    
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

### 指定 If-Modified-Since 进行下载
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
