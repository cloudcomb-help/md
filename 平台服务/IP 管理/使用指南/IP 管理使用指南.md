# 使用指南

## 申请公网 IP

点击左侧的导航菜单「IP 管理」，进入 IP 管理列表页面，点击「申请公网 IP」按钮，进入申请公网 IP 页面，如下图所示：

![](../image/IP管理使用指南-申请公网IP.png)

* 也可以在创建有状态服务或者负载均衡时申请新 IP
* 服务 IP 用于绑定服务，负载均衡 IP 用于绑定负载均衡
* 在创建有状态服务或负载均衡页面均可以使用申请的对应服务或者负载均衡的 IP
* 费用 0.02 元/小时/IP
* 如需增加配额请提交工单联系我们

## 释放公网 IP

在IP 管理列表页面，找到需要释放的公网 IP，点击右侧的「释放」按钮即可释放你的公网 IP（已绑定服务或负载均衡的 IP 须先删除对应实例）

![](../image/IP管理使用指南-释放公网IP.png)

点击「释放」按钮后，将弹出提示，确认释放的 IP 及消费信息：

![](../image/IP管理使用指南-释放公网IP提示.png)

<span>Attention:</span><div class="alertContent">释放的 IP 无法找回。</div>

## 绑定服务

<span>Note:</span><div class="alertContent">目前支持在创建服务时绑定申请的公网 IP</div>

![](../image/IP管理使用指南-绑定服务.png)

详见：[创建有状态服务](http://support.c.163.com/md.html#!容器服务/服务管理/使用指南/创建有状态服务.md)

## 绑定负载均衡

<span>Note:</span><div class="alertContent">目前支持在创建负载均衡时绑定申请的公网 IP</div>

![](../image/IP管理使用指南-绑定负载均衡.png)

详见：[创建负载均衡](http://support.c.163.com/md.html#!容器服务/负载均衡/使用指南/创建负载均衡.md)