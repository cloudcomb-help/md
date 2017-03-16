# IP 管理

## 创建 IP

### 请求 URL

`POST https://open.c.163.com/api/v1/ips`

### 请求示例

```http
POST /api/v1/ips HTTP/1.1
Host: open.c.163.com
Authorization: Token 93cb02be6a83447a8dfd83221e8d4a96
Content-Type: application/json

{
    "nce": 1, 
    "nlb": 1
}
```
### 请求参数

| 参数 |  类型  | 是否必填 | 默认值 |              描述              | 示例值 |
|------|--------|----------|--------|--------------------------------|--------|
| nlb  | Number | 否       |      0 | 创建指定数量的负载均衡 IP 实例 |      1 |
| nce  | Number | 否       |      0 | 创建指定数量的服务 IP 实例     |      1 |


### 响应示例

```json
{
  "total": 2,
  "ips": [
    {
      "id": "896",
      "ip": "59.111.109.202",
      "status": "available",
      "type": "nlb",
      "service_id": "",
      "service_name": "",
      "create_at": "2016-12-28T13:13:11Z",
      "update_at": "2016-12-28T13:13:11Z"
    },
    {
      "id": "7f7a9f12-035f-401b-ace0-7926b4a518b4",
      "ip": "59.111.120.200",
      "status": "available",
      "type": "nce",
      "service_id": "",
      "service_name": "",
      "create_at": "2016-12-28T13:13:12Z",
      "update_at": "2016-12-28T13:13:12Z"
    }
  ]
}
```

### 响应参数


|     参数     |    类型   |                              描述                             |        示例值        |
|--------------|-----------|---------------------------------------------------------------|----------------------|
| total        | Number    | 创建成功的 IP 实例数                                          | 2                    |
| ips          | JSONArray | 返回的 IP 列表                                                | 详见示例             |
| id           | String    | IP 的唯一标识符                                               | 896                  |
| ip           | String    | IP                                                            | 59.111.109.202       |
| status       | String    | IP 状态（[IP 状态及类型](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/IP管理 API/IP 状态及类型.md)）| available            |
| type         | String    | IP 类型（[IP 状态及类型](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/IP管理 API/IP 状态及类型.md)）| nlb                  |
| service_id   | String    | 绑定的实例 id                                                 |                      |
| service_name | String    | 绑定的实例名称                                                |                      |
| create_at    | String    | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:12Z |
| update_at    | String    | 更新时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:12Z |