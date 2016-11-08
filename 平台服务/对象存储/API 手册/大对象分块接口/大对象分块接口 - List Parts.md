# 大对象分块接口
## List Parts

### 描述

List Parts 命令可以罗列出指定 Upload ID 所属的所有已经上传成功 Part。

### 语法

    GET /${ObjectKey}?uploadId=${id}&max-parts=${limit}&part-number-marker=${start} HTTP/1.1
    HOST: ${BucketName}.${endpoint}
    Date: ${date}
    Authorization: ${signature}

### 请求参数

|        参数        |                                  描述                                  | 是否必须 |
|--------------------|------------------------------------------------------------------------|----------|
| max-parts          | 响应中的limit个数<br>类型：整型<br>默认值：1000 取值：[0-1000]         | No       |
| part-number-marker | 分块号的界限，只有更大的分块号会被列出来。<br>类型：字符串<br>默认：无 | No       |
| uploadId           | 分块上传操作的ID<br>类型：字符串<br>默认：无                           | Yes      |

### 响应元素

|         元素         |                                                                            描述                                                                           |
|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| ListPartsResult      | 列出已上传块信息<br>类型：容器<br>子节点：Bucket、Key、UploadId、Owner、StorageClass、PartNumberMarker、NextPartNumberMarker、MaxParts, IsTruncated、Part |
| Bucket               | 桶的名称<br>类型: String<br>父节点: ListPartsResult                                                                                                       |
| Key                  | 对象的Key<br>类型: String<br>父节点: ListPartsResult                                                                                                      |
| UploadId             | 分块上传操作的ID<br>类型: String<br>父节点: ListPartsResult                                                                                               |
| ID                   | 对象拥有者的ID<br>类型: String<br>父节点: Owner                                                                                                           |
| DisplayName          | 对象的拥有者<br>类型: String<br>父节点: Owner                                                                                                             |
| Owner                | 桶拥有者的信息<br>子节点：ID, DisplayName<br>类型: 容器<br>父节点: ListPartsResult                                                                        |
| StorageClass         | 存储级别<br>类型: String<br>父节点: ListPartsResult                                                                                                       |
| PartNumberMarker     | 上次 List 操作后的 Part number<br>类型: Integer<br>父节点: ListPartsResult                                                                                |
| NextPartNumberMarker | 作为后续 List 操作的 part-number-marker<br>类型: Integer<br>父节点: ListPartsResult                                                                       |
| MaxParts             | 响应允许返回的的最大 part 数目<br>类型: Integer<br>父节点: ListPartsResult                                                                                |
| IsTruncated          | 是否截断，如果因为设置了 limit 导致不是所有的数据集都返回了，则该值设置为 true<br>类型: Boolean<br>父节点: ListPartsResult                                |
| Part                 | 列出相关 part 信息<br>子节点:PartNumber, LastModified, ETag, Size<br>类型: String<br>父节点: ListPartsResult                                                         |
| PartNumber           | 识别特定 part 的一串数字<br>类型: Integer<br>父节点: Part                                                                                                         |
| LastModified         | 该 part 上传的时间<br>类型: Date<br>父节点: Part                                                                                                                  |
| ETag                 | 当该 part 被上传时返回<br>类型: String<br>父节点: Part                                                                                                            |
| Size                 | 已上传的 part 数据的大小<br>类型: Integer<br>父节点: Part                                                                                                       |

### 特殊错误码

|    错误码    |  Http状态码   |                                           描述                                          |
|--------------|---------------|-----------------------------------------------------------------------------------------|
| NoSuchUpload | 404 Not Found | 对应的分块上传不存在，可能原因：uploadId 非法、已经执行了 abort、已经执行了 complete 等 |

### 示例

Request

    GET /movie.avi?uploadId=23r54i252358235-32523f23 HTTP/1.1
    HOST: filestation.nos-eastchina1.126.net
    Date: Mon, 1 May 2012 20:34:56 GMT
    Authorization: NOS I_AM_ACCESS_ID:I_AM_SIGNATURE

Response

    HTTP/1.1 200 OK
    x-nos-request-id: 17b21e42ac11000001390ab891440240
    Date: Mon, 1 Feb 2012 20:34:56 GMT
    Content-Length: 985
    Connection: close
    Server: NOS
    
    <?xml version="1.0" encoding="UTF-8"?>
    <ListPartsResult>
        <Bucket>example-Bucket</Bucket>
        <Key>example-Object</Key>
    <UploadId>23r54i252358235332523f23 </UploadId>
        <Owner>
                <ID>75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a</ID>
                <DisplayName>someName</DisplayName>
        </Owner>
        <StorageClass>STANDARD</StorageClass>
        <PartNumberMarker>1</PartNumberMarker>
        <NextPartNumberMarker>3</NextPartNumberMarker>
        <MaxParts>2</MaxParts>
        <IsTruncated>true</IsTruncated>
        <Part>
                <PartNumber>2</PartNumber>
                <LastModified>2010-11-10T20:48:34.000Z</LastModified>
                <ETag>"7778aef83f66abc1fa1e8477f296d394"</ETag>
                <Size>10485760</Size>
        </Part>
        <Part>
                <PartNumber>3</PartNumber>
                <LastModified>2010-11-10T20:48:33.000Z</LastModified>
                <ETag>"aaaa18db4cc2f85cedef654fccc4a4x8"</ETag>
                <Size>10485760</Size>
        </Part>
    </ListPartsResult>

### 细节描述

1. 如果 Bucket 不存在，返回 404 no content 错误。错误码：NoSuchBucket。
2. 只有 Bucket 的拥有者才能操作大对象分块接口。非 Bucket 拥有者执行此类操作将返回 403 Forbidden 错误。错误码：AccessDenied。
3. 如果执行 List Parts 时，UploadId 对应的 Object 名和 Bucket 名不匹配，返回：400 Bad Request错误。 错误码：InvalidArgument。
4. 如果执行 List Parts 时，UploadId 已经被 Abort，或者 UploadId 本就不存在，返回：404 Not Found错误。错误码：NoSuchUpload。
5. 通过 max-parts 和 part-number-marker 能够遍历 UploadId 对应的所有上传块。
6. 返回结果按照 part 值从小到大排列。
大对象可以调用分块上传接口来提高上传成功率，该接口支持断点续传和并发上传。上传数 据分块最小 16 k，最大 100 M（最后一块除外）。

