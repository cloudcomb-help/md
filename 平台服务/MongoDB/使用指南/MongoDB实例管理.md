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

## 性能监控

在实例详情界面，点击「性能监控」标签进入到 MongoDB 实例性能监控界面，该页面默认展示了 CPU 利用率、数据盘空间利用率、IO 利用率、可用存储空间、CRUD、慢查询数、连接数、待处理请求队列、断言、复制延迟的监控数据，可以基于用户指定的时间范围，提供不同聚合区间和实时监控功能。

![](../image/性能监控.png)

用户可点击「视图管理」在视图管理中点击「添加视图」进行自定义视图，在视图中加入自己需要监控的指标，新建完视图后可以在性能监控页的「视图名称」中选择自己定义的视图，这样性能监控中展示的便为用户自己选择的监控数据。

![](../image/视图管理.png)
![](../image/添加视图.png)

添加视图页中需要填写视图名称，在「选择视图」中选择自己需要的监控项，点击「立即添加」即可完成视图的添加。
![](../image/添加视图页.png)

视图管理中可以对已经创建的视图进行删除和编辑。
![](../image/视图删除编辑.png)

## 备份管理
在实例详情界面，点击「备份管理」标签进入到备份管理界面，如下图所示：
![](../image/备份管理.png)

手动创建备份
你可以通过点击「手动创建备份」按钮手动地创建备份。在弹出对的话框中按提示指定要创建的备份名称，如下图所示：
![](../image/手动备份.png)
点击「确定」开始备份，点击「取消」退回到备份管理界面。

恢复备份
你可以恢复可用的备份，点击「恢复」，进入恢复备份设置界面。恢复操作与创建实例相同，点击「立即恢复」后，会产生一个新的 MongoDB 实例，包含了该备份的数据。
![](../image/恢复.png)

删除备份
你可以选择删除现有的某个备份，如下图所示：
![](../image/删除备份.png)

## 日志管理
### MongoDB 运行日志
在实例详情页面中，点击「运行日志」，可查看该实例的运行日志；点击「查看更多运行日志」，可以加载更多的运行日志，如下图所示：
![](../image/运行日志.png)

### 操作日志
在实例详情页面中，点击「操作日志」，可查看该实例的操作日志。该日志中记录该实例的所有管理操作，包括实例创建、实例备份、实例恢复等，如下图所示：













