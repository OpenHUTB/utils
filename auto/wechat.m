% 
% 使用 python 获取文件传输助手中的消息
py_info = pyversion; % pyversion  % 查看python环境的信息
if isempty(py_info)
    pyversion(fullfile(matlabroot, 'python', 'python.exe'));
end

import py.webchat.*
messages = get_webchat_info();
messages = cell(messages);
for i = 1 : length(messages)
    cur_message = string(messages{i});
    flag_str = '，笔记';
    if endsWith(cur_message, flag_str)
        inserted_message = extractBefore(cur_message, flag_str);
        insert_line_after(fullfile(fileparts(matlabroot), 'dong', 'readme.md'), '### TODO', inserted_message);
    end

end


%% 在文件f中，指定标志位的后一行插入字符串str
function insert_line_after(f, flag, str)
end