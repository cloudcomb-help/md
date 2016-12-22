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
    4000111     fail.
    4000112     Missing param.
    4000113     Param invalid.
    4000115     Param microservice name format invalid.
    4000117     Param replicas size invalid.
    4000119     Param spec info invalid.
    4000120     Param container desc length out of range.
    4000121     Param container name format invalid.
    4000123     Param env size out of limit.
    4000124     Param env key format invalid.
    4000125     Param env value format invalid.
    4000126     Param cmd lengh out of range.
    4000127     Param log dir size out of limit.
    4000128     Param log dir too long.
    4000130     Param CPU weight invalid.
    4000131     Param memory weight invalid.
    4000133     Param volue info invalid.
    4000134     Param port map invalid.
    4000135     Param public network info invalid.
    4000136     Param ssh key invalid.
    4000137     Param disk type invalid.
    4000139     Port map size already up to limit.
    4000145     Update microservice fail.
    4000146     Update volume info fail.
    4000149     Exist container doesn't belong to microservice in given param.
    4000150     Param minReadySeconds out of range, 1-600s.
    4000199     System busy, please try again later.

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
    4030140     Favoriate repository changed to be private.
    4030142     Stateful microservice can't update.
    4030143     Nothing to update.
    4030144     Microservice can't update in current state.
    4030147     Frozen fee fail.
    4030148     Account balance is insufficient.
    4030151     Microservice can't be changed between repository.
    4030152     Stateless microservice can't be restarted.
    4030153     Microservice can't operate in current state.
    4040114     No such namespace.
    4040118     No such spec.
    4040129     No such image.
    4040141     No such microservice.

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
    4090132     Duplicate volume info.
    4090138     Duplicate log directory.
    4090116     Duplicate microservice name.
    4090122     Duplicate container name.

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