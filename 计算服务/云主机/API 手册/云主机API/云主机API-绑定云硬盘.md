# 云主机 API

## 绑定云硬盘

<span>Note:</span><div class="alertContent">此接口仅将云硬盘连接到云主机，需要初始化后再 mount 或联机使用，详见 [初始化云硬盘](.../md.html#!平台服务/云硬盘/使用指南/初始化云硬盘/Linux云主机分区、格式化、挂载数据盘.md)。</div>

### 请求 URL

    PUT https://open.c.163.com/api/v1/vm/{uuid}/action/mount_volume/{volume_uuid}

### 请求示例
    PUT /api/v1/vm/d3fa21b7-16fd-421c-90ac-cd4df8f78353/action/mount_volume/3df611c0-cfda-4c0c-aeda-304ef3a49d8f HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

### 请求参数


|     参数    |  类型  | 是否必填 |                                                        描述                                                       |                示例值                |
|-------------|--------|----------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| uuid        | String | 是       | 云主机 UUID（[获取云主机列表：uuid](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取云主机列表.md)） | d3fa21b7-16fd-421c-90ac-cd4df8f78353 |
| volume_uuid | String | 是       | 云硬盘 UUID（[获取云硬盘列表：volume_uuid](../md.html#!计算服务/云主机/API 手册/云硬盘 API/获取云硬盘列表.md)）   | 3df611c0-cfda-4c0c-aeda-304ef3a49d8f |

### 响应示例

```
{
  "code": "200",
  "msg": "success."
}
```

