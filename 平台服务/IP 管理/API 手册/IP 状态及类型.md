# 云硬盘

## 创建云硬盘

> 请求示例

```http
POST /api/v1/cloud-volumes HTTP/1.1
Host: open.c.163.com
Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
Content-Type: application/json

{
  "volume_name": "myvolume",
  "size": 10
}
```


> 响应示例

```json
{
  "id": 19893
}
```



### HTTP Request

`POST https://open.c.163.com/api/v1/cloud-volumes`

### URL Parameters

|     参数    |  类型  | 是否必填 |                                           描述                                          |  示例值  |
|-------------|--------|----------|-----------------------------------------------------------------------------------------|----------|
| volume_name | String | 是       |  云硬盘名称（1~32 位小写字母、数字或中划线组成，并且以字母开头，以数字或字母结尾） | myvolume |
| size        | int    | 是       | 云硬盘大小，单位为 G（大于等于 10 小于 1000，且必需是 10 的整数倍）             | 10       |



### Query Parameters

| 参数 | 类型 |    描述   | 示例值 |
|------|------|-----------|--------|
| id   | long | 云硬盘 id |  19893 |
