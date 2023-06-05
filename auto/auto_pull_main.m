%% 自动pull
% run command: 
% 1. enter the directory in auto_pull.m
% 2. mr auto_pull &

% 管理多个git仓库的自动同步
reps = ["C:\workspace\utils", "C:\workspace\onion", "C:\workspace\bazaar"];

clc;



while true
    for i = 1 : length(reps)
        auto_pull(reps(i));
    end
end
