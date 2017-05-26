# OpenAPI 错误响应

错误响应消息

    http_status_code http_reason_phrase
    {
       "code":xxx,
       "message": "yyy"
    }

使用 Http 状态码来标志一次请求的完成情况。响应 body 包含一个机器可读的错误码（code）和一个人类可读的错误信息（message）。

## 错误码

400 Bad Request 

    4000001     Invalid parameters.
    4000002     Missing parameters.

401 Unauthorized 

    4010001     Unauthorized user.

403 Forbidden 

    4030001     Api freq out of limit.
    4030002     Container quota insufficient.
    4030003     Ip quota insufficient.
    4030004     App quota insufficient.
    4030005     Replication quota insufficient.
    4030006     Nlb quota insufficient.
    4030007     Image quota insufficient.
    4030008     Tag quota insufficient.
    4030009     User status abnormal.
    4030010     Container status abnormal.
    4030011     App status abnormal.
    4030012     Image status abnormal.
    4030013     Secret key count limit.

404 Not Found

    4040001     No such user.
    4040002     No such container.
    4040003     No such app.
    4040004     No such repository.
    4040005     No such secret key.
    4040006     No such api.

405 Method Not Allowed

 

    4050001     Http method not allowed.

408 Request Timeout

    4080001     Request timeout.

409 Conflict

    4090001     Duplicate container name.
    4090002     Duplicate replication size.
    4090003     Duplicate app name.
    4090004     Duplicate secret key name.
    4090005     Duplicate repository name.

415 Unsupported Media Type 

    4150001     Unsupported media type.

422 Unprocessable Entity 

    4220001     Unprocessable entity.

500 Internal Server Error 

    5000001     Create container error.
    5000002     Delete container error.
    5000003     Create app error.
    5000004     Delete app error.
    5000005     Create secret key error.
    5000006     Delete secret key error.
    5000007     Nce internal server error.