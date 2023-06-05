%% 自动pull
% run command: 
% 1. enter the directory in auto_pull.m
% 2. mr auto_pull &

clc;

% C:\workspace\utils\auto
addpath(fullfile(work_dir, 'utils', 'auto'));
savepath



%% 循环遍历所有仓库
while true
    % 管理多个git仓库的自动同步
    reps = dir(work_dir);

    for i = 1 : length(reps)
        if ~strcmp(reps(i).name, '.') && ~strcmp(reps(i).name, '..')
            cur_rep = fullfile(reps(i).folder, reps(i).name);
            auto_pull(cur_rep);
        end
    end
end
