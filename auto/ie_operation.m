%% 使用 Matlab 默认浏览器打开网页
% web('https://www.baidu.com/')

%% 论文投稿状态查询（失败）
% 自动登录 neurocomputing 投稿网站并查询状态，状态改变则发邮件
% ie = actxserver('internetexplorer.application');
% ie.Navigate('https://www.editorialmanager.com/neucom');
% while ~strcmp(ie.readystate,'READYSTATE_COMPLETE')
%     pause(10)
% end
% ie.visible = 1;
% 
% username_item = ie.document.body.getElementsByClassName('txt').item(0);
% username_item.value = 'zhiyong.li@hnu.edu.cn';
% 
% author_login_button_item = ie.document.body.getElementsByClassName('authorLogin').item(0);
% author_login_button_item.click


%% 控制 IE 浏览器代码
ie = actxserver('internetexplorer.application');  % 创建 COM 服务器，这里打开了360浏览器

ie.Navigate('https://www.baidu.com/');

while ~strcmp(ie.readystate,'READYSTATE_COMPLETE')
    pause(0.01)
end
ie.visible = 1;


% 在 IE 浏览器中按 F12 进入 DOM 资源管理器，然后点击选择元素按钮，
% 在页面上点击目标元素，在 DOM 资源管理器中就回跳转到元素对应的脚本上，
% 最后复制 class 名字。
% <input id="kw" name="wd" class="s_ipt" value="" maxlength="255" autocomplete="off">
% 定位搜索框
% 有时候并不止一个，可以通过get函数，获取所定位元素的个数，所有计数的index是从0开始的，需要稍加留意
SearchItem = ie.document.body.getElementsByClassName('s_ipt').item(0);
SearchItem.value = 'hello world';

% 定位按钮，并按下
ButtonItem = ie.document.body.getElementsByClassName('bg s_btn').item(0);
ButtonItem.click
