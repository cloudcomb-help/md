# 云主机 API

## 绑定公网 IP

### 请求 URL

    PUT https://open.c.163.com/api/v1/vm/{uuid}/action/mountPublicIp?pubIp={pubIp}&portId={portId}&qosMode={qosMode}&bandWidth={bandWidth}

### 请求示例
    PUT /api/v1/vm/d3fa21b7-16fd-421c-90ac-cd4df8f78353/action/mountPublicIp?pubIp=59.111.163.163&portId=ee1a2ab4-4fbb-4388-a205-27b777487fe4&qosMode=netflow&bandWidth=100 HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30

### 请求参数


|    参数   |   类型  | 是否必填 |                                                        描述                                                       |                示例值                |
|-----------|---------|----------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| uuid      | String  | 是       | 云主机 UUID（[获取云主机列表：uuid](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取云主机列表.md)） | d3fa21b7-16fd-421c-90ac-cd4df8f78353 |
| pubIp     | String  | 是       | 公网 IP 地址（[申请 IP：ip](../md.html#!计算服务/云主机/API 手册/IP管理 API/创建 IP.md)、[获取 IP 列表P：ip](../md.html#!计算服务/云主机/API 手册/IP管理 API/获取 IP 列表.md)）                                                                                                      | 59.111.163.163                       |
| portId    | String  | 是       | 公网 IP 的唯一标识符（[获取 IP 列表P：id](../md.html#!计算服务/云主机/API 手册/IP管理 API/获取 IP 列表.md)）      | ee1a2ab4-4fbb-4388-a205-27b777487fe4                                     |
| qosMode   | String  | 是       | 计费类型，取值  netflow（按流量）/bandwith（按带宽）                                                              | netflow                              |
| bandWidth | Integer | 是       | 公网带宽                                                                                                          | 100                                  |

### 响应示例

```
{
  "code": "200",
  "msg": "success."
}
```

