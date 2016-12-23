# 云硬盘 API

## 删除云硬盘

通过[获取云硬盘列表](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/云硬盘 API/云硬盘 API - 获取云硬盘列表.md)获取的云硬盘 id 删除该云硬盘。

### 请求示例

    DELETE /api/v1/cloud-volumes/{volumeId} HTTP/1.1
    Host: open.c.163.com
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30

### 请求参数

|   参数   | 类型 | 是否必填 |    描述   |
|----------|------|----------|-----------|
| volumeId | long | 是       | 云硬盘 id |


### 响应示例

    200 OK

### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。