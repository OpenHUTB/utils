function [ ] = kill_process(ProcessName)
% 参考：https://www.bilibili.com/read/cv13106181
% COPY:何其 2021年9月9日23:56:09

% ProcessName % 要杀死的指定进程 % 不得为空

% eg:'WINWORD.EXE' % 

% 获取所有进程信息
% tasklist /fi "imagename eq cmd.exe"
[~,cmdout] = system('tasklist');

cmdout = split(cmdout,strcat(10));
WINWORD = cmdout(contains(cmdout,ProcessName),:);
if isempty(WINWORD)  % 进程不存在则不需要杀
    return;
end

%% %获取指定进程信息
% if numel(WINWORD) > 1  % 有超过一个进程
for i = 1 : numel(WINWORD)
    cur_process = WINWORD{i};
    cur_process_info = split( cur_process,' ');

    %% % 杀死指定进程
    system(strcat('taskkill /pid' , 32 , cur_process_info{ find( ismember( cur_process_info, 'Console' ) , 1 ) - 1 } , 32 , ' /f' ) );

end
% end