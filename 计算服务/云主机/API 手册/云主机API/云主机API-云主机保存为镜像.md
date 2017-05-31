# 云主机 API

## 云主机保存为镜像

### 请求 URL

    POST https://open.c.163.com/api/v1/vm/privateimage

### 请求示例
    POST /api/v1/vm/privateimage HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

	{
	  "uuid" : "d3fa21b7-16fd-421c-90ac-cd4df8f78353", #云主机 UUID
	  "name" : "ubuntu20170526", #镜像名称
	  "description" : "这是一个ubuntu的测试镜像",　#镜像描述
	  "OSVersion" : "14.04", #镜像的操作系统版本
	}
### 请求参数


|     参数    |  类型  | 是否必填 |                                                        描述                                                       |                示例值                |
|-------------|--------|----------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| uuid        | String | 是       | 云主机 UUID（[获取云主机列表：uuid](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取云主机列表.md)） | d3fa21b7-16fd-421c-90ac-cd4df8f78353 |
| name        | String | 是       | 镜像名称（3-32位字母或数字组成，以字母开头）                                                                      | ubuntu20170526                       |
| description | String | 否       | 镜像描述                                                                                                          | 这是一个ubuntu的测试镜像             |
| OSVersion   | String | 否       | 镜像操作系统版本                                                                                                  | 14.04                                |

### 响应示例

```
{
  imageId : "309c75d2-a80a-4c05-86c8-8698c99255b9"
}
```

|   参数  |  类型  |   描述  |                示例值                |
|---------|--------|---------|--------------------------------------|
| imageId | String | 镜像 id | 309c75d2-a80a-4c05-86c8-8698c99255b9 |