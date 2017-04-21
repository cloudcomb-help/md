# IP 管理 API

## 查看 IP 配额

### 请求 URL

`GET https://open.c.163.com/api/v1/ips/quota`

### 请求示例

```http
GET /api/v1/ips/quota HTTP/1.1
Authorization: Token 93cb02be6a83447a8dfd83221e8d4a96
Content-Type: application/json
```

### 响应示例

```json
{
  "total": 20,
  "used": 5,
  "quotas": [
    {
      "type": "nce",
      "quota": 10,
      "used": 2
    },
    {
      "type": "nlb",
      "quota": 10,
      "used": 3
    }
  ]
}
```

### 响应参数


|  参数  |    类型   |        描述        |  示例值  |
|--------|-----------|--------------------|----------|
| total  | Number    | 总配额             | 20       |
| used   | Number    | 已使用配额         | 5        |
| quotas | JSONArray | 不同类型的配额详情 | 详见示例 |
| type   | String    | IP 类型            | nce      |
| quota  | String    | 对应类型的配额     | 10       |
