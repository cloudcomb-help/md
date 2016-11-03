# Java SDK 手册

## 前言

Java SDK 提供的接口都在 NosClient 中实现，并以成员方法的方式对外提供调用。因此使用 Java SDK 前必须实例化一个 NosClient 对象。

### 关于请求参数
NosClient中的方法一般都提供两种参数传入方式：

* 普通传参方式

        nosClient.createBucket(bucketName)

* request 对象传参方式 

        CreateBucketRequest request = new CreateBucketRequest(bucketName);
        request.setCannedAcl(cannedAcl);
        nosClient.createBucket(request);

后面的使用指南只以其中的一种传参方式作为例子。

### 关于异常
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

## 初始化

1. 确定 Endpoint

    目前有效的Endpoint为：nos-eastchina1.126.net

2. 获取密钥对：使用 NOS-Java-SDK 前，你需要拥有一个有效的 Access Key (包括 Access Key 和 Access Secret )用来进行签名认证。可以通过如下步骤获得：
    * 登录 https://c.163.com/ 注册用户
    * 注册后，蜂巢会颁发 Access Key 和 Secret Key 给客户，你可以在蜂巢“用户中心”的“Access Key”查看并管理你的Access Key

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
Note:
NosClient是线程安全的，可以并发使用

4. 配置 NosClient 如果你需要修改 NosClient 的默认参数，可以在实例化 NosClient 时传入 ClientConfiguration 实例。 ClientConfiguration 是 NosClient 的配置类，可配置连接超时、最大连接数等参数。通过 ClientConfiguration 可以设置的参数见下表：

|**参数**|	         **描述**     	  |**调用方法**|
|--------|----------------------------|------------|
|connectionTimeout|	请求失败后最大的重试次数 默认：3次|	setConnectionTimeout|
|maxConnections|	允许打开的最大HTTP连接数 默认：50|	setMaxConnections|
|socketTimeout|	Socket层传输数据超时时间（单位：毫秒） 默认：50000毫秒|	setSocketTimeout|

带 ClientConfiguration 参数实例化 NosClient 的示例代码：

        maxErrorRetry | 请求失败后最大的重试次数 默认：3次 | setMaxErrorRetry |
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
        // 设置失败请求重试次数
        conf.setMaxErrorRetry(2);
        NosClient nosClient = new NosClient(credentials,conf);
        nosClient.setEndpoint(endPoint);

Note:
后面的示例代码默认你已经实例化了所需的 NosClient 对象
