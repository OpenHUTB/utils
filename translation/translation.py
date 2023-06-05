
def baidu_translate(q):
    #百度通用翻译API,不包含词典、tts语音合成等资源，如有相关需求请联系translate_api@baidu.com
    # 管理平台：http://api.fanyi.baidu.com/api/trans/product/desktop
    # coding=utf-8

    import http.client
    import hashlib
    import urllib
    import random
    import json

    appid = '20230209001555217'  # 填写你的appid
    secretKey = 'J_092PvdstIT4U64w3n2'  # 填写你的密钥


    httpClient = None
    myurl = '/api/trans/vip/translate'

    fromLang = 'auto'   #原文语种
    toLang = 'zh'   #译文语种
    salt = random.randint(32768, 65536)
    # q= 'apple'
    sign = appid + q + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()
    myurl = myurl + '?appid=' + appid + '&q=' + urllib.parse.quote(q) + '&from=' + fromLang + '&to=' + toLang + '&salt=' + str(
    salt) + '&sign=' + sign

    try:
        httpClient = http.client.HTTPConnection('api.fanyi.baidu.com')
        httpClient.request('GET', myurl)

        # response是HTTPResponse对象
        response = httpClient.getresponse()
        result_all = response.read().decode("utf-8")
        result = json.loads(result_all)

        return result['trans_result'][0]['dst']

    except Exception as e:
        print (e)
    finally:
        if httpClient:
            httpClient.close()


if __name__ == "__main__":
    res = baidu_translate('hello world')
    print(res)
