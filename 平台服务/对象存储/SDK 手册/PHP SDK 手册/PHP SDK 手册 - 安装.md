# PHP SDK 手册
## 安装

### SDK

GitHub 地址: https://github.com/NetEase-Object-Storage/nos-php-sdk

ChangLog: https://github.com/NetEase-Object-Storage/nos-php-sdk/blob/master/README.md

历史版本: 无

### 环境要求

php5.3+ 使用以下命令显示当前的 php 版本:

    php -v

cURL 扩展 使用以下命令查看 curl 扩展是否已经安装好:

    php -m

Windows下用户，请参考 Windows下使用NOS PHP SDK

### 安装

#### composer方式

如果您通过 composer 管理您的项目依赖，可以在你的项目根目录运行:

    composer require netease/nos-php-sdk

或者在你的 composer.json 中声明对 NOS SDK for PHP 的依赖:

    "require": {
    "netease/nos-php-sdk": "1.0.0"
    }

然后通过 conposer install 安装依赖，安装完成后形成如下目录结构:

    .
    ├── app.php
    ├── composer.json
    ├── composer.lock
    └── vendor

其中 app.php 是用户的应用程序，vendor/ 目录下包含了所依赖的库，用户需要在 app.php 中引入如下依赖:

    require_once __DIR__ . '/vendor/autoload.php';

1. 如果项目中已经引用过 autoload.php，则加入了 sdk 依赖之后，不需要再引入 autoload.php 了

2. 如果使用 composer 出现网络错误，可以使用 composer 中国区的镜像源，方法是在命令行执行: composer config -g repositories.packagist composer http://packagist.phpcomposer.com

#### phar 方式

使用 phar 单文件方式，可以在以下 链接,下载已经打好包的 phar 文件，或者根据源文件自行编译，然后在你的源代码中引入 phar 文件:

    require_once '/path/to/nos-sdk-php.phar';

#### 源码方式

使用 SDK 源码，在发布页面，选择相应的版本，下载打好包的 zip 文件，解压后的根目录中包含一个 autoload.php 文件，在您的代码中引入这个文件:

    require_once '/path/to/nos-sdk/autoload.php';

### 运行 Samples

* 解压下载到的 sdk 包
* 修改samples目录中的 Config.php 文件
1. 修改 NOS_ACCESS_ID, 您从 NOS 获得的AccessKeyId

2. 修改 NOS_ACCESS_KEY, 您从 NOS 获得的AccessKeySecret

3. 修改 NOS_ENDPOINT, 您选定的 NOS 数据中心访问域名，例如: nos-eastchina1.126.net

4. 修改 NOS_TEST_BUCKET, 您要用来运行 sample 使用的 bucket，sample 程序会在这个bucket中创建一些文件,注意不能用生产环境的 bucket，以 免污染用户数据

* 到 samples 目录中执行 php RunAll.php， 也可以单个运行某个 Sample 文件