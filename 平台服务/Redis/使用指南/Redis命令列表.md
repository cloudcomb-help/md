# Redis命令列表

### **单节点实例**

#### 支持命令列表

|**编号**| **Keys（键）** | **String（字符串）** | **Hash（哈希表）** | **List（列表）**|**Set（集合）**|
|--------|----------------|----------------------|--------------------|-----------------|---------------|
|   1    |DEL             |APPEND                |HDEL                |BLPOP            |SADD           |
|   2    |DUMP            |BITCOUNT              |HEXISTS             |BRPOP            |SCARD          |
|   3    |EXISTS          |BITOP                 |HGET                |BRPOPLPUSH       |SDIFF          |
|   4    |EXPIRE          |BITPOS                |HGETALL             |LINDEX           |SDIFFSTORE     |
|   5    |EXPIREAT        |DECR                  |HINCRBY             |LINSERT          |SINTER         |
|   6    |MOVE            |DECRBY                |HINCRBYFLOAT        |LLEN             |SINTERSTORE    |
|   7    |OBJECT          |GET                   |HKEYS               |LPOP             |SISMEMBER      |
|   8    |PERSIST         |GETBIT                |HLEN                |LPUSH            |SMEMBERS       |
|   9    |PEXPIRE         |GETRANGE              |HMGET               |LPUSHX           |SMOVE          |
|   10   |PEXPIREAT       |GETSET                |HMSET               |LRANGE           |SPOP           |
|   11   |PTTL            |INCR                  |HSET                |LREM             |SRANDMEMBER    |
|   12   |RANDOMKEY       |INCRBY                |HSETNX              |LSET             |SREM           |
|   13   |RENAME          |INCRBYFLOAT           |HVALS               |LTRIM            |SUNION         |
|   14   |RENAMENX        |MGET                  |HSCAN               |RPOP             |SUNIONSTORE    |
|   15   |RESTORE         |MSET                  |                    |RPOPLPUSH        |SSCAN          |
|   16   |SORT            |MSETNX                |                    |RPUSH            |               |
|   17   |TTL             |PSETEX                |                    |RPUSHX           |               |
|   18   |TYPE            |SET                   |                    |                 |               |
|   19   |SCAN            |SETBIT                |                    |                 |               |
|   20   |                |SETEX                 |                    |                 |               |
|   21   |                |SETNX                 |                    |                 |               |
|   22   |                |SETRANGE              |                    |                 |               |
|   23   |                |STRLEN                |                    |                 |               |
|   24   |                |SUBSTR                |                    |                 |               |

|**编号**|**SortedSet（有序集合）**|**HyperLogLog**|**Pub/Sub（发布/订阅）**|**Transaction**|
|--------|-------------------------|---------------|------------------------|---------------|
|   1    |ZADD                     |PFADD          |PSUBSCRIBE              |DISCARD        |
|   2    |ZCARD                    |PFCOUNT        |PUBLISH                 |EXEC           |
|   3    |ZCOUNT                   |PFMERGE        |PUBSUB                  |MULTI          |
|   4    |ZINCRBY                  |               |PUNSUBSCRIBE            |UNWATCH        |
|   5    |ZRANGE                   |               |SUBSCRIBE               |WATCH          |
|   6    |ZRANGEBYSCORE            |               |UNSUBSCRIBE             |               |
|   7    |ZRANK                    |               |                        |               |
|   8    |ZREM                     |               |                        |               |
|   9    |ZREMRANGEBYRANK          |               |                        |               |
|   10   |ZREMRANGEBYSCORE         |               |                        |               |
|   11   |ZREVRANGE                |               |                        |               |
|   12   |ZREVRANGEBYSCORE         |               |                        |               |
|   13   |ZREVRANK                 |               |                        |               |
|   14   |ZSCORE                   |               |                        |               |
|   15   |ZUNIONSTORE              |               |                        |               |
|   16   |ZINTERSTORE	           |               |                        |               |
|   17   |ZSCAN                    |               |                        |               |
|   18   |ZRANGEBYLEX              |               |                        |               |
|   19   |ZLEXCOUNT                |               |                        |               |
|   20   |ZREMRANGEBYLEX           |               |                        |               |
|   21   |ZREVRANGEBYLEX           |               |                        |               |

|**编号**|**Script(脚本)**|**Connection（连接）**|**Server（服务器）**|
|--------|----------------|----------------------|--------------------|
|   1    |                |        AUTH          |       DBSIZE       |
|   2    |                |        ECHO          |       INFO         |
|   3    |                |        PING          |       ROLE         |
|   4    |                |        SELECT        |       TIME         |
|   5    |                |        QUIT          |                    |

#### 不支持命令列表

|**编号**|**Keys（键）**|**HyperLogLog**|**Script（脚本）**|**Server（服务器）**|
|--------|--------------|---------------|------------------|--------------------|
|   1    |     KEYS     |   PFSELFTEST  |       EVAL       |    BGREWRITEAOF    |
|   2    |    MIGRATE   |     PFDEBUG   |      EVALSHA     |       BGSAVE       |
|   3    |              |               |   SCRIPT EXISTS  |    CLIENT GETNAME  |
|   4    |              |               |    SCRIPT FLUSH  |      CLIENT KILL   |
|   5    |              |               |     SCRIPT KILL  |      CLIENT LIST   |
|   6    |              |               |     SCRIPT LOAD  |      CLIENT PAUSE  |
|   7    |              |               |                  |     CLIENT SETNAME |
|   8    |              |               |                  |        COMMAND     |
|   9    |              |               |                  |     COMMAND COUNT  |
|   10   |              |               |                  |    COMMAND GETKEYS |
|   11   |              |               |                  |     COMMAND INFO   |
|   12   |              |               |                  |      CONFIG GET    |
|   13   |              |               |                  |   CONFIG RESETSTAT |
|   14   |              |               |                  |   CONFIG REWRITE   |
|   15   |              |               |                  |      CONFIG SET    |
|   16   |              |               |                  |     DEBUG OBJECT   |
|   17   |              |               |                  |    DEBUG SEGFAULT  |
|   18   |              |               |                  |        FLUSHALL    |
|   19   |              |               |                  |        FLUSHDB     |
|   20   |              |               |                  |        LASTSAVE    |
|   21   |              |               |                  |        MONITOR     |
|   22   |              |               |                  |        SAVE        |
|   23   |              |               |                  |      SHUTDOWN      |
|   24   |              |               |                  |      SLAVEOF       |
|   25   |              |               |                  |      SLOWLOG       |
|   26   |              |               |                  |       SYNC         |
|   27   |              |               |                  |      LATENCY       |

### **分布式实例**（暂未开放）

#### 支持命令列表

|**编号**|**Keys（键）**|**String（字符串）**|**Hash（哈希表）**|**List（列表）**|**Set（集合）**|
|--------|--------------|--------------------|------------------|----------------|---------------|
|   1    |      DEL     |      APPEND        |        HDEL      |     LINDEX     |     SADD      |
|   2    |     DUMP     |     BITCOUNT       |      HEXISTS     |     LINSERT    |     SCARD     |
|   3    |    EXISTS    |       DECR         |        HGET      |      LLEN      |     SDIFF     |
|   4    |    EXPIRE    |      DECRBY        |      HGETALL     |      LPOP      |   SDIFFSTORE  |
|   5    |    EXPIREAT  |        GET         |      HINCRBY     |      LPUSH     |     SINTER    |
|   6    |    PERSIST   |       GETBIT       |    HINCRBYFLOAT  |      LPUSHX    |   SINTERSTORE |
|   7    |    PEXPIRE   |      GETRANGE      |      HKEYS       |      LRANGE    |   SISMEMBER   |
|   8    |    PEXPIREAT |      GETSET        |      HLEN        |       LREM     |    SMEMBERS   |
|   9    |     PTTL     |      INCR          |      HMGET       |       LSET     |     SMOVE     |
|   10   |    RESTORE   |     INCRBY         |      HMSET       |       LTRIM    |     SPOP      |
|   11   |     SORT     |    INCRBYFLOAT     |      HSET        |       RPOP     |   SRANDMEMBER |
|   12   |     TTL      |      MGET          |     HSETNX       |      RPOPLPUSH |     SREM      |
|   13   |    TYPE      |      MSET          |     HVALS        |       RPUSH    |    SUNION     |
|   14   |              |     PSETEX         |     HSCAN        |       RPUSHX   |   SUNIONSTORE |
|   15   |              |      SET           |                  |                |    SSCAN      |
|   16   |    SETBIT    |                    |                  |                |               |
|   17   |    SETEX     |                    |                  |                |               |
|   18   |    SETNX     |                    |                  |                |               |
|   19   |   SETRANGE   |                    |                  |                |               |
|   20   |    STRLEN    |                    |                  |                |               |
|   21   |    SUBSTR    |                    |                  |                |               |

|**编号**|**SortedSet（有序集合）**|**HyperLogLog**|**Script（脚本）**|**Connection（连接）**|**Server（服务器）**|
|--------|-------------------------|---------------|------------------|----------------------|--------------------|
|   1    |ZADD                     |PFADD          |EVAL              |AUTH                  |TIME                |
|   2    |ZCARD                    |PFCOUNT        |EVALSHA           |ECHO                  |                    |
|   3    |ZCOUNT                   |PFMERGE        |                  |PING                  |                    |
|   4    |ZINCRBY                  |               |                  |SELECT                |                    |
|   5    |ZRANGE                   |               |                  |QUIT                  |                    |
|   6    |ZRANGEBYSCORE            |               |                  |                      |                    |
|   7    |ZRANK                    |               |                  |                      |                    |
|   8    |ZREM                     |               |                  |                      |                    |
|   10   |ZREMRANGEBYSCORE         |               |                  |                      |                    |
|   11   |ZREVRANGE                |               |                  |                      |                    |
|   12   |ZREVRANGEBYSCORE         |               |                  |                      |                    |
|   13   |ZREVRANK                 |               |                  |                      |                    |
|   14   |ZSCORE                   |               |                  |                      |                    |       
|   15   |ZUNIONSTORE              |               |                  |                      |                    |
|   16   |ZINTERSTORE              |               |                  |                      |                    |
|   17   |ZSCAN                    |               |                  |                      |                    |
|   18   |ZRANGEBYLEX              |               |                  |                      |                    |
|   19   |ZLEXCOUNT                |               |                  |                      |                    |
|   20   |ZREMRANGEBYLEX           |               |                  |                      |                    |
|   21   |ZREVRANGEBYLEX           |               |                  |                      |                    |

### 不支持命令列表

|**编号**|**Keys（键）**|**String（字符串）**|**List（列表）**|**HyperLogLog**|**Pub/Sub（发布/订阅）**|
|--------|--------------|--------------------|----------------|---------------|------------------------|
|   1    |KEYS          |BITOP               |BLPOP           |PFSELFTEST     |PSUBSCRIBE              |
|   2    |MIGRATE       |MSETNX              |BRPOP           |PFDEBUG        |PUBLISH                 |
|   3    |MOVE          |BITPOS              |BRPOPLPUSH      |               |PUBSUB                  |
|   4    |OBJECT        |                    |                |               |PUNSUBSCRIBE            |
|   5    |RANDOMKEY     |                    |                |               |SUBSCRIBE               |
|   6    |RENAME        |                    |                |               |UNSUBSCRIBE             |
|   7    |RENAMENX      |                    |                |               |                        |
|   8    |SCAN          |                    |                |               |                        |

|**编号**|**Transaction（事务）**|**Script（脚本）**|**Server（服务器）**|
|--------|-----------------------|------------------|--------------------|
|   1    |DISCARD                |SCRIPT EXISTS     |BGREWRITEAOF        |
|   2    |EXEC                   |SCRIPT FLUSH      |BGSAVE              |
|   3    |MULTI                  |SCRIPT KILL       |CLIENT GETNAME      |
|   4    |UNWATCH                |SCRIPT LOAD       |CLIENT KILL         |
|   5    |WATCH                  |                  |CLIENT LIST         |
|   6    |                       |                  |CLIENT PAUSE        |
|   7    |                       |                  |CLIENT SETNAME      |
|   8    |                       |                  |COMMAND             |
|   9    |                       |                  |COMMAND COUNT       |
|   10   |                       |                  |COMMAND GETKEYS     |
|   11   |                       |                  |COMMAND INFO        |
|   12   |                       |                  |CONFIG GET          |
|   13   |                       |                  |CONFIG RESETSTAT    |
|   14   |                       |                  |CONFIG REWRITE      |
|   15   |                       |                  |CONFIG SET          |
|   16   |                       |                  |DBSIZE              |
|   17   |                       |                  |DEBUG OBJECT        |
|   18   |                       |                  |DEBUG SEGFAULT      |
|   19   |                       |                  |FLUSHALL            |
|   20   |                       |                  |FLUSHDB             |
|   21   |                       |                  |INFO                |
|   22   |                       |                  |LASTSAVE            |
|   23   |                       |                  |MONITOR             |
|   24   |                       |                  |PSYNC               |
|   25   |                       |                  |ROLE                |
|   26   |                       |                  |SAVE                |
|   27   |                       |                  |SHUTDOWN            |
|   28   |                       |                  |SLAVEOF             |
|   29   |                       |                  |SLOWLOG             |
|   30   |                       |                  |SYNC                |
|   31   |                       |                  |REPLCONF            |
|   32   |                       |                  |LATENCY             |



















































