# 云主机 API

## 获取自定义镜像

### 请求 URL

    GET https://open.c.163.com/api/v1/vm/privateimages?pageSize={pageSize}&pageNum={pageNum}&keyword={keyword}&osType={osType}

### 请求示例
    GET /api/v1/vm/privateimages?pageSize=4&pageNum=1&keyword=os&Type=linux HTTP/1.1
    Authorization: Token 48e6b1bdb5fb4a28a680a977dffb3c30

### 请求参数

|   参数   |   类型  | 是否必填 |                     描述                     | 示例值 |
|----------|---------|----------|----------------------------------------------|--------|
| pageSize | Integer | 否       | 请求分页大小                                 | 4      |
| pageNum  | Integer | 否       | 请求分页页号                                 | 1      |
| keyword  | String  | 否       | 模糊搜索关键字，只支持数字和大小写字母的组合 | os     |
| osType   | String  | 否       | 镜像的操作系统类型，可选 linux/windows       | linux  |


<span>Note:</span><div class="alertContent">pageSize 与 pageNum 同时为空时，默认 pageSize=20&pageNum=1；
否则两者要同时不为空才有效。</div>


### 响应示例

```json
{
  "total_page": 1, #总共可以分页的页数
  "images": [
    {
      "imageName": "Centos 6.5 64位", #镜像名称
      "imageId": "19b79122-d407-445f-8619-0ee5aa6c00bb", #镜像id
      "OSType": "linux", #镜像操作系统类型
      "OSVersion": "6.5", #镜像操作系统版本
      "status": "ACTIVE", #镜像状态
      "category": 0, #镜像分类类别
      "distribution": "centos", #镜像发行商
      "id": 206, #镜像序列号
      "createTime": 1490596535000, #镜像创建时间
      "updateTime": 1490856599000  #镜像更新时间
    }
  ],
  "total_count": 1 #镜像总数
}
```


### 响应参数

|     参数     |    类型   |        描述        |                示例值                |
|--------------|-----------|--------------------|--------------------------------------|
| total_page   | Integer   | 总共可以分页的页数 | 1                                    |
| images       | JSONArray | 镜像信息列表       | 详见示例                             |
| imageName    | String    | 镜像名称           | Centos 6.5 64位                      |
| imageId      | String    | 镜像 id            | 19b79122-d407-445f-8619-0ee5aa6c00bb |
| OSType       | String    | 镜像操作系统类型   | linux                                |
| OSVersion    | String    | 像操作系统版本     | 6.5                                  |
| status       | String    | 镜像状态           | ACTIVE                               |
| category     | Integer   | 镜像分类类别       | 0                                    |
| distribution | String    | 镜像发行商         | centos                               |
| id           | Integer   | 镜像序列号         | 206                                  |
| createTime   | Long      | 镜像创建时间       | 1490596535000                        |
| updateTime   | Long      | 镜像更新时间       | 1490856599000                        |
| total_count  | Integer   | 镜像总数           | 1                                    |









