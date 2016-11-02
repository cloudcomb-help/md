# GIF合成

### **描述**

该接口用于实时将同一 bucket 下 多张图片合并成一张 gif

### **接口**

    GET /${ObjectKey}?gifGen 
    HTTP/1.1

其中 ObjectKey 为 gif 参数说明文件，内容如下：

   

     { 
            "Width": 1000, 
    	"Height": 2000, 
            "FrameRate": 10, 
    	"Delay": 1, 
    	"Pics": [ 
    	    "object_key_0", 
    	    "object_key_1", 
    	    "object_key_2", 
    	    "object_key_3", 
    	    "object_key_4", 
    	    "object_key_5", 
    	    "object_key_6", 
    	    "object_key_7" 
    	] 
        }

### **参数**

| **参数** |**类型**|	                         **说明**                             |**是否必须**|
|----------|--------|-----------------------------------------------------------------|------------|
|Width	   |int	    |若宽和高其中一个为0，则按照非零边对第一张图片进行等比缩略等到另一边,若高和宽都为0，则按照第一张图片的尺寸来缩略                                                                |	否         |
|Height	   |int	    |若宽和高其中一个为0，则按照非零边对第一张图片进行等比缩略等到另一边,若高和宽都为0，则按照第一张图片的尺寸来缩略	                                                              | 否         |
|FrameRate |int	    |整数格式，如”1”（每秒播一张），最多不得超过100（每1秒播100张） ,默认值为”1”。不得超过100|	                                                                                        否         |
|Delay	   |int	    |取值范围-1,65535，-1表示采用图片播放间隔时间作为循环间隔时间。默认值为-1	|否|
|Pics	   |String array|需要合成的图片对象名列表，必须在同一bucket下，依次顺序排列，至少一张,最多不得超过50张	|否|
注意：

输入图片最少1张，最多50张

所有输入图片的实际格式必须一致，即都为jpg文件、或都为png文件

如果不满足上述条件，GIF合并会失败

#### **示例**

效果图：http://img-sample.nos-eastchina1.126.net/gif.json?gifGen

![](http://img-sample.nos-eastchina1.126.net/gif.json?gifGen)