## **查看容器镜像列表**

### 请求 header
<pre><code>
GET /api/v1/containers/images
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>
### 返回

    {
      "custom_images": [
        {
          "tag": "v1",
          "desc": "v1",
          "weight": 0,
          "id": 30202,
          "name": "4638_tomcat2",
          "constraint": null
        }
      ],
      "public_images": [
        {
          "tag": "latest",
          "desc": "",
          "weight": 3,
          "id": 10005,
          "name": "centos",
          "constraint”: {
            "min_combo": 20,
            "max_combo": 50,
            "min_machine_spec": 10,
            "max_machine_spec": 40
          }
        }
      ]
    }


|  **参数说明**  | **描述** |  **类型**  |
|----------------|----------|------------|
|custom_images|	自定义镜像|	json array|
|public_images|	官方镜像|	json array|
|tag|	镜像 tag|	string|
|desc	|镜像描述	|string|
|weight|	权重|	int|
|id	|镜像 id	|long|
|name|	镜像名称|	string|
|constraint	|镜像限制	|json|
|min_combo|	最小套餐|	int|
|max_combo|	最大套餐	|int|
|min_machine_spec|	最小机器规格|	int|
|min_machine_spec	|最小机器规格	|int|
## **创建容器**

## 请求 header
<pre><code>
POST /api/v1/containers
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>
### 请求 payload

    {
      "charge_type": 1,
      "spec_id": 1,
      "image_type": 1,
      "image_id": 2,    //可参考 [[容器API#查看容器镜像列表|查看容器镜像列表]] 获取
      "name": "name",
      "desc": "desc",
      "ssh_key_ids": [
        1,
        2
      ],
      "env_var": {
        "key": "value"
      },
      "use_public_network": 1,
      "network_charge_type": 1,
      "bandwidth": 100
    }

|  **参数说明**  |	        **描述**          |**类型**|**是否必填**|
|----------------|----------------------------|--------|------------|
|charge_type|	计费类型，1 (按套餐计费) / 2 (按需计费)|	int|	必填|
|spec_id|	容器规格 id，1 (微小型) / 10 (小型) / 20 (中型) / 30 (大型) / 40 (豪华型) / 50 (旗舰型)|	int|	必填|
|image_type|	镜像类型，1 (官方镜像) / 2 (自定义镜像)|	int|	必填|
|image_id	|镜像 id，可通过 查看容器镜像列表 所述方法获取	|int	|必填|
|name|	容器名称|	string|	必填|
|desc	|容器描述	|string	|可填|
|ssh_key_ids|	ssh key id 列表	|json|	可填|
|env_var	|环境变量	|json	|可填|
|use_public_network|	是否使用公网，1 (使用) / 0 (不使用)|	int	|按需计费必填|
|network_charge_type|	1 (按带宽) / 2 (按流量)	|int	|按需计费且使用公网必填|
|bandwidth|	带宽大小，单位 Mbps，(0,100]，针对按需计费，使用公网并且按照带宽计费|int|	按需计费，使用公网并且按照带宽计费必填|
### 响应
* 成功响应

<pre><code>
    201 Created
    {
     "id":100
    }
</code></pre>

|**参数说明**|	     **描述**        |**类型**|
|------------|-----------------------|--------|
|id|	容器id|	long|
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。
## **修改容器**

### 请求 header
<pre><code>
PUT /api/v1/containers/{containerId}
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>
请求 payload

    {
      "charge_type":1,
      "desc":"desc",
      "network_charge_type":1,
      "bandwidth":100
    }

|  **参数说明**  |	    **描述**      |**类型**|**是否必填**|
|----------------|--------------------|--------|------------|
|containerId|	容器 id|	long|	必填|
|charge_type|	计费类型，1 (按套餐计费) / 2 (按需计费)|	int|	可填|
|desc	|容器描述	|string	|可填|
|network_charge_type|	1 (按带宽) / 2 (按流量)	|int|	按需计费且使用公网必填|
|bandwidth|	带宽大小，单位 Mbps，(0,100]，针对按需计费，使用公网并且按照带宽计费|int|	按需计费，使用公网并且按照带宽计费必填|
### 响应
* 成功响应
<pre><code>
    200 OK
</code></pre>
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。
## **容器列表**

## 请求 header
<pre><code>
GET /api/v1/containers
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>
### 请求参数

    limit=20&offset=0

|**参数说明**|	   **描述**     |**类型**|**是否必填**|
|------------|------------------|--------|------------|
|limit	|大于 0 小于等于 30，默认 20	|int	|可填|
|offset|	偏移量，大于等于 0，默认 0|	int|	可填|
### 响应
* 成功响应

   

     200 Ok
        {
          "total": 1,
          "containers": [
            {
              "id": 100,
              "name": "name",
              "desc": "desc",
              "status": "create_fail",
              "bandwidth": 100,
              "replicas": 1,
              "charge_type": 1,
              "spec_id": 1,
              "created_at": "2016-03-19T05:44:17Z",
              "updated_at": "2016-03-19T05:44:17Z",
              "public_ip": null,
              "private_ip": null,
              "ssh_key_ids": [
                1,
                2
              ],
              "network_charge_type": 2,
              "image_id": 2,
              "use_public_network": 1,
              "env_var": {
                "key": "value"
              }
            }
          ]
        }

| **参数说明**  |	        **描述**            |**类型**|
|---------------|-------------------------------|--------|
|id|	容器 id|	long|
|charge_type|	计费类型，1 (按套餐计费) / 2 (按需计费)|	int|
|spec_id|	容器规格id，1 (微小型) / 10 (小型) / 20 (中型) / 30 (大型) / 40 (豪华型) / 50 (旗舰型)|	int|
|name|	容器名称|	string|
|desc	|容器描述	|string|
|ssh_key_ids|	ssh key id 列表|json|
|env_var	|环境变量	|json|
|image_id|	镜像 id|	int|
|use_public_network|	是否使用公网，1 (使用) / 0 (不使用)|	int|
|network_charge_type|	1 (按带宽) / 2 (按流量)	|int|
|bandwidth|	带宽大小，单位 Mbps	|int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|	string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|status|	容器状态，一共 create、update、resize、delete 四种操作，每种对应着 ing (创建中) / succ (创建成功) / fail (创建失败) / timeout (超时)四种状态。|	string|
|private_ip	|内网 ip	|string|
|public_ip|	外网 ip|	string|
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。
## **查看容器**

### 请求 header
<pre><code>
GET /api/v1/containers/{containerId}
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>
|**参数说明**| **描述** |**类型**|**是否必填**|
|------------|----------|--------|------------|
|containerId|	容器 id|	long|	必填|
### 响应
* 成功响应

    200 Ok
    {
      "id": 10615,
      "name": "name",
      "desc": "desc",
      "status": "creating",
      "bandwidth": 100,
      "replicas": 1,
      "charge_type": 1,
      "spec_id": 1,
      "created_at": "2016-03-15T04:26:23Z",
      "updated_at": "2016-03-15T04:26:23Z",
      "public_ip": null,
      "private_ip": null,
      "ssh_key_ids": "2947",
      "network_charge_type": 2,
      "image_id": 2,
      "use_public_network": 1,
      "env_var": {
          "key": "value"
      }
    }

| **参数说明** |	   **描述**       |**类型**|
|--------------|----------------------|--------|
|id|	容器 id|	long|
|charge_type|	计费类型，1 (按套餐计费) / 2 (按需计费)|	int|
|spec_id|	容器规格id，1 (微小型) / 10 (小型) / 20 (中型) / 30 (大型) / 40 (豪华型) / 50 (旗舰型)|int|
|name|	容器名称|	string|
|desc	|容器描述	|string|
|ssh_key_ids|	ssh key id 列表|	json|
|env_var	|环境变量	|json|
|image_id|	镜像 id	|int|
|bandwidth	|带宽大小，单位 Mbps|	int|
|network_charge_type|	1 (按带宽) / 2 (按流量)|	int|
|use_public_network	|是否使用公网，1 (使用) / 0 (不使用)	|int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|status|	容器状态，creating (创建中) / create_succ (创建成功) / create_fail (创建失败)	|string|
|public_ip|	外网 ip	|string|
|private_ip	|内网 ip	|string|
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

## 删除容器

### 请求 header
<pre><code>
DELETE /api/v1/containers/{containerId}
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type:application/json
</code></pre>

|**参数说明**|	    **描述**       |**类型**|**是否必填**|
|------------|---------------------|--------|------------|
|containerId|	容器 id	|long|	必填|
### 响应
* 成功响应

<pre><code>
200 Ok
</code></pre>
* 失败响应 详情请参见 见[错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

## **重启容器**

### 请求 header

<pre><code>
PUT /api/v1/containers/{containerId}/actions/restart
</code></pre>
<pre><code>
Authorization:Token xxxxxxxxxxxxxx
Content-Type: application/json
</code></pre>

|**参数说明**|	  **描述**    |**类型**|**是否必填**|
|------------|----------------|--------|------------|
|containerId	|容器 id	|long	|必填|
### 响应
* 成功响应
<pre><code>
200 Ok
</code></pre>
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

## **容器保存为镜像**

### 请求 header

<pre><code>
POST /api/v1/containers/{containerId}/tag
</code></pre>
<pre><code>
Authorization: token xxxxxxxxxxxxxx
Content-Type: application/json
</code></pre>
### 请求 payload

    {
      "repo_name": "cluster",
      "tag": "1.2.6"
    }

|**参数说明**|	  **描述**    |**类型**|**是否必填**|
|------------|----------------|--------|------------|
|containerId|	容器 id|	long|	必填|
|repo_name	|镜像仓库名称	|string	|必填|
|tag|	镜像Tag|	string|	必填|
### 响应

* 成功响应
<pre><code>
201 Created
{
  image_id: “409”
}
</code></pre>

|**参数说明**|	   **描述**     |**类型**|
|------------|------------------|--------|
|image_id	|容器转为的镜像的镜像Id	|string|
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。

## **获取容器流量数据**

### 描述

提供查询指定容器在某段时间范围内流量使用情况服务,接收起始时间和终止时间参数（起始时间和终止时间参数可选，如果不传入起始时间和终止时间，则默认查询从创建到目前的容器流量，如果起始时间或终止时间是负值，则默认使用容器创建时间或当前时间），向客户端返回200状态码和容器在该段时间内使用的流量值。

### 请求 header
<pre><code>
GET /api/v1/containers/{containerId}/flow?from_time=1111&to_time=111111
</code></pre>
<pre><code>
Authorization: token xxxxxxxxxxxxxx
Content-Type: application/json
</code></pre>

|**参数说明**|	     **描述**        |**类型**|**是否必填**|
|------------|-----------------------|--------|------------|
|containerId|	容器 id	|long|	必填|
|from_time|	起始时间，默认为容器创建时间|	long|	可选|
|to_time	|终止时间，默认为系统当前时间	|long|	可选|
### 响应

* 成功响应
<pre><code>
    200 OK
    {
      "container_up_flow": "1234.0MB",
      "container_down_flow": "111111.0MB"
    }
</code></pre>

|**参数说明**|	    **描述**      |**类型**|
|------------|--------------------|--------|
|container_up_flow	|容器使用的上行流量	|string|
|container_down_flow|	容器使用的下行流量|	string|
* 失败响应 详情请参见 [错误返回码](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/OpenAPI%E9%94%99%E8%AF%AF%E5%93%8D%E5%BA%94.md)。