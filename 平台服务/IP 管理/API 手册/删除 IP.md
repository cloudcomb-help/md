# IP 管理

## 删除 IP

删除某个 IP 实例。

### 请求 URL

`DELETE https://open.c.163.com/api/v1/ips/{id}`


### 请求示例

```http
DELETE /api/v1/ips/163 HTTP/1.1
Host: open.c.163.com
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
  "status": "deleted",
  "type": "nlb",
  "service_id": "",
  "service_name": "",
  "create_at": "2016-12-28T13:13:12Z",
  "update_at": "2016-12-28T13:13:12Z"
}
```

### 响应参数

|     参数     |  类型  |                              描述                             |        示例值        |
|--------------|--------|---------------------------------------------------------------|----------------------|
| id           | String | IP 的唯一标识符                                               | 163                  |
| ip           | String | IP                                                            | 59.111.163.163       |
| status       | String | IP 状态                                                       | deleted              |
| type         | String | IP 类型                                                       | nlb                  |
| service_id   | String | 绑定的实例 id                                                 |                      |
| service_name | String | 绑定的实例名称                                                |                      |
| create_at    | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:12Z |
| update_at    | String | 更新时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-28T13:13:12Z |
