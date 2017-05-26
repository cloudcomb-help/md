# 云主机 API

## 创建云主机

### 请求 URL

    POST https://open.c.163.com/api/v1/vm

### 请求示例
    POST /api/v1/vm HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30
    Content-Type: application/json

    {
        "bill_info":"HOUR", #计费类型
        "server_info":{
            "instance_name":"my-centos", #云主机名称
            "ssh_key_names":["my-mac"],#公钥名称
            "admin_password":"Netease163", #Windows 云主机系统管理员密码
            "image_id":"19b79122-d407-445f-8619-0ee5aa6c00bb", #镜像 id
            "cpu_weight":2, #CPU 数量
            "memory_weight":4,#内存大小
            "ssd_weight":20 #(必选)云主机系统盘大小，单位GB，linux系统盘大小统一20G，windows系统盘大小统一40G
            "description":"testdescription" #描述
        }
    }


### 请求参数

|      参数      |   类型  |     是否必填     |                                                                                                         描述                                                                                                        |                示例值                |
|----------------|---------|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| bill_info      | String  | 否               | 计费类型，目前只支持创建按量付费（HOUR）的云主机                                                                                                                                                                    | HOUR                                 |
| instance_name  | String  | 是               | 云主机名，3-32字母，数字或者中划线组成，以字母开头                                                                                                                                                                  | my-centos                            |
| ssh_key_names  |         | Linux 镜像必选   | 公钥名称（[查看密钥列表 - name](../md.html#!计算服务/云主机/API 手册/密钥 API/密钥 API - 查看密钥列表.md)）                                                                                                         | my-mac                               |
| admin_password | String  | Windows 镜像必选 | Windows 云主机系统管理员密码系统管理员密码，由 8-30 个字符组成，须同时包含大写字母，小写字母，数值和特殊符号中的一种以及以上                                                                                        | Netease163                           |
| image_id       | String  | 是               | 镜像 id（[获取公共镜像：imageId](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取公共镜像.md)、[获取自定义镜像：imageId](../md.html#!计算服务/云主机/API 手册/云主机API/云主机API-获取自定义镜像.md)） | 19b79122-d407-445f-8619-0ee5aa6c00bb |
| cpu_weight     | Integer | 是               | CPU 数量                                                                                                                                                                                                            | 2                                    |
| memory_weight  | Integer | 是               | 内存数量，单位 GB                                                                                                                                                                                                   | 4                                    |
| ssd_weight     |         |                  |                                                                                                                                                                                                                     |                                      |
| description    | String  | 否               | 描述，一百字以内                                                                                                                                                                                                    | testdescription                      |

### 响应示例

```
 {
    "d41739b7-62a8-4126-93bd-536ec569a14f" #创建的云主机 UUID
 }
```

