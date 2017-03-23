

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














