## 1 环境准备

### 1.1 SDK

github地址: [https://github.com/NetEase-Cloudsearch/stream-python-sdk](https://github.com/NetEase-Cloudsearch/stream-python-sdk)
pypi地址:   [https://pypi.python.org/pypi/stream-python-sdk/](https://pypi.python.org/pypi/stream-python-sdk/)

### 1.2 环境要求

此版本的PYTHON SDK适用于Python 2.7版本。首先请根据 [python 官网](https://www.python.org/)的引导安装合适的Python版本。

### 1.3 安装

#### 1.3.1 pip方式

如果您通过pip管理您的项目依赖，可以在你的控制台运行:sudo pip install stream-python-sdk

#### 1.3.2 源码方式

使用SDK源码安装，可以克隆github上SDK项目的master分支，或者到pypi上下载相应版本的源码包并解压，最后执行安装命令:sudo python setup.py install

## 2 接入


接入实时传输服务，您需要拥有一对有效的Access key 和Secret key用于进行用户身份认证和签名。

在获取到Access key 和 Secret key之后，可以通过以下方式进行密钥设置：

    String access_key_id = "your-accesskey";
    String access_key_secret = "your-secretKey ";

    client = stream_client.StreamClient(
        access_key_id="string",
        access_key_secret="string"
    )

## 3 使用

### 3.0 前言

#### 3.0.1 用户反馈

为了提供更加优质的实时传输服务，给用户创造更多的价值，实时传输离不开大家的的支持和反馈，如发现本指南中的任何有问题的地方，以及其他意见和建议，请在本指南页面下反馈，我们会及时安排跟进，谢谢。


#### 3.0.2 关于异常

实时传输的所有错误异常包装在两个异常类型中，在调用实时传输接口的时候，捕捉这些异常并打印必要的信息有利于定位问题。


    try:
    resp = stream_client.StreamClient.XXX(
        subscription_name=subscription_name,
        position_type=position_type
    )
    except stream.exceptions.ServiceException as e:
    print (
        'ServiceException: %s\n'
        'message: %s\n'
    ) % (
        e,
        e.message       # 错误描述信息
    )
    except stream.exceptions.ClientException as e:
    print (
        'ClientException: %s\n'
        'message: %s\n'
    ) % (
        e,
        e.message       # 客户端错误信息
    )
        

### 3.1 获取订阅起始位置

获取订阅起始位置接口，用来获取订阅日志起始位置

#### 3.1.1 请求

请求参数包括positionType和subscriptionName


|名称|类型|是否必填|描述|示例值|
|----|----|--------|----|------|
|position_Type|String|  是  | 日志订阅的起始位置类型，共有三种类型：1、EARLIEST - 从能获取到的最前面位置开始读取日志（已删除的除外）  2、LATEST - 从最末尾开始读取日志（最新日志）  3、STORED -从保存的位置开始读取日志（上次读取过的位置） | EARLIEST|
| subscription_Name  | String| 是| 日志订阅的主题，命名规则：服务名.空间名| test201612121010.statetest-combloghzx |

#### 3.1.2 响应

响应示例

	{
    "code": 200,
    "message": "OK",
    "result": {
        "position": "dGVzdDIwMTYxMjEyMTAxMC5zdGF0ZXRlc3QtY29tYmxvZ2h6eDow"
              }
    }


响应参数

|名称 |类型 |描述|示例值|
|-----|-----|----|------|
| code | INT | 操作响应码 | 200 |
| message | STRING | 操作结果附加消息 | OK |
| result | JSON OBJECT | 结果信息 | |
| position| STRING | 具体订阅日志位置信息 | dGVzdDIwMTYxMjEyMTAxMC5zdGF0ZXRlc3QtY29tYmxvZ2h6eDow |


#### 3.1.3 代码示例

	resp = client.get_subscription_position(
    subscription_name=topic_name,
    position_type=position_type
    )
	

### 3.2 获取订阅日志

获取具体订阅日志数据


#### 3.2.1&nbsp;请求

请求参数包括logsPosition, limit和subscriptionName

|名称| 类型|是否必填| 描述|示例值|
|----|-----|---------------------|-----|------|
| logs_Position | String|是| 日志订阅的起始位置信息，由获取订阅日志起始位置接口返回。 | dGVzdDIwMTYxMjEyMTAxMC5zdGF0ZXRlc3QtY29tYmxvZ2h6eDow |
| limit | Int  | 是 | 获取订阅日志条数限制，目前小于等于1000 | 100 |
| subscriptionName| String| 是 | 日志订阅的主题，命名规则：服务名.空间名  | test201612121010.statetest-combloghzx |

#### 3.2.2 响应

响应示例

    {
    "code": 200,
    "message": "OK",
    "result": {
        "subscription_logs": [
            {
                "timestamp": 1481521668314,
                "message": "slfjkasjfas",
                "hostname": "yanlian-20-nce-963214757b77-1476845634424-b120f197",
                "type": "logs",
                "filename": "z",
                "target_dir": "/container/logs/statetest-combloghzx/test201612121010-3855-3020510058-wrbb0/test201612121010/test/",
                "name_space": "statetest-combloghzx",
                "service_name": "test201612121010",
                "container_name": "test201612121010",
                "seq_id": 0
            }
        ],
        "count": 1,
        "next_position": "dGVzdDIwMTYxMjEyMTAxMC5zdGF0ZXRlc3QtY29tYmxvZ2h6eDox",
        "reached_ending": false
        }
    }




响应参数

|名称|类型|描述|示例值|
|----|----|----|------|
|code | INT | 操作响应码 | 200 |
|message | STRING | 操作结果附加消息 | OK |
|result | JSON OBJECT | 结果信息 | |
|subscription_logs | JSON ARRAY | 订阅日志 | |
|timestamp | TIMESTAMP | 日志时间戳 | 1481521668314 |
|message | STRING | 日志信息 | slfjkasjfas |
|hostname | STRING | 主机名 | yanlian-20-nce-963214757b77-1476845634424-b120f197 |
|type | STRING | 日志类型 | logs |
|filename | STRING | 日志文件名 | z |
|target_dir | STRING | 日记文件目录 | /container/logs/statetest-combloghzx/test201612121010-3855-3020510058-wrbb0/test201612121010/test/ |
|name_space | STRING | 空间名称 | statetest-combloghzx |
|service_name | STRING | 服务名称 | test201612121010 |
|container_name | STRING | 容器名称 | test201612121010 |
|seq_id | INT | 序列号 | 0 |
|count | INT | 返回日志条数， 小于等于limit| 1 |
|next_position | STRING | 日志数据下个位置信息| dGVzdDIwMTYxMjEyMTAxMC5zdGF0ZXRlc3QtY29tYmxvZ2h6eDox |
|reached_ending | BOOLEAN | 是否已到订阅日志末尾的标记 &nbsp;true：已到末尾 &nbsp;false：未到末尾。 | false  |

#### 3.2.3 代码示例

    resp = client.get_logs(
    subscription_name=topic_name,
    logs_position=logs_position,
    limit=limit
    )

