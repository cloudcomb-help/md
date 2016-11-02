# 集群 API

## **查看集群镜像列表**

### 请求 header

    GET /api/v1/apps/images    

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

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

|**参数说明**|	   **描述**      |**类型**|
|------------|-------------------|--------|
|custom_images	|自定义镜像	|json array|
|public_images|	官方镜像|	json array|
|tag	|镜像 tag	|string|
|desc	|镜像描述	|string|
|weight|	权重|	int|
|id	|镜像 id	|long|
|name|	镜像名称|	string|
|constraint	|镜像限制	|json|
|min_combo|	最小套餐|	int|
|max_combo	|最大套餐	|int|
|min_machine_spec|	最小机器规格|	int|
|min_machine_spec	|最小机器规格	|int|

## **创建集群**

### 请求 header

    POST /api/v1/apps    

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

### 请求 payload

    {
     "name":"name",
     "desc":"desc",
     "domain":"www.abc.com",
     "image_type":1,
     "image_id":3,   //可参考 查看[集群镜像列表](https://github.com/cloudcomb-help/md/blob/master/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/API%E6%89%8B%E5%86%8C/%E9%9B%86%E7%BE%A4API.md) 获取
     "spec_id": 1,
     "replicas":2,
     "env_var":{"key":"value"},
     "version_control":{
       "type":"git",
       "path":"https://github.com/NetEase/c.git", //此处仅为示例代码，参数说明详见下方
       "subdir":"tomcat",
       "branch":"online",
       "version":"xxxx",
       "account":"example@163.com",
       "password":"123456"
        },
     "docker_file_type":2,
     "custom_docker_file":"dockfile",
      "log_dirs":["dir1","dir2"] 
    }

|**参数说明**|          **描述**          |**类型**|**是否必填**|
|------------|----------------------------|--------|------------|
|name	|集群名称	|string	|必填|
|desc|	集群描述|	string|	可填|
|domain	|域名	|string	|可填|
|image_type|	镜像类型，1 (官方镜像) / 2 (自定义镜像)|	int|	必填|
|image_id	|镜像 id，可通过 查看集群镜像列表 所述方法获取	|int	|必填|
|spec_id|	服务规格 id，1 (微小型) / 10 (小型) / 20 (中型) / 30 (大型) / 40 (豪华型) / 50 (旗舰型)	|int|	必填|
|replicas|	副本数量，有容量限制，不填默认为1	|int|	可填|
|env_var	|环境变量	|json|	可填|
|version_control|	版本管理	|json|	可填|
|type	|版本管理类型，git / svn	|string	|可填|
|path|	代码路径|	string|	可填|
|subdir	|代码子目录	|string	|可填|
|branch|	代码分支|	string|	可填|
|version	|代码版本号	|string	|可填|
|account|	版本管理账号|	string|	可填|
|password	|版本管理密码	|string	|可填|
|docker_file_type|	docker 文件类型，1 (自动生成) / 2 (自定义)|	int|	可填|
|custom_docker_file	|自定义 docker file 在源码中的路径	|string	|可填|
|log_dirs|	日志目录	|json|	可填|

### 响应

#### 成功响应

    200 Ok
    {
        "id":1000,
        "url":"https://open.c.163.com/api/v1/hooks/app/44684185834f47f5bf6b3902b8fb939b"
    }

|**参数说明**|	       **描述**          |**类型**|
|------------|---------------------------|--------|
|id	|集群 id	|long|
|url|	集群 web hook url，当有代码提交时，可嵌入此 url 进行持续部署发布。	|string|

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **修改集群**

### 请求 header

    PUT /api/v1/apps/{id}    

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

### 请求 payload

    {
    "desc":"appdesc",
    "env_var":{"key":"value"},
    "version_control":{
      "type":"git",
      "path":"http://www.github.com/example/test.git",
      "subdir":"tomcat",
      "branch":"online",
      "version":"xxxx",
      "account":"example@163.com",
      "password":"xxxx"
    },
    "custom_docker_file":"dockfile",
    "log_dirs":["dir1","dir2"]
    } 


|**参数说明**|	      **描述**        |**类型**|**是否必填**|
|------------|------------------------|--------|------------|
|id	|集群 id	|long	|必填|
|desc|	集群描述|	string|	可填|
|env_var	|环境变量	|json	|可填|
|version_control|	版本控制|	json|	可填|
|type	|版本控制类型，git/svn	|string	|可填|
|path|	代码路径	|string|	可填|
|subdir	|代码子目录	|string	|可填|
|branch|	代码分支|	string|	可填|
|version	|代码版本号	|string	|可填|
|account|	版本管理账号|	string|	可填|
|password	|版本管理密码	|string	|可填|
|docker_file_type|	docker 文件类型，1 (自动生成) / 2 (自定义)|	int|	可填|
|custom_docker_file	|自定义 docker file 在源码中的路径	|string	|可填|
|log_dirs|	日志目录|	json|	可填|

### 响应

#### 成功响应

    200 Ok

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **集群列表**

### 请求 header

    GET /api/v1/apps    

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

### 请求参数

    limit=20&offset=0


|**参数说明**|	    **描述**     |**类型**|**是否必填**|
|------------|-------------------|--------|------------|
|limit	|大于 0 小于等于 30，默认 20	|int	|可填|
|offset|	偏移量，大于等于 0，默认 0|	int|	可填|

### 响应

#### 成功响应


    200 Ok
    {
        "total": 1,
        "apps": [
              {
                "id": 10702,
                "name": "ape2",
                "desc": "appdesc",
                "domain": "www.abc.com",
                "status": "create_fail",
                "replicas": 2,
                "volumes": [
                    {
                        "name": "f9eb1b4428064f15b8aa95aad31e1bc4",
                        "mount_path": "dir1",
                        "readonly": false
                    },
                    {
                        "name": "a439b16783cd469cb66f17254503c72d",
                        "mount_path": "dir2",
                        "readonly": false
                    }
                ],
                "charge_type": 2,
                "spec_id": 1,
                "created_at": "2016-03-25T04:57:48Z",
                "updated_at": "2016-03-25T04:57:48Z",
                "public_ip": null,
                "private_ip": null,
                "version_control": {
                    "type": "git",
                    "path": "http://www.github.com/example/test.git",
                    "subdir": "tomcat",
                    "branch": "online",
                    "version": "xxxx",
                    "account": "example@163.com",
                    "password": "bec55f12a60bf849"
                },
                "custom_docker_file": "dockfile",
                "image_id": 3,
                "containers": [
                    {
                        "private_ip": "10.180.194.16",
                        "container_id": 5ae7bfa878b335311434f6aeef60fcfdb55bd8c51c11ed2912b64ad95061efae"
                    }
                ],           
                "env_var": {
                    "key": "value"
                },
                "web_hook_url": https://open.c.163.com/api/v1/hooks/app/e9c80ebe17464f6d90d3e22f6ac77bad"
            }
         ]
    }

|**参数说明**|	    **描述**      |**类型**|
|------------|--------------------|--------|
|id	|集群 id	|long|
|name|	集群名称	|string|
|desc	|集群描述	|string|
|domain|	域名|	string|
|status|	集群状态，create_succ (创建成功) / create_fail (创建失败)|	string|
|replicas	|副本数量，有容量限制，不填默认为 1	|int|
|volumes|	日志目录|	json|
|name	|日志目录名称	|string|
|mount_path|	日志目录挂载路径|	string|
|readonly	|是否只读	|boolean|
|spec_id|	集群规格 id，1 (微小型) / 10 (小型) /20 (中型) /30 (大型) / 40 (豪华型) / 50 (旗舰型)	|int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化|	string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|private_ip|	内网 ip	|string|
|public_ip	|外网 ip	|string|
|version_control|	版本控制|	json|
|type	|版本控制类型，git/svn	|string|
|path|	代码路径	|string|
|subdir	|代码子目录	|string|
|branch|	代码分支|	string|
|version	|代码版本号	|string|
|account|	版本管理账号|	string|
|password	|版本管理密码	|string|
|custom_docker_file|	自定义 docker file 在源码中的路径|	string|
|image_id	|镜像 id	|int|
|containers|	容器实例列表	|json|
|private_ip	|容器私有网 ip	|string|
|container_id|	容器 id|	long|
|env_var|	环境变量	|json|
|web_hook_url|	web hook url|	string|

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **查看集群**

### 请求 header

    GET /api/v1/apps/{id}   

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


|**参数说明**|	    **描述**      |**类型**|**是否必填**|
|------------|--------------------|--------|------------|
|id|	集群 id	|long	|必填|

### 响应

#### 成功响应

    200 Ok
    {
        "id": 10702,
        "name": "name",
        "desc": "desc",
        "domain": "www.abc.com",
        "status": "creating",
        "replicas": 2,
        "volumes": [
            {
                "name": "f9eb1b4428064f15b8aa95aad31e1bc4",
                "mount_path": "dir1",
                "readonly": false
            },
            {
                "name": "a439b16783cd469cb66f17254503c72d",
                "mount_path": "dir2",
                "readonly": false
            }
        ],
        "charge_type": 2,
        "spec_id": 1,
        "created_at": "2016-03-25T04:57:48Z",
        "updated_at": "2016-03-25T04:57:48Z",
        "public_ip": null,
        "private_ip": null,
        "version_control": {
            "type": "git",
            "path": "http://www.github.com/example/test.git",
            "subdir": "tomcat",
            "branch": "online",
            "version": "xxxx",
            "account": "example@163.com",
            "password": "bec55f12a60bf849"
        },
        "custom_docker_file": "dockfile",
        "image_id": 3,
        "containers": [
            {
                "private_ip": "10.180.194.16",
                "container_id": 5ae7bfa878b335311434f6aeef60fcfdb55bd8c51c11ed2912b64ad95061efae"
            }
        ],   
        "env_var": {
            "key": "value"
        },
        "web_hook_url": "https://open.c.163.com/api/v1/hooks/app/e9c80ebe17464f6d90d3e22f6ac77bad"
    }

|**参数说明**|	       **描述**           |**类型**|
|------------|----------------------------|--------|
|id	|集群 id	|long|
|name|	集群名称|	string|
|desc	|集群描述|string|
|domain|	域名|	string|
|status|	集群状态，create_succ (创建成功) / create_fail (创建失败)|	string|
|replicas	|副本数量，有容量限制，不填默认为 1	|int|
|volumes|	日志目录|	json|
|name|	日志目录名称	|string|
|mount_path|	日志目录挂载路径|	string|
|readonly	|是否只读	|boolean|
|spec_id	|集群规格 id，1 (微小型) / 10 (小型) / 20 (中型) / 30 (大型) / 40 (豪华型) / 50 (旗舰型)	|int|
|created_at|	创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|updated_at	|修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化	|string|
|private_ip|	内网 ip|	string|
|public_ip	|外网 ip	|string|
|version_control|	版本控制|	json|
|type	|版本控制类型，git/svn	|string|
|path|	代码路径	|string|
|subdir	|代码子目录	|string|
|branch|	代码分支|	string|
|version	|代码版本号	|string|
|account|	版本管理账号|	string|
|password	|版本管理密码	|string|
|custom_docker_file|	自定义 docker file 在源码中的路径|	string|
|image_id|	镜像 id	|int|
|containers|	容器实例列表|	json|
|private_ip|	容器私有网 ip	|string|
|container_id|	容器 id	|long|
|env_var	|环境变量	|json|
|web_hook_url|	web hook url|	string|

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **删除集群**

    DELETE /api/v1/apps/{id}

### 请求 header

    Authorization:Token xxxxxxxxxxxxxx


|**参数说明**|	     **描述**        |**类型**|**是否必填**|
|------------|-----------------------|--------|------------|
|id	|集群 id	|long	|必填|

### 响应

#### 成功响应

    200 OK

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **集群扩容**

### 请求 header

    PUT /api/v1/apps/{id}/replications/{replicas}/actions/resize    

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


|**参数说明**|	    **描述**       |**类型**|**是否必填**|
|------------|---------------------|--------|------------|
|id	|集群 id	|long	|必填|
|replicas|	副本数|	int|	必填|

### 响应

#### 成功响应

    200 Ok

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。

## **监听**

支持长连接，超时或者对后端容器实例进行修改操作（创建、更新、回滚、重启、删除、扩缩容等）后即时返回。

### 请求 header

    GET /api/v1/watch/apps/{id}

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

|**参数说明**|	      **描述**         |**类型**|**是否必填**|
|------------|-------------------------|--------|------------|
|id	|集群 id	|long	|必填|

### 响应
#### 成功响应

    200 Ok
    {    
        {
            "private_ip": "10.180.194.16",
            "container_id": "5ae7bfa878b335311434f6aeef60fcfdb55bd8c51c11ed2912b64ad95061efae"
        }
    }


|**参数说明**|	    **描述**       |**类型**|
|------------|---------------------|--------|
|containers	|容器实例列表	|json|
|private_ip|	容器私有网 ip|	string|
|container_id	|容器 id	|long|

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/容器管理/API 手册/OpenAPI 错误响应.md)。