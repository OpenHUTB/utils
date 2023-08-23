function mlx2html(mlx_path)
% 将输入的mlx文件导出成同一文件夹下的html文件，并部署到matlab帮助文档对应的目录下

% 生成的网页文件的路径
[cur_mlx_folder, cur_mlx_name, ~] = fileparts(mlx_path);
% 保存网页的文件名
dst_file_name = [cur_mlx_name, '.html'];
dst_html_path = fullfile(cur_mlx_folder, ...
    dst_file_name);
% 导出网页格式到和.mlx相同的文件夹
export(mlx_path, dst_html_path);

% 将翻译结果部署到软件中
start_pos = strfind(cur_mlx_folder, 'roadrunner');
matlab_html_dir = fullfile(matlabroot, "help", ...
    cur_mlx_folder(start_pos:end));
copyfile(dst_html_path, matlab_html_dir);

fprintf('Generate: %s\n', dst_html_path);

end