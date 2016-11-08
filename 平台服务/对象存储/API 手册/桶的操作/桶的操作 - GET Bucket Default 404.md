# 桶的操作
### **GET Bucket Default 404**

#### **描述**
获取桶的默认404对象名

#### **语法**

    GET /?default404 HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

#### **相应元素**
|    **Element**    |                 **描述**                 |**是否必须**|
|-------------------|------------------------------------------|------------|
|Key|   设置桶的默认404对象（当该值为空时，表示不设置） 类型：字符串 父节点：Default404Configuration    |Yes|
|Default404Configuration|   桶默认404对象设置容器 类型：容器 子节点：Key| Yes|
#### **示例**
Request

    GET /?default404 HTTP/1.1
    HOST: dream.nos-eastchina1.126.net
    Date: Fri, 10 Feb 2012 21:34:55 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Wed, 01 Mar 2012 21:34:55 GMT
    Connection: close
    Server: NOS
    
    <Default404Configuration>
        <Key>default.404</Key>
    </Default404Configuration>