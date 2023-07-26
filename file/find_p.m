% 测试：find_p('D:\software\Prescan_2021.1')
function find_p(varargin)

if numel(varargin) < 1 || ~exist(varargin{1}, 'dir')
    obj_path = matlabroot;
else
    obj_path = varargin{1};
end

% %% The use of breadth first walk
obj_files = RangTraversal(obj_path);

num_files = numel(obj_files);  % 获取文件列表长度
disp(num_files);
dir_lists = {};

for i = 1:num_files
    cur_file_name = obj_files{i};
	if strcmp(cur_file_name(end-1 : end), '.p')
		% disp(cur_file_name);
        
        % 获得当前文件的目录，并保存到集合当中
        cur_p_dir = fileparts(cur_file_name);
        dir_lists = [dir_lists; cur_p_dir];
        
		i = i+1;
	end
end

dir_uniq = unique(dir_lists);
writetable(cell2table(dir_uniq), 'dir_uniq.csv');

end