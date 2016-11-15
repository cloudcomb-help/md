# 订阅日志

## get_logs

获取具体订阅日志数据

### 请求
#### 请求语法

    {
        "position": "string",
        "limit": number
    }

#### 请求示例

    POST / HTTP/1.1
    Host: <subscription_name>.log.c.163.com
    Content-Length: <PayloadSizeBytes>
    Content-Type: application/json
    Authorization: <AuthParams>
    Connection: Keep-Alive
    {
        "position":"dGVzdF90b3BpYzo0MDM3NDAyNzQ=",
        "limit":100
    }

#### 请求参数

|   名称   |  类型  | 是否必填 |                                描述                               |            示例值            |
|----------|--------|----------|-------------------------------------------------------------------|------------------------------|
| position | string | 是       | 日志订阅的起始位置信息，由接口 `get_subscription_position` 返回。 | dGVzdF90b3BpYzo0MDM3NDAyNzQ= |
| limit    | number | 是       | 最大日志条数限制，数值范围：[1 - 1000]。                          | 100                          |

### 响应
#### 响应语法

    {
        "subscription_logs": [
           {
              "timestamp": timestamp,
              "message": "string",
              "hostname": "string",
              "type": "string",
              "filename": "string",
              "target_dir": "string"
           }
        ],
        "count": number,
        "next_position": "string",
        "reached_ending": boolean
    }

#### 响应示例

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: <PayloadSizeBytes>
    {
        "logs":[
            {
                "timestamp": 1479195501245,
                "message": "This is a test log.",
                "hostname": "sc1-yq.server.163.org",
                "type": "logs",
                "filename": "app.log",
                "target_dir": "/var/test/"
            },
            {
                "timestamp": 1479195501411,
                "message": "This is another test log.",
                "hostname": "sc2-yq.server.163.org",
                "type": "stdout",
                "filename": "stdout.log",
                "target_dir": "/var/test/"
            }
        ],
        "count":2,
        "reached_ending":false,
        "next_position":"dGVzdF90b3BpYzo0MDM3NDAzNzU="
    }

#### 响应参数

|        名称       |    类型   |                                                                  描述                                                                 |            示例值            |
|-------------------|-----------|---------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| subscription_logs | JSONArray | 具体日志数据。没有日志数据时队列为空。                                                                                                | 详见示例                     |
| count             | number    | 实际返回的日志条数。（小于等于请求中的limit值）                                                                                       | 2                            |
| next_position     | string    | 连续获取日志数据的下个位置信息，可以直接用于 `/get_logs` 接口下次调用，而不需要每次都通过 `/get_subscription_position` 接口获取位置。 | dGVzdF90b3BpYzo0MDM3NDAzNzU= |
| reached_ending    | boolean   | 是否已到订阅日志末尾的标记，true - 表示已到末尾， false - 表示未到末尾。                                                              | false                        |

#### 失败响应

详情请参见 [错误响应](http://support.c.163.com/md.html#!运维工具/日志服务/API 手册/日志 API - 错误响应.md)。


