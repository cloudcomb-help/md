# 云主机 API

## 删除镜像
### 请求 URL

    DELETE https://open.c.163.com/api/v1/vm/privateimage/{image_id}

### 请求示例
    DELETE /api/v1/vm/privateimage/309c75d2-a80a-4c05-86c8-8698c99255b9 HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数


|   参数   |  类型  | 是否必填 |                                                      描述                                                      |                示例值                |
|----------|--------|----------|----------------------------------------------------------------------------------------------------------------|--------------------------------------|
| image_id | String | 是       | 镜像 id[获取自定义镜像：imageId](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取自定义镜像.md)） | 309c75d2-a80a-4c05-86c8-8698c99255b9 |

### 响应示例

```
{
  "code": "200",
  "msg": "success."
}
```