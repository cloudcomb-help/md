# GOLANG SDK 手册

## 错误处理

返回的错误类型一共有两种，分别是客户端错误和服务端错误，分别都实现了error方法。

    type ClientError struct {
        StatusCode int
        Resource string
        Message  string
    }
    
    type ServerError struct {
        StatusCode int
        RequestId  string
        NosErr     NosError   //服务端返回的原始错误内容
    }
    
    type NosError struct {
        Code         string
        Message      string
        Resource     string
        NosRequestId string  //请求ID,非常重要，有利于nos开发人员跟踪异常请求的错误原因
    }
    Next  Previous

