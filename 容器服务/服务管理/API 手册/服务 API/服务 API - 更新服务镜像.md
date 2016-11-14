# 密钥 API

## 创建密钥

### 请求 header

    PUT  /api/v1/microservices/{microserviceId}/actions/update-image

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


### 请求 payload

    {
        "min_ready_seconds": 11,
        "container_images": [{
            "container_id":712,
            "image_path": "hub.c.163.com/nce2/mariadb"
        }]
    }

|      参数说明     |    描述   |                       类型                      | 是否必填 |
|-------------------|-----------|-------------------------------------------------|----------|
| microserviceId    | long      | 服务 id                                         | 必选     |
| container_images  | JSONArray | item 包含两部分信息：container_id 与 image_path | 必选     |
| container_id      | long      | 容器信息 Id                                     | 必选     |
| image_path        | string    | 更新后的容器镜像路径                            | 必选     |
| min_ready_seconds | int       | 副本更新时间间隔（s），1-600 s                  | 必选     |


