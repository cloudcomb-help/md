# 镜像 API

## 构建镜像

### 请求 header

    POST /api/v1/repositories/{repo_name}/tags/{tag}/actions/build

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:multipart/form-data

### 请求payload

    form表单
    docker_file:docker file 文件


|   参数说明  |               描述              |  类型  | 是否必填 |
|-------------|---------------------------------|--------|----------|
| repo_name   | 镜像仓库名称                    | string | 必填     |
| tag         | 镜像 tag                        | string | 必填     |
| docker_file | docker xml 文件，大小限制在 1 M | file   | 必填     |

### 响应

#### 成功响应

    200 Ok

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/OpenAPI 错误响应.md)。