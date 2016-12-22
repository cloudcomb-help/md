# 密钥 API

## 获取私钥文件

<span>Note:</span><div class="alertContent">此接口每用户每秒访问次数为 300 次。</div>

### 请求示例


















### 请求 header

    GET /api/v1/secret-keys/{id}

    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json


| 参数说明 |   描述  | 类型 | 是否必填 |
|----------|---------|------|----------|
| id       | 密钥 id | long | 必填     |


### 响应
#### 成功响应

     200 OK
    [私钥文件内容]

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!容器服务/服务管理/API 手册/OpenAPI 错误响应.md)。