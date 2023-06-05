% 将目录更改到当前打开的脚本
% 进入到temp文件夹
% cd(fileparts(mfilename('fullpath')));
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));