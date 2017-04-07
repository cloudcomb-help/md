# Linux 云主机自动挂载数据盘







如果此时重启云主机，可以发现刚刚挂载点已经消失。如果希望云服务器在重启或开机时能自动 mount 数据盘，必须将分区信息添加到 /etc/fstab 中。如果没有添加则云服务器重启或重新开机后都不能自动挂载数据盘。在 /etc/fstab 配置文件中可以使用三种不同的方法使文件系统可以找到 mount 点：

自动mount方法	优点	缺点
使用设备名称		假如您将云主机上的弹性云盘解挂后再次挂载（例如迁移数据时），该名称有可能会发生变化，因此有可能会导致您的自动挂载设置失效
使用文件系统 UUID		与文件系统相关，重新格式化文件系统后，UUID将会发生变化，因此有可能会导致您的自动挂载设置失效
使用弹性云盘软链接	与设备名及文件系统无关，与实际使用的云硬盘唯一对应的名称	只有弹性云盘才会有此软链接，无法感知到分区的格式化操作

## 操作步骤

### 1. 获取 uuid


### 1. 备份 /etc/fstab

 cp /etc/fstab /etc/fstab.backup



 ### 2. 写入




echo /dev/xvdb1 /mnt ext3 defaults 0 0 >> /etc/fstab



 vi /etc/fstab

使用弹性云盘软链接（推荐）
输入：device_name  mount_point  file_system_type  fs_mntops  fs_freq  fs_passno  

示例：
/dev/disk/by-id/virtio-disk-bm42ztpm-part1 /data/part1 ext3 defaults,nofail 0 1
/dev/disk/by-id/virtio-disk-bm42ztpm-part5 /data/part5 ext3 defaults,nofail 0 1
最后三个字段分别是文件系统安装选项、文件系统转储频率和启动时的文件系统检查顺序。一般使用示例中的值 (defaults,nofail 0 2)即可。有关 /etc/fstab 条目的更多信息，在命令行上输入 man fstab 即可查看。

运行 mount -a 命令，如果运行通过则说明文件正常，刚刚创建的文件系统会在下次启动时自动安装。

