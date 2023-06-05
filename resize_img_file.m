% 调整图片文件的大小
% 将一个目录下的所有图片文件都调整到制定大小范围
% 默认只指定大小的上限（单位为字节数），比如2*1024*1024

% 输出文件名为：原文件名_2M.jpg

% 函数测试代码
% resize_img_file('D:\BaiduNetdiskDownload', 2*1024*1024)

function resize_img_file(img_dir, upper_size)
dir_infos = dir(img_dir);
for i = 1 : length(dir_infos)
    cur_info = dir_infos(i);
    if ~cur_info.isdir
        [~, file_name, point_ext] = fileparts(cur_info.name);
        ext = point_ext(2:end);
        format_struct = imformats(ext); % 确定与 ext 文件扩展名关联的文件格式是否存在于图像文件格式注册表中
        if ~isempty(format_struct) % format_struct 是一个非空结构体，因此 BMP 文件格式位于注册表中
            img = imread(fullfile(cur_info.folder, cur_info.name));
            for q = 99 : -1 : 1  % 图像质量从高遍历到低，直到满足大小限制的要求
                output_file_name = [file_name '_' mat2str(upper_size) '.jpg'];
                imwrite(img, fullfile(cur_info.folder, output_file_name), 'Quality', q);
                output_info = dir(fullfile(cur_info.folder, output_file_name));
                if output_info.bytes < upper_size
                    break
                end
            end
        end
    end
end

end

