#  云硬盘
## 删除云硬盘

> 请求示例

```http
DELETE /api/v1/cloud-volumes/19893 HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
Content-Type: application/json
```

### HTTP Request

`DELETE https://open.c.163.com/api/v1/cloud-volumes/{id}`

### URL Parameters

| 参数 | 类型 |               是否必填               |    描述   | 示例值 |
|------|------|--------------------------------------|-----------|--------|
| id   | long | 是（[获取云硬盘列表](http://59.111.120.124/?http#7-2)） | 云硬盘 id |  19893 |

