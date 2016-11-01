### 获取SDK

你可以直接下载编译好的可执行文件使用

* [Mac 64][1]
* [Linux 64][2]
* [Windows 64][3]


也可以自行编译，安装使用

   

     git clone https://github.com/bingoHuang/comb.git
        cd comb
        export GOPATH=`pwd`
        go get -d
        go build
        
        cp comb /usr/local/bin

下载好后即可通过命令行使用。

### 软件许可

基于 Apache License Version 2.0 开放源代码

### 使用说明

**帮助文档**

执行 comb 或 comb -h 可以查看到文档

    NAME:
       comb - is a tool to manage CloudComb resources base on cloudcomb-go-sdk.
    
    USAGE:
       comb.exe [global options] command [command options] [arguments...]
    
    VERSION:
       0.0.3 windows/amd64 go1.6.2
    
    AUTHOR(S):
       Bingo Huang <me@bingohuang.com>
    
    COMMANDS:
         auth           Auth in CloudComb with app key, app secret
         container, co  Operate containers in CLoudComb
         cluster, cu    Operate clusters in CLoudComb
         repositry, re  Operate repositrys in CLoudComb
         secretkey, sk  Operate secret keys in CLoudComb
         help, h        Shows a list of commands or help for one command
    
    GLOBAL OPTIONS:
       --debug                      debug mode [%DEBUG%]
       --log-level value, -l value  Log level (options: debug, info, warn, error, fatal, panic) (default: "info")
       --help, -h                   show help
       --version, -v                print the version

**鉴权**

在使用前，需要先使用 Access Key 和 Access Secret 来获取 Token，Token 有效期为 24 小时。

执行命令 **comb auth [Access Key] [Access Secret]** （或执行命令 **comb auth**，跟随提示输入 Access Key 和 Access Secret）即可获取 Token。

Access Key 和 Access Secret 请在「网易蜂巢控制台」的 [API菜单栏][4] 下获取。

**容器操作**

完成鉴权，获取Token后，即可执行容器操作

* **查看所有容器 comb container -a 或 comb co -a 或 comb co**
* **查看特定容器 comb co 容器ID**


  [1]: http://nos.126.net/comb/comb_darwin_amd64
  [2]: http://nos.126.net/comb/comb_linux_amd64
  [3]: http://nos.126.net/comb/comb_windows_amd64.exe
  [4]: https://c.163.com/dashboard#/m/overview/