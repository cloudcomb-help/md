# 子账号权限管理

## 可授权 Redis Action 和对应资源

|            Action           |      Action 描述       |                 资源                |
|-----------------------------|------------------------|-------------------------------------|
| comb:ncr:DeleteCacheCluster | 删除集群               | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:ModifyCacheCluster | 修改集群               | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:FlushClusterData   | 清空集群数据           | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:UpdateBackupTask   | 修改集群备份时间       | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:TurnBackupTask     | 打开或关闭集群定时备份 | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:ManualBackup       | 手动备份集群           | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:RecoverBackupFile  | 恢复备份文件           | comb:ncr:*:*:*:instance/${instance} |
| comb:ncr:DataRollback       | 实例回档               | comb:ncr:*:*:*:instance/${instance} |


<span>Note:</span><div class="alertContent">${instance} 表示集群名称</div>

## 策略管理

### Redis 管理权限包括如下 Action：

* comb:ncr:DeleteCacheCluster
* comb:ncr:ModifyCacheCluster
* comb:ncr:FlushClusterData
* comb:ncr:UpdateBackupTask
* comb:ncr:TurnBackupTask
* comb:ncr:ManualBackup
* comb:ncr:RecoverBackupFile
* comb:ncr:DataRollback