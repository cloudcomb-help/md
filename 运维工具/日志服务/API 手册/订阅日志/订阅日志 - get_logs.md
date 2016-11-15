## 订阅日志

### get_logs

### 描述

获取具体订阅日志数据

### 请求语法

    {
      "position": "string"，
      "limit": number
    }

### 请求参数

position

日志订阅的起始位置信息，由接口 `get_subscription_position` 返回。
    
limit

最大日志条数限制，数值范围：[1 - 1000]。

### 响应语法

    {
      "subscription_logs": [
        {
          "uid": "string",
          "message": "string"
        }
      ],
      "count": number,
      "next_position": "string",
      "reached_ending": boolean
    }
    
### 响应元素

subscription_logs

具体日志数据。没有日志数据时队列为空。

count

实际返回的日志条数。（小于等于请求中的limit值）

next_position

连续获取日志数据的下个位置信息，可以直接用于 `/get_logs` 接口下次调用，而不需要每次都通过 `/get_subscription_position` 接口获取位置。

reached_ending

是否已到订阅日志末尾的标记，true - 表示已到末尾， false - 表示未到末尾。

### 错误码

请参考 `通用错误码` 章节

### 示例

Request:

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

Response:

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: <PayloadSizeBytes>
    {
        "logs":[
            {
                "cid":"xmad-1",
                "message":"This is a test log."
            },
            {
                "cid":"xmad-2",
                "message":"This is another test log."
            }
        ],
        "count":2,
        "reached_ending":false,
        "next_position":"dGVzdF90b3BpYzo0MDM3NDAzNzU="
    }
