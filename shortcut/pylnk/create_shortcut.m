%% 调用pylink3.py创建快捷方式
%% 创建常用目录的快捷方式
% py_module_path = fullfile(rep_dir, 'utils', 'shortcut', 'pylnk', 'pylnk3.py');

work_dir = 'D:\work';  % 工作路径不在C盘就在D盘下的BaiduSyncdisk目录，所有的文件都在这个目录下
if ~exist(work_dir, 'dir')
    work_dir = 'D:\BaiduSyncdisk';
end

workspace_dir = 'D:\work';
if ~exist(workspace_dir, 'dir')
    workspace_dir = 'C:\workspace';
end

import py.pylnk3.*

% 这里新建的快捷方式要是dong\utils\shortcut目录下的.m快捷方式保持一致
shortcut_dir = fullfile(work_dir, 'shortcut');

% 添加环境变量
% getenv('PATH')

% getenv('PATH') 获得的是系统的PATH路径，而不是用户的PATH
% path_infos = cellfun(@string, split(getenv('PATH'), pathsep));
% if ~any(contains(path_infos, shortcut_dir))  % 已有路径中不包含shortcut路径
%     % 将文件夹附加到用户PATH下，其他的会覆盖掉（注意：setx \M 会设置系统环境变量）
%     !setx "Path" "C:\shortcut"
%     !setx "Path" "%Path%;C:\shortcut"
%     % setenv('PATH', [getenv('PATH') pathsep shortcut_dir]);  % 只在当前命令行窗口起作用
% end


py_path = fullfile(matlabroot, 'software', 'python', 'python.exe');
cmd_prefix = [py_path, ' pylnk3.py c '];

% Win+R打开（和utils/shortcut目录下的命令保持一致）
% python.exe pylnk3.py c  目的  快捷方式
% 工作空间
system([cmd_prefix fullfile(workspace_dir, 'dong'), ' ' fullfile(shortcut_dir, 'd.lnk')]);  % 代码仓库(repository)

% 工作目录
system([cmd_prefix workspace_dir ' ' fullfile(shortcut_dir, 'w.lnk')]);
% 学习目录
system([cmd_prefix fullfile(work_dir, 'learn') ' ' fullfile(shortcut_dir, 'l.lnk')]);
% 神经学习目录
system([cmd_prefix fullfile(work_dir, 'learn', 'neuro') ' ' fullfile(shortcut_dir, 'neu.lnk')]);
% 办公目录
system([cmd_prefix fullfile(work_dir, 'office') ' ' fullfile(shortcut_dir, 'off.lnk')]);
% 论文目录
system([cmd_prefix fullfile(work_dir, 'paper') ' ' fullfile(shortcut_dir, 'pap.lnk')]);
% 项目目录
system([cmd_prefix fullfile(work_dir, 'project') ' ' fullfile(shortcut_dir, 'p.lnk')]);
% 快捷方式
system([cmd_prefix fullfile(work_dir, 'shortcut') ' ' fullfile(shortcut_dir, 'sh.lnk')]);

% windows系统的下载目录
system([cmd_prefix fullfile('C:', 'Users', getenv('username'), 'Downloads') ' ' fullfile(shortcut_dir, 'dow.lnk')]);
% windows 用户目录
system([cmd_prefix fullfile('C:', 'Users', getenv('username')) ' ' fullfile(shortcut_dir, 'user.lnk')]);
% windows系统的临时目录 C:\Users\d\AppData\Local\Temp
system([cmd_prefix fullfile('C:', 'Users', getenv('username'), 'AppData', 'Local', 'Temp') ' ' fullfile(shortcut_dir, 'tmp.lnk')]);
% windows 系统配置目录（包括hosts文件）：C:\Windows\System32\drivers\etc
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'drivers', 'etc') ' ' fullfile(shortcut_dir, 'etc.lnk')]);
% windows 开机自启目录（目录包含空格使用双引号括起来进行解决）
system([cmd_prefix '"' fullfile('C:', 'ProgramData', 'Microsoft', 'Windows', 'Start Menu', 'Programs', 'StartUp') '" ' fullfile(shortcut_dir, 'su.lnk')]);
% windows 系统目录
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32') ' ' fullfile(shortcut_dir, 'sys.lnk')]);
% 数据目录设置为系统临时目录
system([cmd_prefix fullfile(tempdir, 'data') ' ' fullfile(shortcut_dir, 'dat.lnk')]);
%% 系统目录下的程序

% 卸载程序
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'appwiz.cpl') ' ' fullfile(shortcut_dir, 'app.lnk')]);
% 控制面板
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'control.exe') ' ' fullfile(shortcut_dir, 'ct.lnk')]);
% 设备管理器
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'compmgmt.msc') ' ' fullfile(shortcut_dir, 'dev.lnk')]);
% Internet 属性
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'inetcpl.cpl') ' ' fullfile(shortcut_dir, 'inet.lnk')]);
% 电源选项
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'powercfg.cpl') ' ' fullfile(shortcut_dir, 'pow.lnk')]);
% 截屏
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'SnippingTool.exe') ' ' fullfile(shortcut_dir, 'snip.lnk')]);
% 系统高级设置
system([cmd_prefix fullfile(getenv('SYSTEMROOT'), 'System32', 'SystemPropertiesAdvanced.exe') ' ' fullfile(shortcut_dir, 'sp.lnk')]);
%% Matlab

cmd_and_software = [cmd_prefix fullfile(matlabroot, 'software')];
% matlab 中的 software 目录
system([cmd_and_software ' ' fullfile(shortcut_dir, 'sw.lnk')]);

% Acrobat
system([fullfile(cmd_and_software, 'acrobat', 'Acrobat', 'Acrobat.exe') ' ' fullfile(shortcut_dir, 'acr.lnk')]);
% 百度网盘
system([fullfile(cmd_and_software, 'BaiduNetdisk', 'baidunetdisk.exe') ' ' fullfile(shortcut_dir, 'wp.lnk')]);
% BeehiveVPN 代理
system([fullfile(cmd_and_software, 'BeehiveVPN', 'BeehiveVPN.exe') ' ' fullfile(shortcut_dir, 'vpn.lnk')]);
% Beyond Compare 4软件
system([fullfile(cmd_and_software, 'BeyondCompare4', 'BCompare.exe') ' ' fullfile(shortcut_dir, 'bc.lnk')]);
% 录频（万彩录屏大师）
system([fullfile(cmd_and_software, 'capture', 'WCapture.exe') ' ' fullfile(shortcut_dir, 'cap.lnk')]);
% 有道词典
system([fullfile(cmd_and_software, 'dict', 'YoudaoDict.exe') ' ' fullfile(shortcut_dir, 'dic.lnk')]);
% Endnote
system([fullfile(cmd_and_software, 'EndNoteX8', 'EndNote.exe') ' ' fullfile(shortcut_dir, 'end.lnk')]);
% Free Download Manager
system([fullfile(cmd_and_software, 'FreeDownloadManager', 'fdm.exe') ' ' fullfile(shortcut_dir, 'fdm.lnk')]);
% MobaXterm
system([fullfile(cmd_and_software, 'MobaXterm', 'MobaXterm.exe') ' ' fullfile(shortcut_dir, 'mob.lnk')]);
% Pycharm
system([fullfile(cmd_and_software, 'python', 'pycharm', 'bin', 'pycharm64.exe') ' ' fullfile(shortcut_dir, 'pyc.lnk')]);
% RoadRunner
system([fullfile(cmd_and_software, 'RoadRunner_2022b', 'bin', 'win64', 'AppRoadRunner.exe') ' ' fullfile(shortcut_dir, 'rr.lnk')]);
% 屏幕保存为动图
system([fullfile(cmd_and_software, 'ScreenToGif', 'ScreenToGif.exe') ' ' fullfile(shortcut_dir, 'sg.lnk')]);
% 屏幕熄灭
system([fullfile(cmd_and_software, 'ScreenOff', 'ScreenOff2.1.exe') ' ' fullfile(shortcut_dir, 's.lnk')]);
% Shadowsocks
system([fullfile(cmd_and_software, 'Shadowsocks', 'Shadowsocks.exe') ' ' fullfile(shortcut_dir, 'ss.lnk')]);
% 远程控制
system([fullfile(cmd_and_software, 'SunloginClient', 'SunloginClient.exe') ' ' fullfile(shortcut_dir, 'log.lnk')]);
% QQ
system([fullfile(cmd_and_software, 'tencent', 'QQ', 'Bin', 'QQ.exe') ' ' fullfile(shortcut_dir, 'qq.lnk')]);
% 微信
system([fullfile(cmd_and_software, 'tencent', 'WeChat', 'WeChat.exe') ' ' fullfile(shortcut_dir, 'wx.lnk')]);
% texstudio
system([fullfile(cmd_and_software, 'latex', 'texstudio', 'texstudio.exe') ' ' fullfile(shortcut_dir, 'tex.lnk')]);
%% 自定义脚本

% 打开希腊字母文件（使用Alt+F4关闭）
pdf_cmd = ['cmd /C call "',  fullfile(matlabroot, 'software', 'acrobat', 'Acrobat', 'Acrobat') '" ', fullfile(shortcut_dir, 'xl.pdf')];
writelines(pdf_cmd, fullfile(shortcut_dir, 'xl.bat'));

% 关机
writelines('C:\Windows\System32\shutdown.exe -s -t 00', fullfile(shortcut_dir, 'sd.bat'));

% 自定义缓冲目录
system([cmd_prefix fullfile('C:', 'buffer') ' ' fullfile(shortcut_dir, 'buf.lnk')]);

% input_cmd = 'c C:\Windows\System32\cmd.exe shortcut.lnk';
% system([py_path ' pylnk3.py ' input_cmd])
%% 将快捷方式所在的路径添加到path环境变量

% 使用管理员权限打开cmd，然后到当前.mlx文件所在的目录执行以下脚本输出的命令
path_append_cmd = ['path_append.bat ' shortcut_dir];  disp(path_append_cmd);
% system(path_append_cmd);  % 需要管理员权限，否则：错误: 拒绝访问。