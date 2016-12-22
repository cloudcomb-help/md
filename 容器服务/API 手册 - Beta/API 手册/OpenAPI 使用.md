# OpenAPI 使用

## 1、获取 Access Key 和 App Secret

登录 [网易蜂巢控制台](https://c.163.com/dashboard#/m/account/accesskey/)，点击右上角你的头像，进入「用户中心」选择「Access Key」标签，即可管理你的 Access Key。

## 2、获取 Token

使用 Access Key 和 App Secret，调用 OpenAPI 中的 [Token 生成接口](http://support.c.163.com/md.html#!容器服务/API 手册 - Beta/API 手册/用户 API.md)，获取授权 Token。

## 3、开始使用

使用 Token 便可以访问 OpenAPI 中的全部接口服务。如果请求没有 Token，OpenAPI 的安全机制将会视其为对服务（除了获取 Token 服务和 WebHook 服务）的未授权访问操作，进而会拦截。

<span>Attention:</span><div class="alertContent">OpenAPI 中内置了流控机制，对于恶意攻击 OpenAPI 服务的行为，会采取限制措施。</div>