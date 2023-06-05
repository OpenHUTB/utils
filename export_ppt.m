

data_dir = 'D:\dong\brain\visual\nsfc\images\tmp';
strFileName = fullfile(data_dir, 'research.pptx');
strFileNameOut = fullfile(data_dir, 'research.pdf');


% 将 PPT 文件转换为 PDF 格式并关闭 PPT 文件。仅在安装了 Microsoft Office 的 PC 上运行此命令。
pptview(strFileName, 'converttopdf');

% pptview(strFileName)