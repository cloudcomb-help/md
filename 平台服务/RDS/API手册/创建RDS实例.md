# RDS API

## 创建 RDS 实例

异步接口。

### 请求 URL

`POST https://open.c.163.com/api/v1/rds/instances`

### 请求示例


```http
POST /api/v1/rds/instances HTTP/1.1
Content-Type: application/json
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30

{
  "instance_name": "my-rds",
  "engine_version": "5.6.19",
  "cpu": 1,
  "memory": 2,
  "disk_size": 20,
  "port": 3309
}
```


### 请求参数

|      参数      |   类型  | 是否必填 |                                      描述                                     | 示例值 |
|----------------|---------|----------|-------------------------------------------------------------------------------|--------|
| instance_name  | String  | 是       | 实例名称（由1~63个小写字母，数字，中划线"-"组成，以字母开头，字母或数字结尾） | my-rds |
| engine_version | String  | 是       | 数据库引擎（可选值：5.7.12、5.6.19、5.5.30）                                  | 5.6.19 |
| cpu            | Integer | 是       | CPU 规格，单位核。                                                            | 1      |
| memory         | Integer | 是       | 内存大小，单位 G。                                                            | 2      |
| disk_size      | Integer | 是       | 存储空间，取值范围 [5,800]，步长 5 GB。                                       | 20     |
| port           | Integer | 是       | 端口号（建议不要使用默认 3306）                                               | 3309   |

目前支持规格：1 核 1 GB、1 核 2 GB、2 核 4 GB、4 核 8 GB、8 核 16 GB、8 核 32 GB、16 核 64 GB

### 响应示例

```json
{
  "instance_name": "my-rds"
}
```

### 响应参数

|      参数     |  类型  |   描述   | 示例值 |
|---------------|--------|----------|--------|
| instance_name | String | 实例名称 | my-rds |


