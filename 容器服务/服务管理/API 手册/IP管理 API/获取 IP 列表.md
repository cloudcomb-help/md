
# IP 管理 API

## 获取 IP 列表

获取 IP 列表，并查看所有 IP 实例的信息。

### 请求 URL

`GET https://open.c.163.com/api/v1/ips?status={status}&type={type}}&offset={offset}&limit={limit}`


### 请求示例

```http
GET /api/v1/ips?status=available&type=nlb&offset=0&limit=20 HTTP/1.1
Host: open.c.163.com
Authorization: Token 93cb02be6a83447a8dfd83221e8d4a96
Content-Type: application/json
```

### 请求参数

|  参数  |  类型  | 是否必填 |  默认值  |                    描述                    |  示例值   |
|--------|--------|----------|----------|--------------------------------------------|-----------|
| status | String | 否       | 所有状态 | IP 状态（[IP 状态及类型](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/IP管理 API/IP 状态及类型.md)）  | available |
| type   | String | 否       | 所有类型 | IP 类型 （[IP 状态及类型](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/IP管理 API/IP 状态及类型.md)） | nlb       |
| offset | Number | 否       | 0        | 获取列表的起始位置                         | 0         |
| limit  | Number | 否       | 20       | 每次获取的 IP 数量                         | 20        |


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
      "id": "926",
      "ip": "59.111.109.232",
      "status": "available",
      "type": "nlb",
      "service_id": "",
      "service_name": "",
      "create_at": "2016-12-28T13:13:03Z",
      "update_at": "2016-12-28T13:13:03Z"
    }
  ]
}
```

### 响应参数


|     参数     |    类型   |                              描述                             |        示例值        |
|--------------|-----------|---------------------------------------------------------------|----------------------|
| total        | Number    | IP 总数                                                       | 详见示例             |
| ips          | JSONArray | 返回的 IP 列表                                                | 详见示例             |
| id           | String    | IP 的唯一标识符                                               | 896                  |
| ip           | String    | IP                                                            | 59.111.109.202       |
| status       | String    | IP 状态                                                       | available            |
| type         | String    | IP 类型                                                       | nlb                  |
| service_id   | String    | 绑定的实例 id                                                 |                      |
| service_name | String    | 绑定的实例名称                                                |                      |
| create_at    | String    | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:11Z |
| update_at    | String    | 更新时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:11Z |