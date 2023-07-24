obj_path = 'D:\work\matlab';
cur_dir = pwd;
un_crack_dir  = fullfile(cur_dir, 'un_crack');
if ~exist(un_crack_dir, 'dir'); mkdir(un_crack_dir); end

% %% The use of breadth first walk
obj_files = RangTraversal(obj_path);

num_files = numel(obj_files);  % 获取文件列表长度
disp(num_files);
p_lists = {};
cracked_lists = {};
un_crack_p_lists = {};

%%
eval(['cd ' obj_path]);
for i = 1:num_files
    cur_file_name = obj_files{i};
	if strcmp(cur_file_name(end-1 : end), '.p')
        cur_m_name = [cur_file_name(1 : end-2), '.m'];
        % 存在.p文件又存在.m文件，则添加到仓库中
        if exist(cur_m_name, 'file')
            cracked_lists = [cracked_lists; cur_file_name];
            add_cmd = ['git add ' cur_m_name];
            system(add_cmd);
        else
            % 将未破解的文件复制添加到列表
            un_crack_p_lists = [un_crack_p_lists; cur_file_name];
            % 将未破解的文件复制到未破解文件夹下
            cur_p_dir = fileparts(cur_file_name);
            dir_suffix = split(cur_p_dir, obj_path);
            dir_suffix = dir_suffix{2};
            dst_dir = fullfile(un_crack_dir, dir_suffix);
            if ~exist(dst_dir, 'dir')
                mkdir(dst_dir);
            end

            % ?如果p对应的.m文件在仓库中，则不拷贝（用于初始化仓库）
            [~, p_file_name, ext] = fileparts(cur_file_name);
            cur_p_path = fullfile(dst_dir, [p_file_name, ext]);
            if ~exist(cur_p_path, 'file')
                copyfile(cur_file_name, dst_dir);
            end

            
        end
        
	end
end

%%
eval(['cd ' cur_dir]);

dir_uniq = unique(p_lists);
writetable(cell2table(dir_uniq), 'p_lists.csv');

writetable(cell2table(unique(cracked_lists)), 'cracked_lists.csv');

writetable(cell2table(unique(un_crack_p_lists)), 'un_crack_p_lists.csv');




