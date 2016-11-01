## **镜像仓库列表**

### 请求 header
<pre><code>
GET /api/v1/repositories
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>

### 请求参数
<pre><code>
limit=20&offset=0
</code></pre>

|**参数说明**|	    **描述**       |**类型**|**是否必填**|
|------------|---------------------|--------|------------|
|limit	|大于 0 小于等于 30，默认 20	|int	|可填|
|offset|	偏移量，大于等于 0，默认 0	|int|	可填|
### 响应

* 成功响应
<pre><code>
200 Ok
{
    "total": 1,
    "repositories": [
        {
            "repo_id": 399,
            "user_name": "user",
            "repo_name": "name",
            "open_level": 0,
            "base_desc": "base_desc",
            "detail_desc": "desc",
            "tag_count": 0,
            "created_at": "2016-03-15T02:43:01Z",
            "updated_at": "2016-03-15T02:43:01Z"
        }
    ]
}
</code></pre>

|**参数说明**|	     **描述**        |**类型**|
|------------|-----------------------|--------|
|repo_id	|镜像仓库 |id	|long|
|user_name|	用户名|	string|
repo_name	|镜像仓库名	|string|
|open_level|	开放级别，0 (私有 ) / 1 (公有)|	int|
|base_desc	|基本描述	|string|
|detail_desc|	详细描述|	string|
|tag_count	|版本数量	|int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|	string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|

* 失败响应 详情请参见 错误返回码。

## **查看镜像仓库**

### 请求 header
<pre><code>
GET /api/v1/repositories/{id}
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>

|**参数说明**|	  **描述**     |**类型**|**是否必填**|
|------------|-----------------|--------|------------|
|id	|镜像仓库 id	|long	|必填|
### 响应

*成功响应

<pre><code>
200 Ok
{
    "tags": [
        {
            "name": "430",
            "size": 190425418,
            "status": 2
        },
        {
            "name": "latest",
            "size": 190425418,
            "status": 2
        }
    ],
    "repo_id": 399,
    "user_name": "wutaigong",
    "repo_name": "fafafa",
    "open_level": 0,
    "base_desc": "base_desc",
    "detail_desc": "desc",
    "tag_count": 2,
    "download_url": null,
    "created_at": "2016-03-15T02:43:01Z",
    "updated_at": "2016-03-24T07:05:37Z"
}
</code></pre>


|**参数说明**|	   **描述**      |**类型**|
|------------|-------------------|--------|
|repo_id	|镜像仓库 id	|long|
|user_name|	用户名|	string|
|repo_name	|镜像仓库名	|string|
|open_level|	开放级别，0 (私有) / 1 (公有)|	int|
|base_desc|	基本描述|	|string|
|detail_desc	|详细描述	|string|
|tag_count|	版本数量|	int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|	string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|name|	镜像 tag|	string|
|size	|镜像大小，单位 B	|long|
|status|	镜像状态，0 (初始化) / 1 (构建中) / 2 (构建成功) / 3 (构建失败)|	int|
* 失败响应 详情请参见错误返回码。

## **构建镜像**

### 请求 header
<pre><code>
POST /api/v1/repositories/{repo_name}/tags/{tag}/actions/build
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:multipart/form-data
</code></pre>
### 请求payload
<pre><code>
form表单
docker_file:docker file 文件
</code></pre>

|**参数说明**|	  **描述**    |**类型**|**是否必填**|
|------------|----------------|--------|------------|
|repo_name	|镜像仓库名称	|string	|必填|
|tag|	镜像 tag|	string|	必填|
|docker_file|	docker xml 文件，大小限制在 1 M	|file|	必填|
### 响应

* 成功响应

<pre><code>
200 Ok
</code></pre>
* 失败响应 详情请参见 错误返回码。

## **删除镜像**

### 请求 header
<pre><code>
DELETE /api/v1/repositories/{repo_name}/tags/{tag}
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>

|**参数说明**|	    **描述**      |**类型**|**是否必填**|
|------------|--------------------|--------|------------|
|repo_name	|镜像仓库名称	|string	|必填|
|tag|	镜像 tag|	string|	必填|
### 响应
成功响应
200 Ok
* 失败响应 详情请参见 错误返回码。