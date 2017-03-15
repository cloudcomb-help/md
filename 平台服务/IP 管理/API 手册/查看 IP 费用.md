#  云硬盘
## 扩容云硬盘

通过 [获取云硬盘列表](http://59.111.120.124/?http#7-2) 获取的云硬盘 id 扩容该云硬盘。

<span>Note:</span><div class="alertContent">暂不支持在线扩容</div>

> 请求示例

```http
PUT /api/v1/cloud-volumes/19893/actions/resize?size=1000 HTTP/1.1
Host: open.c.163.com
Authorization: Token c98dfae9c6cd405f95da15219e908643
Content-Type: application/json
```

### HTTP Request

`PUT https://open.c.163.com/api/v1/cloud-volumes/{id}/actions/resize?size={size}`

### URL Parameters

| 参数 | 类型 |               是否必填               |                               描述                              |
|------|------|--------------------------------------|-----------------------------------------------------------------|
| id   | long | 是（[获取云硬盘列表](http://59.111.120.124/?http#7-2)） | 云硬盘 id                                                       |
| size | int  | 是                                   | 扩容大小，单位为 G（大于原容量小于 1000，且必需是 10 的整数倍） |