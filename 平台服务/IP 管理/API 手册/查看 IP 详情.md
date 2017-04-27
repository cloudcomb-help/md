# IP 管理

## 查看 IP 详情

查看某个 IP 实例的详情信息。

### 请求 URL

`GET https://open.c.163.com/api/v1/ips/{id}`

### 请求示例

```http
GET /api/v1/ips/163 HTTP/1.1
Authorization: Token 93cb02be6a83447a8dfd83221e8d4a96
Content-Type: application/json
```
### 请求参数

| 参数 |  类型  | 是否必填 |                       描述                       | 示例值 |
|------|--------|----------|--------------------------------------------------|--------|
| id   | String | 是       | IP 的唯一标识符（[获取 IP 列表](http://support.c.163.com/md.html#!平台服务/IP 管理/API 手册/获取 IP 列表.md)） |    163 |

### 响应示例

```json
{
  "id": "163",
  "ip": "59.111.163.163",
  "status": "binded",
  "service_type":"负载均衡",
  "type": "nlb",
  "service_id": "e2cc21da-9bb9-4db8-ae54-10b358a3a7aa",
  "service_name": "mysql",
  "create_at": "2016-12-15T09:33:53Z",
  "update_at": "2016-12-15T09:33:53Z"
}
```

### 响应参数

|     参数     |  类型  |                              描述                             |        示例值        |
|--------------|--------|---------------------------------------------------------------|----------------------|
| id           | String | IP 的唯一标识符                                               | 163                  |
| ip           | String | IP                                                            | 59.111.163.163       |
| status       | String | IP 状态                                                       | binded               |
| type         | String | IP 类型                                                       | nlb                  |
| service_type | String | 绑定的实例类型                                                | 负载均衡             |
| service_id   | String | 绑定的实例 id                                                 | binded               |
| service_name | String | 绑定的实例名称                                                | mysql                |
| create_at    | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:11Z |
| update_at    | String | 更新时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:11Z |
