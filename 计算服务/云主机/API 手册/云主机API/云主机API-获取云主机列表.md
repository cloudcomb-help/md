# 云主机 API

## 获取云主机列表

获取用户所有云主机信息。

### 请求 URL

    GET https://open.c.163.com/api/v1/vm/allInstanceInfo?pageSize={pageSize}&pageNum={pageNum}

### 请求示例
    GET /api/v1/vm/allInstanceInfo?pageSize=4&pageNum=1 HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数

|   参数   |   类型  | 是否必填 |                     描述                     | 示例值 |
|----------|---------|----------|----------------------------------------------|--------|
| pageSize | Integer | 否       | 请求分页大小                                 | 4      |
| pageNum  | Integer | 否       | 请求分页页号                                 | 1      |


<span>Note:</span><div class="alertContent">pageSize 与 pageNum 同时为空时，默认 pageSize=20&pageNum=1；
否则两者要同时不为空才有效。</div>


### 响应示例

```json
{
  "total_page": 1, #总共可以分页的页数
  "total_count": 2, #云主机总数
  "instances": [
    {
        "tenantId": "0b442fefe4a54979a985eb9b1744905b", #租户 id
        "name": "admin", #用户名
        "uuid": "d3fa21b7-16fd-421c-90ac-cd4df8f78353", #云主机 UUID
        "status": "ACTIVE", #云主机状态
        "dhcp": 1, #是否自动分配 IP
        "vnet_ip": "10.18.192.43", #内网 IP 地址
        "root_gb": 20, #系统盘容量
        "vcpu": 4, #CPU 核数
        "memory_gb": 4, #内存大小
        "flavorId": 170, #规格 id
        "loginTimes": 0, #云主机登录次数
        "vnet_port_id": "e55f0351-4d8f-4a44-8f5d-9cccaa261a1e", #云主机内网网络端口
        "OSType": "linux", #云主机操作系统类型
        "imageRef": "19b79122-d407-445f-8619-0ee5aa6c00bb", #镜像 id
        "images": [
            {
                "imageName": "Centos 6.5 64位", #镜像名称
                "imageId": "19b79122-d407-445f-8619-0ee5aa6c00bb",#镜像 id
                "OSType": "linux", #镜像操作系统类型
                "OSVersion": "6.5", #镜像操作系统版本
                "status": "ACTIVE", #镜像状态
                "is_public": 1, #镜像是否公开
                "distribution": "centos" #镜像发行商
            }
        ],
        "chargeType": "HOUR", #云主机计费类型
        "id": 1023, #云主机 id
        "createTime": 1492590158000, #云主机创建时间
        "updateTime": 1492763700000, #云主机更新时间
        "public_ip": "59.111.163.163", #云主机绑定的公网 IP 地址
        "public_port_id": "ee1a2ab4-4fbb-4388-a205-27b777487fe4", #云主机绑定的公网 IP 唯一标识符
        "bandWidth": "100", #云主机绑定公网 IP 的带宽
        "public_port_status": "binded", #云主机绑定公网 IP 的状态
        "publicQosMode": "bandwidth", #云主机绑定公网IP 的计费形式
        "properties": "{\"publicKeys\":\"ubuntu,\"}" #云主机秘钥
        "attached_volumes": [
                     {
                                    "volumeId": "4f82db7f-d166-44c0-b778-89a80a182165",#云主机挂载的数据盘 UUID
                                    "status": "mount_succ", #云主机挂载的数据盘状态 
                                    "name": "my-volume-a"#云主机挂载的数据盘名称
                       },
                      {
                                    "volumeId": "2b65d520-fec9-4d07-95b9-c23b66674e39",
                                    "status": "mount_succ",
                                    "name": "my-volume-b"
                       }
                    ]
    },
    {
      "tenantId": "0b442fefe4a54979a985eb9b1744905b",
      "name": "admin",
      "uuid": "d3fa21b7-16fd-421c-90ac-cd4df8f78353",
      "status": "ACTIVE",
      "dhcp": 1,
      "vnet_ip": "10.18.192.43",
      "root_gb": 20,
      "vcpu": 4,
      "memory_gb": 4,
      "flavorId": 170,
      "loginTimes": 0,
      "billCategory": 1,
      "vnet_port_id": "e55f0351-4d8f-4a44-8f5d-9cccaa261a1e",
      "OSType": "linux",
      "imageRef": "19b79122-d407-445f-8619-0ee5aa6c00bb",
      "images": [
        {
          "imageName": "Centos 6.5 64位",
          "imageId": "19b79122-d407-445f-8619-0ee5aa6c00bb",
          "OSType": "linux",
          "OSVersion": "6.5",
          "status": "ACTIVE",
          "is_public": 1,
          "distribution": "centos"
        }
      ],
      "chargeType": "HOUR",
      "id": 1023,
      "createTime": 1492590158000,
      "updateTime": 1492763700000,
      "public_ip": null,
      "public_port_id": null,
      "bandWidth": null,
      "public_port_status": null,
      "publicQosMode": null,
      "properties": "{\"publicKeys\":\"ubuntu,\"}"
    },
  ]
}
```


### 响应参数

|        参数        |    类型    |                       描述                       |                示例值                |
|--------------------|------------|--------------------------------------------------|--------------------------------------|
| total_page         | Integer    | 总共可以分页的页数                               | 1                                    |
| total_count        | Integer    | 云主机总数                                       | 2                                    |
| tenantId           | String     | 租户 id                                          | 0b442fefe4a54979a985eb9b1744905b     |
| name               | String     | 用户名                                           | admin                                |
| uuid               | String     | 云主机 UUID                                      | d3fa21b7-16fd-421c-90ac-cd4df8f78353 |
| status             | String     | 云主机状态                                       | ACTIVE                               |
| dhcp               | Integer    | 是否自动分配 IP，1（是）/0（否 ）                | 1                                    |
| vnet_ip            | String     | 内网 IP 地址                                     | 10.18.192.43                         |
| root_gb            | Integer    | 系统盘容量，单位 GB                              | 20                                   |
| vcpu               | Integer    | CPU 核数                                         | 4                                    |
| memory_gb          | Integer    | 内存大小                                         | 4                                    |
| flavorId           | Integer    | 规格 id                                          | 170                                  |
| vnet_port_id       | String     | 云主机内网网络端口                               | e55f0351-4d8f-4a44-8f5d-9cccaa261a1e |
| OSType             | String     | 云主机操作系统类型                               | linux                                |
| imageRef           | String     | 镜像 id                                          | 19b79122-d407-445f-8619-0ee5aa6c00bb |
| images             | JASONArray | 云主机使用的镜像信息                             | 详见示例                             |
| - imageName        | String     | 镜像名称                                         | Centos 6.5 64位                      |
| - imageId          | String     | 镜像 id                                          | 19b79122-d407-445f-8619-0ee5aa6c00bb |
| - OSType           | String     | 镜像操作系统类型                                 | linux                                |
| - OSVersion        | String     | 镜像操作系统版本                                 | 6.5                                  |
| - status           | String     | 镜像状态                                         | ACTIVE                               |
| - is_public        | Integer    | 镜像是否公开，1（公共镜像）/0（自定义镜像）      | 1                                    |
| - distribution     | String     | 镜像发行商                                       | centos                               |
| chargeType         | String     | 云主机计费类型                                   | HOUR                                 |
| id                 | String     | 云主机 id                                        | 1023                                 |
| createTime         | Long       | 云主机创建时间                                   | 1492590158000                        |
| updateTime         | Long       | 云主机更新时间                                   | 1492763700000                        |
| public_ip          | String     | 云主机绑定的公网 IP 地址（为空表示未绑定）       | 59.111.163.163                       |
| public_port_id     | String     | 云主机绑定的公网 IP 唯一标识符（为空表示未绑定） | ee1a2ab4-4fbb-4388-a205-27b777487fe4 |
| bandWidth          | String     | 云主机绑定公网 IP 的带宽                         | 100                                  |
| public_port_status | String     | 云主机绑定公网 IP 的状态                         | binded                               |
| publicQosMode      | String     | 云主机绑定公网的计费类型                         | bandwidth                            |
| properties         | JSONObject | 云主机秘钥                                       | {\"publicKeys\":\"ubuntu,\"}         |
| attached_volumes   | JASONArray | 云主机挂载的数据盘信息                           | 详见示例                             |
| - volumeId         | String     | 云主机挂载的数据盘 UUID                          | 4f82db7f-d166-44c0-b778-89a80a182165 |
| - status           | String     | 云主机挂载的数据盘状态                           | mount_succ                           |
| - name             | String     | 云主机挂载的数据盘名称                           | my-volume-a                          |











