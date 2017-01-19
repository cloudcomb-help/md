# Android-SDK

## 前言

### 介绍
本文档主要介绍了NOS Android SDK的安装和使用。在使用Android Sdk前必须要开通NOS服务，并需要拥有一个有效的Access Key(包括Access Key和Access Secret)用来生成上传凭证。可以通过如下步骤获得：

1. 登录 https://c.163.com/ 注册用户
2. 注册后，蜂巢会颁发 Access Key 和 Secret Key 给客户，您可以在蜂巢“用户中心”的“Access Key”查看并管理您的Access Key

## 环境要求
* Android系统版本：2.2及以上
* 需要开通NOS服务

## SDK地址
GitHub地址: [nos-android-sdk](https://github.com/NetEase-Object-Storage/nos-android-sdk)

## 上传凭证
使用Android-Sdk上传需要提供上传凭证，用来表明用户有权限对桶进行上传。

### 本地生成
用户可以将生成上传凭证的逻辑集成到本地，在本地存入Access Key(包括Access Key和Access Secret)，调用SDK里面提供的方法可以生成对应的上传凭证。

	String Bucket = "xxxxx";          # 上传的桶名
	String Object = "xxxxx";          # 上传文件名
	String expires = 1484796958;      # 上传凭证到期时间，单位秒
	String accessKey = "xxxxxxxxxx";  # accessKey
	String secretKey = "xxxxxxxxxx";  # secretkey
	String token = Util.getToken(Bucket, Object, expires,accessKey, secretKey);

该方法风险较大，因为需要将Key存到Android客户端，因此很容易泄漏，安全性很低，不推荐使用。

### 业务服务器生成
用户可以将上传凭证的生成逻辑放到业务服务器，客户端在上传前需要去业务服务器获取上传凭证然后进行上传。上传凭证的生成方法参考 [上传凭证](http://support.c.163.com/md.html#!平台服务/对象存储/直传相关文档/上传凭证.md)

## 功能介绍

Android SDK主要实现了以下几种功能：

* 客户端直传：移动端可以将数据直接上传到NOS，不用经过业务方上传服务器
* 断点续传：网络异常时，可以断点续传，节省用户流量
* 全国加速节点：遍布全国加速节点，自动选择最优的加速节点
* pipeline上传: 默认会使用pipeline上传，如果上传失败，会回退到非pipeline上传流程
* 支持HTTP和HTTPS两种上传协议

## 使用说明

### 导入SDK
请到release目录下，选择最新版本NOS-Android-SDK jar包，我们会不断优化SDK，修复发现的BUG，并保证兼容。 当前最新的版本为nos-android-sdk-1.0.0.jar,内部已经包含了4.0.23版本的netty功能，并移除了netty包中没有用到的代码，同时重命名了包名、类、字段和方法，可以直接导入使用。

### 修改Android Manifest
Android Sdk提供了统计信息上传功能，后续NOS会将用户的上传信息进行汇总，并将用户上传速度、上传成功率、上传次数等指标展示给用户。

独立进程运行直传统计：

	<manifest>
	    <uses-permission android:name="android.permission.INTERNET" />
	    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

	    <application>
	        <!-- 直传统计监控服务：默认情况下120秒发送一次统计信息，没有数据则不发送，运行于独立进程 -->
	        <service android:name="com.netease.cloud.nos.android.service.MonitorService"
	             android:process=":MonitorService" >
	        </service>

	        <!-- 用于接收网络状态改变事件，例如：wifi、2G、3G的切换 -->
	        <receiver
	            android:name="com.netease.cloud.nos.android.receiver.ConnectionChangeReceiver"
	            android:label="NetworkConnection" >
	            <intent-filter>
	                <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
	            </intent-filter>
	        </receiver>
	    </application>
	</manifest>

直传统计非独立进程运行：

	<manifest>
	  <uses-permission android:name="android.permission.INTERNET" />
	  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

	  <application>
	      <!-- 直传统计监控服务：默认情况下120秒发送一次统计信息，没有数据则不发送，非独立进程 -->
	      <service android:name="com.netease.cloud.nos.android.service.MonitorService" />

	      <!-- 用于接收网络状态改变事件，例如：wifi、2G、3G的切换 -->
	      <receiver
	          android:name="com.netease.cloud.nos.android.receiver.ConnectionChangeReceiver"
	          android:label="NetworkConnection" >
	          <intent-filter>
	              <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
	          </intent-filter>
	      </receiver>
	  </application>
	</manifest>

<span>Attention:</span>
当客户端网络状态发生改变时，NOS-Android-SDK需要在下次文件上传时重新发起一次边缘节点查询，以便获取到最佳的接入节点，实现最优上传加速效果；
为了实现覆盖全体用户的最佳上传效果，我们采用实时监控，动态调优的方式；客户端通过MonitorService将用户上传数据推送给NOS，以便NOS决策，给出推荐的接入点；MonitorService可以根据需要配置成运行于独立进程或非独立进程，可参考上面的Manifest修改。

### 使用SDK上传

#### 配置文件说明

	// 对NOS上传加速Android-SDK进行配置，请在初始化时设置配置，初始化完成后修改配置是无效的
	AcceleratorConf conf = new AcceleratorConf();

	// SDK会根据网络类型自动调整上传分块大小，如果网络类型无法识别，将采用设置的上传分块大小
	// 默认32K，如果网络环境较差，可以设置更小的分块
	// ChunkSize的取值范围为：[4K, 4M]，不在范围内将抛异常InvalidChunkSizeException
	conf.setChunkSize(1024 * 32);

	// 设置分块上传失败时的重试次数，默认2次
	// 如果设置的值小于或等于0，将抛异常InvalidParameterException
	conf.setChunkRetryCount(2);

	// 设置文件上传socket连接超时，默认为10s
	// 如果设置的值小于或等于0，将抛异常InvalidParameterException
	conf.setConnectionTimeout(10 * 1000);

	// 设置文件上传socket读写超时，默认30s
	// 如果设置的值小于或等于0，将抛异常InvalidParameterException
	conf.setSoTimeout(30 * 1000);

	// 设置LBS查询socket连接超时，默认为10s
	// 如果设置的值小于或等于0，将抛异常InvalidParameterException
	conf.setLbsConnectionTimeout(10 * 1000);

	// 设置LBS查询socket读写超时，默认10s
	// 如果设置的值小于或等于0，将抛异常InvalidParameterException
	conf.setLbsSoTimeout(10 * 1000);

	// 设置刷新上传边缘节点的时间间隔，默认2小时
	// 合法值为大于或等于60s，设置非法将采用默认值
	// 注：当发生网络切换，Android-SDK会在下次上传文件时做一次接入点刷新
	conf.setRefreshInterval(DateUtils.HOUR_IN_MILLIS * 2;);

	// 设置统计监控程序统计发送间隔，默认120s
	// 合法值为大于或等于60s，设置非法将采用默认值
	conf.setMonitorInterval(120 * 1000);

	// 设置httpClient，默认值为null
	// 非null：使用设置的httpClient进行文件上传和统计信息上传
	// null：使用sdk内部的机制进行文件上传和统计信息上传
	conf.setHttpClient(httpClient);

	// 设置是否用线程进行统计信息上传，默认值为false
	// true：创建线程进行统计信息上传
	// false：使用service进行统计信息上传
	conf.setMonitorThread(true);

	// 配置赋值给上传加速类
	WanAccelerator.setConf(conf);


#### 构造上传对象
	String uploadToken = "I_AM_UPLOAD_TOKEN_FROM_APP_SERVER";
	WanNOSObject wanNOSObject = new WanNOSObject();
	wanNOSObject.setNosBucketName("YOUR_BUCKET_NAME");
	wanNOSObject.setNosObjectName("YOUR_OBJECT_NAME");
	wanNOSObject.setContentType("image/jpeg")     // 请根据实际情况设置正确的MIME-TYPE
	wanNOSObject.setUploadToken(uploadToken);


#### 执行上传

	 /**
	  * 上传上下文，用于断点续传，如果是新上传则赋值为null
	  * 如果要支持断点续传，需在onUploadContextCreate回调中
	  * 持久化上传上下文信息
	  */
	String uploadContext = null;

	//如果要支持断点续传或者crash后断点重传，需要持久化<filePath,uploadContext>，以SharedPreferences为例
	//SharedPreferences mPerferences = getDefaultPreferences(context);
	//String uploadContext = mPerferences.getString(file.getAbsolutePath(), null);
	UploadTaskExecutor executor = WanAccelerator.putFileByHttp(
	        this.getBaseContext(),                // 把当前Activity传进来
	        new File("FILE_TO_BE_UPLOADED_PATH"), // 待上传文件对象
	        null,                                 // 在onUploadContextCreate和onProcess被回调的参数
	                                              // 如果支持断点续传，需要把待上传对象路径传过去
	                                              // 以便onUploadContextCreate更新
	        uploadContext,                        // 上传上下文，用于断点续传
	        wanNOSObject,                         // 上传对象类，里面封装了桶名、对象名、上传凭证
	        new Callback() {                      // 回调函数类，回调函数在UI线程

	             // 正常情况下只回调一次：oldUploadContext为null
	             // 当一次上传花费太长时间时UploadContext可能失效，
	             // 服务端会返回一个新的UploadContext，此时需要更新UploadContext
	            @Override
	            public void onUploadContextCreate(Object fileParam,
	                    String oldUploadContext,
	                    String newUploadContext) {
	                System.out.println("onUploadContextCreate.......");


	                 //如果要支持断点续传或者crash后断点重传
	                 //SharedPreferences mPerferences =
	                 //          PreferenceManager.getDefaultSharedPreferences(context);
	                 // SharedPreferences.Editor mEditor = mPerferences.edit();
	                 // mEditor.putString("FILE_TO_BE_UPLOADED_PATH", newUploadContext);
	                 // mEditor.commit();

	            }

	            // 上传进度回调，每上传完一块就调用一次
	            // fileParam: 上传文件的相关参数
	            // current: 当前上传多少
	            // total: 文件总大小
	            @Override
	            public void onProcess(Object fileParam,
	                    long current, long total) {
	                System.out.println("onProcess.......current = " + current +
	                        ", total = " + total);
	            }


	            //上传成功回调函数: 如果要实现crash后的重传
	            //使用者需要将持久化的<filePath, uploadContext>删除
	            @Override
	            public void onSuccess(CallRet ret) {
	                System.out.println("onSuccess......." + ret.getHttpCode());
	            }


	            // 上传失败回调函数: CallRet里面有具体的失败信息
	            // 使用者需要将持久化的<filePath, uploadContext>删除
	            @Override
	            public void onFailure(CallRet ret) {
	                System.out.println("onFailure.......");
	            }


	            //上传取消回调函数: 用户可以在此处做暂停等业务
	            @Override
	            public void onCanceled(CallRet ret) {
	                System.out.println("onCanceled.......");
	            }

	});


#### 取消上传取

	executor.cancel();

<span>Attention:</span><div class="alertContent">Android一般的情况下会使用一个主线程来控制UI，非主线程无法控制UI，在Android4.0+之后不能在主线程完成网络请求，本SDK是根据以上的使用场景设计，所有网络的操作均使用独立的线程异步运行，WanAccelerator.putFileByHttps是在主线程调用的，在回调函数内可以直接操作UI控件。WanAccelerator.putFileByHttps线程安全，可并发调用。</div>

