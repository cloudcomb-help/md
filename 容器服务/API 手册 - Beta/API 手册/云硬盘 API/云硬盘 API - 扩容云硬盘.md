# 云硬盘 API

## 扩容云硬盘

通过[获取云硬盘列表](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/云硬盘 API/云硬盘 API - 获取云硬盘列表.md)获取的云硬盘 id 扩容该云硬盘。

### 请求示例

	PUT /api/v1/cloud-volumes/{volumeId}/actions/resize?size={size} HTTP/1.1
	Host: open.c.163.com
	Authorization: Token c98dfae9c6cd405f95da15219e908643
	Content-Type: application/json

### 请求参数

|   参数   | 类型 | 是否必填 |                                描述                               |
|----------|------|----------|-------------------------------------------------------------------|
| volumeId | long | 是       | 云硬盘 id                                                         |
| size     | int  | 是       | 扩容大小，单位为 G（大于原容量小于 1000，且必需是 10 的整数倍） |

### 响应示例

	200 OK
	
### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/OpenAPI 错误响应.md)。