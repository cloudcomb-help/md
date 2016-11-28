# PHP SDK 手册
## 授权访问

通过生成签名 URL 的形式提供给用户一个临时的访问 URL。在生成 URL 时，您可以指定 URL 过期的时间，从而限制用户长时间访问。

生成私有下载链接 生成 GetObject 的签名 url 示例如下:

    <?php
    /**
     * 生成 GetObject 的签名 url,主要用于私有权限下的读访问控制
     *
     * @param $nosClient NosClient NosClient 实例
     * @param $bucket string bucket 名称
     * @return null
     */
    function getSignedUrlForGettingObject($nosClient, $bucket)
    {
        $object = "test/test-signature-test-upload-and-download.txt";
        $timeout = 3600; // URL 的有效期是 3600 秒
        try{
            $signedUrl = $nosClient->signUrl($bucket, $object, $timeout);
        } catch(NosException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": signedUrl: " . $signedUrl. "\n");
        /**
         * 可以类似的代码来访问签名的 URL，也可以输入到浏览器中去访问
         */
        $request = new RequestCore($signedUrl);
        $request->set_method('GET');
        $request->send_request();
        $res = new ResponseCore($request->get_response_header(), $request->get_response_body(), $request->get_response_code());
        if ($res->isOK()) {
            print(__FUNCTION__ . ": OK" . "\n");
        } else {
            print(__FUNCTION__ . ": FAILED" . "\n");
        };
    }

