# REST API

### **错误响应格式**

发生错误时，服务端的响应包括

* 相应的 HTTP 3xx，4xx，5xx 状态码（HTTP Status Code）
* Content-Type:application/xml
* XML 格式的消息体
下面是一个 XML 格式消息体的例子

   

     <?xml version="1.0" encoding="UTF-8"?>
        <Error>
            <Code>NoSuchKey</Code>
            <Message>The resource you requested does not exist</Message>
            <Resource>/myBucket/1.jpg</Resource>
            <RequestId>123456</Request>
        </Error>

下面这个表格定义了错误响应的 XML 元素

|  **错误码**  |	                 **HTTP 状态码**                         |
|--------------|-------------------------------------------------------------|
|Code|	错误代码，唯一标识了一种类型的错误。类型：字符串 父节点：Error|
|Error|	错误信息元素。类型：容器 父节点：无|
|Message|	父节点：Error|
|RequestId|	该错误对应的请求 ID 号，请求号主要用于定位某些异常问题 类型：字符串 父节点：Error|
|Resource|	包含了 Bucket 或 Object 的请求资源描述符。类型：字符串 父节点：Error|

如http请求头部中制定 x-nos-entity-type: json ,则返回 JSON 格式消息体，示例如下

    {
        "Error":{
        "Code": "NoSuchKey",
        "Message": "The resource you requested does not exist",
        "Resource": "/myBucket/1.jpg",
        "RequestId": "123456"
        }
    }
