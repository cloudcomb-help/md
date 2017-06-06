# OpenAPI 错误响应

错误响应消息

    http_status_code http_reason_phrase
    {
       "code":xxx,
       "message": "yyy"
    }

使用 Http 状态码来标志一次请求的完成情况。响应 body 包含一个机器可读的错误码（code）和一个人类可读的错误信息（message）。

## 错误码

    4000001 Invalid parameters.     
    4000002 Missing parameters.     
    4000111 fail.       
    4000112 Missing param.      
    4000113 Param invalid.      
    4000115 Param microservice name format invalid.     
    4000117 Param replicas size invalid.        
    4000119 Param spec info invalid.        
    4000120 Param container desc length out of range.       
    4000121 Param container name format invalid.        
    4000123 Param env size out of limit.        
    4000124 Param env key format invalid.       
    4000125 Param env value format invalid.     
    4000126 Param cmd lengh out of range.       
    4000127 Param log dir size out of limit.        
    4000128 Param log dir too long.     
    4000130 Param CPU weight invalid.       
    4000131 Param memory weight invalid.        
    4000133 Param volue info invalid.       
    4000134 Param port map invalid.     
    4000135 Param public network info invalid.      
    4000136 Param ssh key invalid.      
    4000137 Param disk type invalid.        
    4000139 Port map size already up to limit.      
    4000145 Update microservice fail.       
    4000146 Update volume info fail.        
    4000149 Exist container doesn’t belong to microservice in given param.      
    4000150 Param minReadySeconds out of range, 1-600s.     
    4000199 System busy, please try again later.        
    4000201 Invalid cloud volume parameters.        
    4000202 Missing cloud volume parameters.        
    4000213 Param invalid.      
    4000299 System busy, please try again later.        
    4000301 Params invalid      
    4000302 Missing param       
    4000401 Invalid parameters      
    4000402 Missing parameters      
    4000403 Invalid request body        
    4000450 Invalid path        
    4000451 Invalid serverName      
    4000452 CertId not found        
    4000453 Invalid listener protocol       
    4000454 Invalid listener port       
    4000455 Invalid listener status     
    4000458 Invalid servicePort     
    4000459 Namspace not found      
    4000460 Invalid parameter type      
    4000464 Invalid chargeMode      
    4000465 Invalid bandwidthLimit      
    4000466 Invalid lbName      
    4000482 Invalid description     
    4000469 Loadbalancer quota insufficient     
    4000470 Listener quota insufficient     
    4000471 Cluster quota inisufficient     
    4000472 Invalid policy      
    4000411 Cert name is missing        
    4000412 Cert format is invalid      
    4000413 Cert num exceed limit       
    4000414 Invalid cert name       
    4000511 fail.
    4000601 Invalid projectId
    4000602 Invalid service name
    4000603 Invalid metric
    4000604 Malformatted JSON string
    4000605 Metric list too long
    4000606 Unsupported statistics
    4000607 Unsupported metricName
    4000608 Unsupported period
    4000609 Invalid dimension
    4000610 Unsupported dimensionName
    4000801 miss required parameter
    4000802 calculate rds price error
    4000803 invalid parameter value
    4000804 request expired
    4000805 invalid siginature
    4000806 invalid db snapshot group state
    4000807 get databases failed
    4000808 dbinstance already exists
    4000809 db snapshot already exists
    4000810 db account already exists
    4000811 database already exists
    4000812 instance quota exceeded
    4000813 storage quota exceeded
    4000814 snapshot quota exceed
    4000815 mem quota exceed
    4000816 ecu quota exceed
    4000817 database quota exceed
    4000818 db account quota exceed
    4000819 invalid dbinstance state
    4000820 invalid db snapshot state
    4000821 forbidden to delete monthly or yearly instance
    4000822 forbidden operation before order confirm

    4010001     Unauthorized user.

    4030001 Api freq out of limit.      
    4030002 Container quota insufficient.       
    4030003 Ip quota insufficient.      
    4030004 App quota insufficient.     
    4030005 Replication quota insufficient.     
    4030006 Nlb quota insufficient.     
    4030007 Image quota insufficient.       
    4030008 Tag quota insufficient.     
    4030009 User status abnormal.       
    4030010 Container status abnormal.      
    4030011 App status abnormal.        
    4030012 Image status abnormal.      
    4030013 Secret key count limit.     
    4030140 Favoriate repository changed to be private.     
    4030142 Stateful microservice can’t update.     
    4030143 Nothing to update.      
    4030144 Microservice can’t update in current state.     
    4030147 Frozen fee fail.        
    4030148 Account balance is insufficient.        
    4030151 Microservice can’t be changed between repository.       
    4030152 Stateless microservice can’t be restarted.      
    4030153 Microservice can’t operate in current state.        
    4030201 Balance insufficient.       
    4030202 Cloud volume status abnormal.       
    4030258 Volume can’t operate in current state.      
    4030301 Balance insufficient        
    4030302 Quota insufficient      
    4030401 Action forbidden        
    4030410 Cert is using       
    4030411 IP is using     
    4030432 User balance is not enough      
    4030462 Loadbalancer is creating
    4030801 permission forbidden
    4030802 missing authentication token
    4030102 Microservice abandoned due to arrearage.

    4040114 No such namespace.      
    4040118 No such spec.       
    4040129 No such image.      
    4040141 No such microservice.       
    4040001 No such user.       
    4040002 No such container.      
    4040003 No such app.        
    4040004 No such repository.     
    4040005 No such secret key.     
    4040006 No such api.        
    4040201 No such cloud volume.       
    4040301 No such user        
    4040302 No such IP      
    4040401 No such resource        
    4040402 No such loadbalancer        
    4040410 No such cert        
    4040456 No such listener        
    4040412 No such IP
    4040801 dbinstance not found
    4040802 dbinstance id not found
    4040803 dbinstance duplicate
    4040804 db security group not found
    4040805 account name not found
    4040806 database name not found
    4040807 snapshot not found
    4040808 standard not found

    4050001     Http method not allowed.

    4080001     Request timeout.

    4090001 Duplicate container name.       
    4090002 Duplicate replication size.     
    4090003 Duplicate app name.     
    4090004 Duplicate secret key name.      
    4090005 Duplicate repository name.      
    4090132 Duplicate volume info.      
    4090138 Duplicate log directory.        
    4090116 Duplicate microservice name.        
    4090122 Duplicate container name.       
    4090201 Duplicate cloud volume name.        
    4090401 Duplicate resource      
    4090483 Duplicate loadbalancer name     
    4090451 Duplicate serverName        
    4090457 Duplicate forward rule      
    4090467 Duplicate path      
    4090480 Duplicate listener      
    4090410 Duplicate cert name

    4150001     Unsupported media type.

    4220001     Unprocessable entity.
 
    4330801 not certification

    5000001 Create container error.     
    5000002 Delete container error.     
    5000003 Create app error.       
    5000004 Delete app error.       
    5000005 Create secret key error.        
    5000006 Delete secret key error.        
    5000007 Nce internal server error.      
    5000300 Server Error        
    5000301 Create IP fail      
    5000302 Delete IP fail      
    5000303 IP not enough       
    5000400 Server error        
    5000401 List loadbalancers error        
    5000402 Create loadbalancer error       
    5000403 Describe loadbalancer error     
    5000404 Update loadbalancer error       
    5000405 Delete loadbalancer error       
    5000406 Get listener error      
    5000407 Add listener error      
    5000408 Update listener error       
    5000409 Delete listener error       
    5000410 List certs error        
    5000411 Upload cert error       
    5000412 Update cert error       
    5000413 Delete cert error       
    5000500 create failed.
    5000801 internal failure