## 订阅日志

### get_subscription_position


#### 描述

获取订阅开始的位置信息

<span>Note:</span><div class="alertContent">此接口每用户每分钟访问次数为 5 次。</div>


#### 请求语法

    {
      "position_type": "string"
    }

#### 请求参数

position_type

日志订阅的起始位置类型，共有三种类型：

* EARLIEST - 从能获取到的最前面位置开始读取日志（已删除的除外）；
* LATEST - 从最末尾开始读取日志（最新日志）；
* STORED - 从保存的位置开始读取日志（上次读取过的位置）。

#### 响应语法

    {
      "position": "string"
    }
    
#### 响应元素

position

获取到的具体位置信息。

#### 错误码

请参考 `通用错误码` 章节

#### 示例

Request:

    POST / HTTP/1.1
    Host: <subscription_name>.log.c.163.com
    Content-Length: <PayloadSizeBytes>
    Content-Type: application/json
    Authorization: <AuthParams>
    Connection: Keep-Alive
    {
        "position_type":"EARLIEST"
    }
Response:

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: <PayloadSizeBytes>
    {
        "position":"dGVzdF90b3BpYzo0MDM3NDAyNzQ="
    }
