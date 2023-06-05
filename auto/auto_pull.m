%% 自动pull
function auto_pull(rep)
    cur_dir = pwd;
    if exist(rep, 'dir')
        eval(strcat("cd ", rep));
    end
    % 当远程有更新 且 本地没有修改 时，则执行 pull
    if isunix  % 将目标支持的语言设置为英文
        % show support language: echo $LANG
        % change to Chinese: LANG=zh_CN.UTF-8
        [remote_status, remote_info] = system('LANG=en_US; git remote show origin');
    else
        [remote_status, remote_info] = system('git remote show origin');
    end

    remote_change = contains(remote_info, 'local out of date');


    [local_status, local_info] = system('git status');
    local_no_change = contains(local_info, 'no changes added to commit');

    if remote_status == 0 && local_status ==  0 && remote_change == 1 && local_no_change == 0
        [pull_status, pull_info] = system('git pull');
        disp(pull_info);
    end
    
    eval(strcat("cd ", cur_dir));
    pause(1);
end
