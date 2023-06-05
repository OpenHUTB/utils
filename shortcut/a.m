% 查看当前工程修改的文件，按回车或者y进行推送，按n或者其他字符则取消
% 查看状态：a s
% 拉取代码：a u

% 判断是否为git pull
function a(varargin)
if length(varargin) == 1
    if varargin{1} == 'u'
        !git pull
        disp("pull finish, exit.");
        return
    elseif varargin{1} == 's'
        !git status
        disp('git status finish.');
        return
    end
elseif isempty(varargin)
    !git status
    is_continue = input('continue?[y/n]', 's');  % 's'表示返回文本
    if isempty(is_continue)  % 如果输入为空，此代码将为 is_continue 指定默认值 'y'
        is_continue = 'y';
    end
    if is_continue == 'n'
        disp("cancel");
        return;
    elseif is_continue == 'y'
        % 提交的信息需要双引号，单引号报错：error: pathspec 'commit'' did not match any file(s) known to git
        % 命令行参数由空格分隔。如果你想提供一个带有空格的参数，你应该引用它。
        !git add .
        !git commit -m "auto commit"
        !git push
        disp("add and push all");
        disp("add and push finish.");
    else
        error("input error, please input y/n/(enter)");
    end
end

end
