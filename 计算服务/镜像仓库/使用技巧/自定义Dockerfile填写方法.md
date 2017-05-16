# 自定义 Dockerfile 填写方法

<span>Note:</span><div class="alertContent">在镜像仓库中，使用代码构建镜像时，支持自定义 Dockerfile。![](../image/自定义Dockerfile填写方法.png)</div>

## 书写路径

此处填写 Dockerfile 文件在代码源中的路径即可，如:

* Dockerfile 保存在源代码根目录中，取名为 dockerfile，则此处填写 `dockerfile` 即可；
* Dockerfile 保存在源代码 doc 文件夹中，取名为 DemoDockerfile，则此处填写 `doc/DemoDockerfile`

<span>Attention:</span>
注意区分大小写；
务必正确填写路径；
建议直接命名为 Dockerfile，请勿使用任何后缀名；


## Dockerfile 编写注意事项

* CMD 与 ENTRYPOINT 命令请使用数组语法；
* 在构建过程中或构建结束后，你都可以看到完整的日志文件以供排错；
* 蜂巢镜像仓库是完全免费的，考虑到大家的需求，目前的镜像构建超时时间为两小时。超出两小时镜像仍未构建完成（这个时长一般来说意味着你的镜像过于庞大或与 Dockerfile 内的源存在连接问题导致下载超时），系统将自动结束构建并返回「构建失败」状态；
* 考虑到镜像构建频率，我们在构建服务器端开启了缓存，之前构建过的 Docker Image Layer 不会重新执行构建，完成和传输的速度也会更快。

## Dockerfile 结构和写法

详见 [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)。
