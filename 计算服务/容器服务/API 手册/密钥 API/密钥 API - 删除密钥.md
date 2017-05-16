# 密钥 API

## 删除密钥

### 请求 header

    DELETE /api/v1/secret-key/{id}
    
    Authorization:Token xxxxxxxxxxxxxx
    Content-Type:application/json

| 参数说明 |   描述  | 类型 | 是否必填 |
|----------|---------|------|----------|
| id       | 密钥 id | long | 必填     |


### 响应
#### 成功响应

     200 Ok

#### 失败响应
详情请参见 [错误返回码](http://support.c.163.com/md.html#!计算服务/容器服务/API 手册/OpenAPI 错误响应.md)。
