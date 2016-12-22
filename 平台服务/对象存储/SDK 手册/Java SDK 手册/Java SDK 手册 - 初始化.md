# Java SDK 手册

## 初始化

1.确定 Endpoint

    目前有效的Endpoint为：nos-eastchina1.126.net

2.获取密钥对：使用 NOS-Java-SDK 前，你需要拥有一个有效的 Access Key (包括 Access Key 和 Access Secret )用来进行签名认证。可以通过如下步骤获得：

* 登录 https://c.163.com/ 注册用户
* 注册后，蜂巢会颁发 Access Key 和 Secret Key 给客户，你可以在蜂巢“用户中心”的“Access Key”查看并管理你的Access Key

3.在代码中实例化 NosClient

        import com.netease.cloud.ClientConfiguration;
        import com.netease.cloud.auth.BasicCredentials;
        import com.netease.cloud.auth.Credentials;
        import com.netease.cloud.services.nos.NosClient;
        String accessKey = "your-accesskey";
        String secretKey = "your-secretKey ";
        Credentials credentials = new BasicCredentials(accessKey, secretKey);
        NosClient nosClient = new NosClient(credentials);
        nosClient.setEndpoint(endPoint);

<span>Note:</span><div class="alertContent">NosClient是线程安全的，可以并发使用</div>

4.配置 NosClient 如果你需要修改 NosClient 的默认参数，可以在实例化 NosClient 时传入 ClientConfiguration 实例。 ClientConfiguration 是 NosClient 的配置类，可配置连接超时、最大连接数等参数。通过 ClientConfiguration 可以设置的参数见下表：

|        参数       |                            描述                            |       调用方法       |
|-------------------|------------------------------------------------------------|----------------------|
| connectionTimeout | 请求失败后最大的重试次数<br>默认：3 次                     | setConnectionTimeout |
| maxConnections    | 允许打开的最大HTTP连接数<br>默认：50                       | setMaxConnections    |
| socketTimeout     | Socket层传输数据超时时间（单位：毫秒）<br>默认：50000 毫秒 | setSocketTimeout     |
| maxErrorRetry     | 请求失败后最大的重试次数<br>默认：3次                      | setMaxErrorRetry     |
| protocol          | 使用 http 协议还是 https 协议<br>默认：http协议            | setProtocol          |

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
        // 如果要用https协议，请加上下面语句
        conf.setProtocol(Protocol.HTTPS);

        NosClient nosClient = new NosClient(credentials,conf);
        nosClient.setEndpoint(endPoint);

<span>Note:</span><div class="alertContent">后面的示例代码默认你已经实例化了所需的 NosClient 对象</div>
