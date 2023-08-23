% 将该工程下的所有实时代码文件格式（.mlx）文件转成.html文件
function deploy(varargin)
% 默认只导出修改过的文件，deploy('all')则导出所有的文件
cur_dir = pwd;

% 得到当前目录下的所有.mlx文件
all_dir = genpath(cur_dir);
all_dirs = split(all_dir, ';');

if nargin == 0
    % 仅仅查看被修改的文件：git diff HEAD --name-only
    % 这个命令没有显示新add的文件：git diff --name-only
    [~, modified_list] = system('git diff HEAD --name-only');
    modified_files = split(modified_list, newline);
    for i = 1 : numel(modified_files)-1
        cur_file = modified_files{i};
        if endsWith(cur_file, '.mlx')
            cur_mlx_path = fullfile(cur_dir, cur_file);
            if exist(cur_mlx_path, 'file')
                mlx2html(cur_mlx_path);
            end
        end
    end
else
    %% 将.mlx文件导出为网页文件
    % 获取所有的目录
    for i = 1 : numel(all_dirs)-1
        cur_mlx_dir = all_dirs{i};
        % 获取当前文件夹的所有.mlx文件
        cur_all_mlx = dir(fullfile(cur_mlx_dir, '*.mlx'));
        for j = 1 : numel(cur_all_mlx)
            cur_mlx_struct = cur_all_mlx(j);
            cur_mlx_name = cur_mlx_struct.name;
            % 原始.mlx文件的路径
            cur_mlx_path = fullfile(cur_mlx_struct.folder, cur_mlx_name);
            mlx2html(cur_mlx_path);
        end
    end
end

end



