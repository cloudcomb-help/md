# Java SDK 手册 - 安装

## 安装

### Java环境
JDK 6 及以上版本

#### Maven项目中使用
在 Maven 工程中使用 NOS Java SDK 只需在 pom.xml 中加入相应依赖即可

    <dependency>
      <groupId>com.netease.cloud</groupId>
      <artifactId>nos-sdk-java-publiccloud</artifactId>
      <version>0.0.1</version>
    </dependency>

#### 工程中直接引用jar

1. 下载包含 Java SDK 及其依赖的开发包： nos-sdk-java-publiccloud-0.0.1.tar.gz；
2. 解压该开发包；
3. 将解压后文件夹下 lib 文件夹中的 nos-sdk-java-publiccloud-0.0.1.jar 以及 third-party 文件夹下的所有 jar 文件拷贝到你的项目中；
4. 在 Eclipse 中选择你的工程，右击 -> Properties -> Java Build Path -> Add JARs；
5. 选中你在第三步拷贝的所有 JAR 文件；