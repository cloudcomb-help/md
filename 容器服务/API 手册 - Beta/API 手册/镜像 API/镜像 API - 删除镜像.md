# 镜像 API

## 删除镜像

### 请求 header

    DELETE /api/v1/repositories/{repo_name}/tags/{tag}

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


|  参数说明 |     描述     |  类型  | 是否必填 |
|-----------|--------------|--------|----------|
| repo_name | 镜像仓库名称 | string | 必填     |
| tag       | 镜像 tag     | string | 必填     |

### 响应
#### 成功响应
    
    200 OK

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/镜像仓库/API 手册/OpenAPI 错误响应.md)。