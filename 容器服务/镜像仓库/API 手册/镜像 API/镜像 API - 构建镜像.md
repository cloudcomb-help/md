# 镜像

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