#  云硬盘
## 获取云硬盘列表

> 请求示例

```http
GET /api/v1/cloud-volumes?limit=10&offset=0 HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
Content-Type: application/json
```

> 响应示例

```json
{
    "total": 2, 
    "volumes": [
        {
            "created_at": "2016-12-23T08:05:22Z", 
            "file_system_type": "Ext4", 
            "from_snapshot_id": 0, 
            "id": 19894, 
            "name": "myvolume2", 
            "service_name": "myspace/myservice", 
            "size": 10, 
            "status": "mount_succ", 
            "upated_at": "2016-12-23T08:17:21Z", 
            "volume_mappings": [
                {
                    "mount_path": "/data/", 
                    "service_container_id": 49927
                }
            ], 
            "volume_uuid": "3df611c0-cfda-4c0c-aeda-304ef3a49d8f"
        }, 
        {
            "created_at": "2016-12-23T07:52:08Z", 
            "file_system_type": "Ext4", 
            "from_snapshot_id": 0, 
            "id": 19893, 
            "name": "myvolume", 
            "service_name": "", 
            "size": 10, 
            "status": "create_succ", 
            "upated_at": "2016-12-23T07:52:08Z", 
            "volume_mappings": [], 
            "volume_uuid": "2cf3face-adc8-41af-992c-78415d2fcd96"
        }
    ]
}
```



### HTTP Request

`GET https://open.c.163.com/api/v1/cloud-volumes?limit={limit}&offset={offset}`

### URL Parameters


|  参数  | 类型 | 是否必填 |                  描述                  | 示例值 |
| ------ | ---- | -------- | -------------------------------------- | ------ |
| limit  | int  | 否       | 每次获取的云硬盘数量，取值范围 (0,20]  |     20 |
| offset | int  | 否       | 获取云硬盘列表起始位置，[0,+∞)，默认 0 |      0 |


### Query Parameters

|         参数         |  类型  |                              描述                             |                示例值                |
|----------------------|--------|---------------------------------------------------------------|--------------------------------------|
| id                   | long   | 云硬盘 id                                                     | 19894                                |
| name                 | String | 云硬盘名称                                                    | myvolume2                            |
| size                 | int    | 云硬盘大小，单位为 G                                          | 10                                   |
| status               | String | 云硬盘当前状态                                                | mount_succ                           |
| volume_uuid          | String | 云硬盘 uuid                                                   | 3df611c0-cfda-4c0c-aeda-304ef3a49d8f |
| service_name         | String | 云硬盘所属空间和服务名称                                      | myspace/myservice                    |
| file_system_type     | String | 云硬盘格式类型                                                | Ext4                                 |
| created_at           | String | 创建时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-23T08:05:22Z                 |
| updated_at           | String | 修改时间，使用 UTC（世界标准时间）时间，用 ISO8601 进行格式化 | 2016-12-23T08:05:22Z                 |
| from_snapshot_id     | long   | 云硬盘来源的快照 id，0 表示不是由快照创建                     | 0                                    |
| volume_mappings      | List   | 云硬盘的挂载信息列表                                          | 详见示例                             |
| service_container_id | long   | 云硬盘所属容器 id                                             | 49927                                |
| mount_path           | String | 云硬盘挂载路径                                                | /data/                               |
