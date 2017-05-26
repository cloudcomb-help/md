# 云主机 API

## 停止云主机

### 请求 URL

    PUT https://open.c.163.com/api/v1/vm/{uuid}/action/stop

### 请求示例
    PUT /api/v1/vm/d3fa21b7-16fd-421c-90ac-cd4df8f78353/action/stop HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数

| 参数 |  类型  | 是否必填 |                                                        描述                                                       |                示例值                |
|------|--------|----------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| uuid | String | 是       | 云主机 UUID（[获取云主机列表：uuid](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取云主机列表.md)） | d3fa21b7-16fd-421c-90ac-cd4df8f78353 |

### 响应示例

```
{
  "code": "200",
  "msg": "success."
}
```

