# RDS API

## 删除 RDS 实例

异步接口。

### 请求 URL

`DELETE https://open.c.163.com/api/v1/rds/instances/{instance_name}`

### 请求示例

```http
DELETE /api/v1/rds/instances/myrds HTTP/1.1
Content-Type: application/json
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
```

### 请求参数


|      参数     |  类型  | 是否必填 |   描述   | 示例值 |
|---------------|--------|----------|----------|--------|
| instance_name | String | 是       | 实例名称 | my-rds |

