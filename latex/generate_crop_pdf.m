% 将viso保存未PDF并裁剪
% 输入：viso所在的目录，将目录下的所有viso都进行转换

% 测试：
% generate_crop_pdf(fullfile(rep_dir, 'brain', 'auditory', 'latex', 'figs'))
function generate_crop_pdf(viso_dir)
% 将viso保存为pdf，并进行裁剪

split_res = split(pwd, 'dong');
rep_dir = fullfile(split_res{1}, 'dong');

% 判断C#工程是否已经编译
c_sharp_proj = fullfile(rep_dir, 'utils', 'latex', 'viso2pdf');
exe_path = fullfile(c_sharp_proj, 'viso2pdf', 'bin', 'Debug', 'viso2pdf.exe');
if ~exist(exe_path, 'file')
    % 目录名包含空格则用双引号
    !"C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" D:\dong\utils\latex\viso2pdf\viso2pdf.sln
end

%% 拷贝pdfcrop.exe所需要的dll文件
if false
    % 需要pdfcrop.exe正在执行
    listdll_path = fullfile(matlabroot, 'software', 'ProcessExplorer', 'Listdlls.exe');
    output_path = [tempname, '.txt'];
    listdll_cmd = [listdll_path, ' pdfcrop.exe',  ' > ' output_path];
    system(listdll_cmd);
    
    % 执行文件拷贝
    dll_infos = readlines(output_path);
    for i = 1 : size(dll_infos, 1)
        cur_line = dll_infos(i);
        if startsWith(cur_line, '0x')
            split_strs = split(cur_line, ' ');
            cur_file = split_strs(end);
            if strcmp(cur_file, 'pdfcrop.exe') == 0
                copyfile(cur_file, fileparts(exe_path));
            end
        end
    end

end


%% 调用C#的可执行程序
% fullfile(matlabroot, 'latex', 'bin', 'win32', 'pdfcrop.exe')
% bug: vs能执行，命令行不能执行
% 'cd ' fileparts(exe_path), ','
% C:\texlive\2016\bin\win32\pdfcrop.exe
call_cmd = [exe_path, ' ', viso_dir, ' ', fullfile(matlabroot, 'latex', 'bin', 'win32', 'pdfcrop.exe')];
system(call_cmd);

end
