# 访问控制

## 用户签名验证（Authentication）

日志订阅通过使用访问凭证 ID ( AccessKey )/访问凭证密钥( SecretKey )非对称加密的方法来验证某个请求的发送者身份。AccessKey 用于标识用户，SecretKey 是用户用于加密签名字符串和日志订阅 用来验证签名字符串的密钥，其中 SecretKey 必须保密，只有用户和日志订阅知道。每个访问凭证对都有 active/inactive 两种状态

* active 表明用户可以用此 ID 对签名验证请求
* inactive 表明用户暂停此 ID 对签名验证的功能

一个用户可以同时拥有多个 active 或者 inactive 的 ID 对。用户可以登录 API KEY 管理页面查看管理访问凭证。当用户想以个人身份向日志订阅发送请求时，需要首先将发送的请求按照日志订阅指定的格式生成签名字符串；然后使用 SecretKey 对签名字符串进行加密产生验证码。日志订阅收到请求以后，会通过 AccessKey 找到对应的 SecretKey，以同样的方法提取签名字符串和验证码， 如果计算出来的验证码和提供的一样即认为该请求是有效的；否则，日志订阅将拒绝处理这次请求，并返回相应的错误码。

## 在 Header 中包含签名

用户可以在 HTTP 请求头中增加 Authorization（授权）来包含签名信息，表明这个请求已被授权。如果用户的请求中没有 Authentication 字段，则认为是匿名访问，访问被禁止。

验证码计算

    "Authorization: LOG " + AccessKey + ":" + Base64(HMAC-SHA256(
                  HTTP-Verb + "\n"  
                  + Content-MD5 + "\n"  
                  + Content-Type + "\n"  
                  + Date + "\n"  
                  + CanonicalizedHeaders + "\n"  
                  + CanonicalizedResource))

* HTTP-Verb 表示 HTTP 请求类型，如：GET，POST，PUT，DELETE 等
* Content-MD5 表示内容数据的 MD5 值（没有内容保持为空）
* Content-Type 表示内容的类型
* Date 表示此次操作的时间，格式必须符合 RFC1123 的日期格式，示例：Wed, 01 Mar 2009 12:00:00 GMT
* CanonicalizedHeaders 表示请求中其他重要的 HTTP 头（目前暂时为空）。
* CanonicalizedResource 表示用户想要访问的日志订阅资源。

其中，Date 和 CanonicalizedResource 不能为空，其余字段如为空，用空字符串""代替；如果请求中的 Date 时间和日志订阅服务器的时间差正负15分钟以上，日志订阅服务器将拒绝该服务 ，并返回错误码：40301 - "Request Time Too Skewed"（具体请参看 `通用错误码` 章节）。

## 构建 CanonicalizedHeaders 的方法

目前暂无 CanonicalizedHeaders，请保持内容为空（即只添加一个"\n"分割符）。

## 构建 CanonicalizedResource 的方法

用户发送请求中想访问的日志订阅目标资源被称为 CanonicalizedResource 。它的构建方法如下：

1. 将 CanonicalizedResource 置成空字符串""；
2. 放入要访问的日志订阅资源，如：/get_subscription_position；
3. 如请求包含查询字符串（QUERY_STRING），则在 CanonicalizedResource 字符串尾部添加 "?" 和查询字符串。

其中 QUERY_STRING 是 URL 中请求参数按字典序排序后的字符串，其中参数名和值之间用 "=" （等号）相隔组成字符串，并对参数名-值对按照字典序升序排序，然后以 "&" 符号连接构成字符串。其公式化描述如下：

    QUERY_STRING = "KEY1=VALUE1" + "&" + "KEY2=VALUE2"