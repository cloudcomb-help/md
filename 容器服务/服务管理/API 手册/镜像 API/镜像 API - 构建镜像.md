# 镜像 API

## 构建镜像 V2

支持多级目录。

### 请求 URL

`POST https://open.c.163.com/api/v1/repositories/v2/image?repo_name={repo_name}&tag={tag}`

### 请求示例

```http
POST /api/v1/repositories/v2/image?repo_name=a/b/c&amp;tag=v1 HTTP/1.1
Host: open.c.163.com
Authorization: Token 344957249da34e17925c2bbd531f6fdf
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="docker_file"; filename=""
Content-Type: 


------WebKitFormBoundary7MA4YWxkTrZu0gW--
```
### 请求参数

<span>Attention:</span><div class="alertContent">若镜像仓库中没有对应的 repo_name，则会新建一个私有不支持持续集成的镜像仓库。</div>

|   参数说明  |  类型  | 是否必填 |                    描述                    |  实例值  |
|-------------|--------|----------|--------------------------------------------|----------|
| repo_name   | String | 是       | 镜像仓库名称（支持多级目录）               | a/b/c    |
| tag         | String | 是       | 镜像版本号                                 | v1       |
| docker_file | file   | 是       | 构建镜像的 Dockerfile 文件，大小限制在 1 M | 详见示例 |

### 响应示例

```
200 OK
```

## 构建镜像

### 请求 URL

`POST https://open.c.163.com/api/v1/repositories/{repo_name}/tags/{tag}/actions/build/`

### 请求示例

```http
POST /api/v1/repositories/myrepo/tags/v1/actions/build HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="docker_file"; filename=""
Content-Type: 


------WebKitFormBoundary7MA4YWxkTrZu0gW--
```
### 请求参数

|   参数说明  |               描述              |  类型  | 是否必填 |
|-------------|---------------------------------|--------|----------|
| repo_name   | 镜像仓库名称                    | String | 必填     |
| tag         | 镜像 tag                        | String | 必填     |
| docker_file | docker xml 文件，大小限制在 1 M | file   | 必填     |

<span>Note:</span><div class="alertContent">其他构建方式待更新。</div>
