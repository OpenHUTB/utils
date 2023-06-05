%% 发消息到企业微信
% 将指定字符串发送到企业微信群的群机器人。
% curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=9a5d8dc2-7623-468d-b438-563e6e7920bb' \
%    -H 'Content-Type: application/json' \
%    -d '
%    {
%        "msgtype": "text",
%        "text": {
%            "content": "hello world"
%        }
%    }'


%% 方案一：Web Access using Data Import and Export API
% https://curlconverter.com/matlab
% 下面为将curl命令转换生成的matlab代码。
params = {'key' '9a5d8dc2-7623-468d-b438-563e6e7920bb'};
baseURI = 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send';
uri = [baseURI '?' char(join(join(params, '='), '&'))];
body = struct(...
    'msgtype', 'text',...
    'text', struct(...
        'content', 'hello webchat'...
    )...
);
options = weboptions('MediaType', 'application/json');
response = webwrite(uri, body, options);

%% 方案二：HTTP Interface
% import matlab.net.*
% import matlab.net.http.*
% import matlab.net.http.io.*
% 
% params = {'key' '9a5d8dc2-7623-468d-b438-563e6e7920bb'};
% header = HeaderField('Content-Type', 'application/json');
% uri = URI('https://qyapi.weixin.qq.com/cgi-bin/webhook/send', QueryParameter(params'));
% body = JSONProvider(struct(...
%     'msgtype', 'text',...
%     'text', struct(...
%         'content', 'hello world'...
%     )...
% ));
% response = RequestMessage('post', header, body).send(uri.EncodedURI);