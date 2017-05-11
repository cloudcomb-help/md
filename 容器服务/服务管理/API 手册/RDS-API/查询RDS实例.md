# RDS API

## 查询 RDS 实例

查询实例列表或单个实例详情。

### 请求 URL

`GET https://open.c.163.com/api/v1/rds/instances`

### 请求示例

```http
GET /api/v1/rds/instances?instance_name=my-rds HTTP/1.1
Content-Type: application/json
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
```

### 请求参数

|      参数     |  类型  | 是否必填 |   描述   | 示例值 |
|---------------|--------|----------|----------|--------|
| instance_name | String | 否       | 实例名称 | my-rds |


### 响应示例

```json
{
  "instances": [
    {
      "disk_size": 20,
      "memory": 2048,
      "vcpu": 1,
      "backup_type": "full",
      "full_backup_interval": 3,
      "backup_retention_num": 7,
      "incre_backup_interval": 1,
      "instance_name": "my-rds",
      "instance_status": "available",
      "endpoint": {
        "address": "10.18.206.127",
        "port": 3309
      },
      "engine_version": "5.6.19",
      "instance_create_time": "2017-05-11T03:18:53Z",
      "latest_restorable_time": "",
      "preferred_backup_window": "Sat:01:07-Sat:01:37",
      "disk_medium": "SSD",
      "replication_type": "VSR",
      "charge_type": "HOUR",
      "security_groups": [
        {
          "security_group_name": "default",
          "security_group_description": "Default security group",
          "ip_ranges": [
            "0.0.0.0/0"
          ]
        }
      ],
      "read_replica_instance_name": "",
      "read_replica_source_instance_name": "",
      "health_check_status": "normal",
      "health_check_score": 90,
      "enable_public_ip": false,
      "public_ip": null
    }   
  ]
}
```

### 响应参数

|                参数               |    类型   |          描述         |         示例值         |
|-----------------------------------|-----------|-----------------------|------------------------|
| disk_size                         | Integer   | 存储空间，单位 GB     | 20                     |
| memory                            | Integer   | 内存大小，单位 MB     | 2048                   |
| vcpu                              | Integer   | CPU 规格，单位 核     | 1                      |
| backup_type                       | String    | 备份类型              | full                   |
| full_backup_interval              | Integer   | 全量备份周期，单位 天 | 3                      |
| backup_retention_num              | Integer   | 备份保留个数          | 7                      |
| incre_backup_interval             | Integer   | 增量备份周期，单位 天 | 1                      |
| instance_name                     | String    | 实例名称              | my-rds                 |
| instance_status                   | String    | 实例状态              | available              |
| endpoint                          | List      | 实例访问地址          | 详见示例               |
| - address                         | String    | 实例内网 IP 地址      | 10.18.206.127          |
| - port                            | Integer   | 实例端口号            | 3309                   |
| engine_version                    | String    | 数据库引擎            | 5.6.19                 |
| instance_create_time              | String    | 实例创建时间          | 2017-05-11T03:18:53Z   |
| latest_restorable_time            | String    | 最近可恢复备份时间    | -                      |
| preferred_backup_window           | String    | 实例每天自动备份时间  | Sat:01:07-Sat:01:37    |
| disk_medium                       | String    | 硬盘介质              | SSD                    |
| replication_type                  | String    | 复制类型              | VSR                    |
| charge_type                       | String    | 计费类型              | HOUR                   |
| security_groups                   | JSONArray | 安全组                | 详见示例               |
| - security_group_name             | String    | 安全组名称            | default                |
| - security_group_description      | String    | 安全组描述            | Default security group |
| - ip_ranges                       | Array     | CIDR                  | 0.0.0.0/0              |
| read_replica_instance_name        | String    | 只读实例名称          | -                      |
| read_replica_source_instance_name | String    | 只读实例的源实例名称  | -                      |
| health_check_status               | String    | 健康检查状态          | normal                 |
| health_check_score                | Integer   | 健康检查得分          | 90                     |
| enable_public_ip                  | Boolean   | 是否启用公网 IP       | false                  |
| public_ip                         | String    | 实例公网 IP 地址      | null                   |










