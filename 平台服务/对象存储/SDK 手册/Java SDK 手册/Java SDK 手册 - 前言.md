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
