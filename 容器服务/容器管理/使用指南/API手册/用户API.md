## **生成 API Token**

### 请求 header
<pre><code>
 POST /api/v1/token
</code></pre>
<pre><code>
Content-Type:application/json
</code></pre>

### 请求 payload

    {
      "app_key":"xxxxxx",
      "app_secret":"yyyyyy"
    }

|**参数说明**|	  **描述**    |	 **类型**  |**是否必填**|
|------------|----------------|------------|------------|
|app_key	|用户 Access Key|	string|	必填|
|app_secret|	用户 Access Secret|	string|	必填|
点我查看 APP Key 及 APP Secret

### 响应
* 成功响应
<pre><code>
201 Created
{
    "token":"zzzzzz",
    "expires_in":"86400"
}
</code></pre>

|**参数说明**|	  **描述**    |	**类型**|
|------------|----------------|---------|
|token|	访问 API 的授权码|	string|
|expires_in|	API 授权码的失效时间，单位秒|	string|
* 失败响应 详情请参见 错误返回码。

