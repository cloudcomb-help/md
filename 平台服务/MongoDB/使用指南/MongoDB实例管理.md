# MongoDB 实例管理
在 MongoDB 首页，点击「实例名称」进入实例的详情页面。该页面包含了实例的性能监控、备份管理、详细信息、运行日志和操作日志。

## 实例配置详情
实例的详情页面顶部展示了实例名称、规格和运行状态等基本信息，将鼠标移至详情处可查看实例的基本信息、连接信息、备份信息和计费信息。
![](../image/实例配置详情.png)

### MongoDB URI

![](../image/MongoDBURI.png)

    ”mongodb://username:password@192.168.0.1:27017/admin?replicaSet=comb-set&key=value"

MongoDB Driver 通过 URI 来连接 MongoDB 服务，URI 格式适用于所有官方提供的各种语言驱动，包括 Java、Python 等，URI 格式如上所示。其中 username 和 password 为在 MongoDB 上创建的账号和密码，admin 表示进行该账户鉴权的数据库，MongoDB 的鉴权数据库必须是创建该账号时所在的数据库。蜂巢 MongoDB 服务统一在 admin 库上为用户创建账号。192.168.0.1:27017 表示提供给驱动连接 MongoDB 的种子，蜂巢 MongoDB 提供实例浮动 IP 作为种子。comb-set 为 MongoDB 实例的复制集名称。&号后的 key 和 value 对表示其他可设置的连接参数，可指定多个。下面是使用 Java 驱动连接 MongoDB 的例子：


    public static String mongoConnStr = "59.111.96.48:27017";
      public static String mongoUser = "readwrite";
      public static String mongoPasswd = "xxxx";
      public static String replSet = "wzhmongo";
      public static MongoClient mongoClient;
    
      public static void mongoInit() {  
        String connectStr = "mongodb://" +  mongoUser + ":" + mongoPasswd + "@" + 				mongoConnStr+ "/admin?replicaSet=" + replSet;
        try {
          MongoClientURI uri = new MongoClientURI(connectStr);
          MongoClientOptions.builder().cursorFinalizerEnabled(false);
          mongoClient = new MongoClient(uri);
        } catch (Exception e) {
          System.out.println("Start init MongoClient error: " + e.toString());
          if (mongoClient != null) {
            mongoClient.close();
          }
        }
    }

## 账号管理
账号默认为 root，目前仅支持使用 root 作为账号名称，设置密码并确认密码之后点击「立即创建」账号 root 即新建完成。

![](../image/创建账号.png)

后期需要修改密码时点击「重置密码」，设置新的密码、确认密码之后即可完成密码的修改。
![](../image/重置密码.png)



## 日志管理
### MongoDB 运行日志
在实例详情页面中，点击「运行日志」，可查看该实例的运行日志；点击「查看更多运行日志」，可以加载更多的运行日志，如下图所示：
![](../image/运行日志.png)

### 操作日志
在实例详情页面中，点击「操作日志」，可查看该实例的操作日志。该日志中记录该实例的所有管理操作，包括实例创建、实例备份、实例恢复等，如下图所示：













