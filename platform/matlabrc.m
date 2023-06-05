%MATLABRC Master startup MATLAB script.
%   MATLABRC is automatically executed by MATLAB during startup.
%   It sets the default figure size, and sets a few uicontrol defaults.
%
%   On multi-user or networked systems, the system manager can put
%   any messages, definitions, etc. that apply to all users here.
%
%   如果在 Matlab path 中存在 'startup.m' 文件，在执行完 MATLABRC 后再执行 STARTUP 命令。

%   Copyright 1984-2020 The MathWorks, Inc.

try
    % 当达到指定调用深度，RecursionLimit 迫使 MATLAB 抛出错误。
    % This protects you from blowing your stack
    % frame（这将当值 MATLAB 或电脑崩溃）。
    % 默认的递归深度设置为 500。
    % 取消下面一行代码将设置递归限制为其他值。
    % 如果你不想这种保护可以设置为 inf。
    % set(0, 'RecursionLimit',700)
catch exc
    warning(message('MATLAB:matlabrc:RecursionLimit', exc.identifier, exc.message));
end

% Set default warning level to WARNING BACKTRACE.  See help warning.
warning backtrace

try
    % Enable/Disable selected warnings by default
    warning off MATLAB:mir_warning_unrecognized_pragma
    warning off MATLAB:subscripting:noSubscriptsSpecified %future incompatibity

    warning off MATLAB:JavaComponentThreading
    warning off MATLAB:JavaEDTAutoDelegation

    % Random number generator warnings
    warning off MATLAB:RandStream:ReadingInactiveLegacyGeneratorState
    warning off MATLAB:RandStream:ActivatingLegacyGenerators

    warning off MATLAB:class:DynPropDuplicatesMethod
catch exc
    warning(message('MATLAB:matlabrc:DisableWarnings', exc.identifier, exc.message));
end

% 清除工作区
clear

% Defer echo until startup is complete
try
if strcmpi(system_dependent('getpref','GeneralEchoOn'),'BTrue')
    echo on
end
catch exc
    warning(message('MATLAB:matlabrc:InitPreferences', exc.identifier, exc.message));
end

%% 自定义配置
run(fullfile(fileparts(matlabroot), 'dong', 'utils', 'init_matlab.mlx'));

%%
% % 根据MAC地址判断是否是第一次在机器上启动
% cur_mac = get_mac();
% mac_record_path = fullfile(matlabroot, 'data', 'conf', 'mac.txt');
% 
% if ~exist(mac_record_path, 'file') 
%     init_matlab
%     writelines(cur_mac, mac_record_path);
% else
%     mac_record_infos = readlines(mac_record_path);
%     history_mac = mac_record_infos{1};
%     if strcmp(cur_mac, history_mac) == 0  % 如果MAC地址不同，则表示是在新的机器上运行matlab
%         init_matlab
%         writelines(cur_mac, mac_record_path);
%     else
%         % 在相同的机器上运行，不需要做第一次初始化的工作
%     end
% end
% 
% 
% %% 目录初始化
% % 启动时候打开工作空间 dong（dong和Matlab放在同一目录下）
% rep_dir = fullfile(fileparts(matlabroot), 'dong');
% if exist(rep_dir, 'dir')
%     cd(rep_dir);
%     addpath(fullfile(rep_dir, 'utils', 'shortcut'));
% end
% 
% 
% %% 清除初始化变量
% % clear
% 
% 
% 
% %% Matlab 在新机器上运行的初始化函数
% % 修改mac地址用于测试在新机器初始化环境
% function init_matlab()
% % 用户路径（默认Examples放置的路径）
% data_dir = fullfile(matlabroot, 'data');
% if ~exist(data_dir, 'dir'); mkdir(data_dir); end
% userpath(fullfile(data_dir));
% 
% % 设置和获取自定义支持包根文件夹
% % 修改支持包信息
% sp_dir = fullfile(matlabroot, 'data', 'SupportPackages');
% ver_info = get_ver();
% writelines(sprintf('(%s)@%s', ver_info, matlabroot), fullfile(sp_dir, 'sppkg_matlab_info.txt'));
% matlabshared.supportpkg.setSupportPackageRoot(sp_dir);
% % matlabshared.supportpkg.getSupportPackageRoot
% 
% correct_vgg
% 
% addpath(fullfile(matlabroot, 'utils'));
% 
% savepath
% % 显示当前文件夹以及当前搜索路径中的所有 pathdef.m 文件的路径
% % which pathdef.m -all
% end
% 
% 
% %% 得到matlab版本信息
% % R2022a
% function ver_info = get_ver()
% ver_info = version;
% ver_pat = "R" + digitsPattern(4) + ("a"|"b");
% ver_info = extract(ver_info, ver_pat);
% ver_info = ver_info{1};
% end
% 
% 
% %% 得到MAC地址
% function cur_mac = get_mac()
% [~, mac_res] =  dos('getmac');
% mac_pat = alphanumericsPattern(2) + "-" + alphanumericsPattern(2) + "-" + ...
%     alphanumericsPattern(2) + "-" + alphanumericsPattern(2) + "-" + ...
%     alphanumericsPattern(2) + "-" + alphanumericsPattern(2);
% mac_infos = extract(mac_res, mac_pat);
% cur_mac = mac_infos{1};
% end
% 
% 
% %% 校正VGG安装信息
% function correct_vgg()
% % correct vgg16 and vgg19 installation information
% vgg16_info_dir = fullfile(matlabshared.supportpkg.getSupportPackageRoot, 'appdata', '3p', 'common', 'vgg16.instrset');
% vgg16_mat_dir = fullfile(matlabshared.supportpkg.getSupportPackageRoot, get_ver(), '3P.instrset', 'vgg16.instrset');
% vgg16_infos = "installLocation = " + vgg16_mat_dir;
% writelines(vgg16_infos, fullfile(vgg16_info_dir, 'vgg16.instrset_install_info.txt'));
% 
% vgg19_info_dir = fullfile(matlabshared.supportpkg.getSupportPackageRoot, 'appdata', '3p', 'common', 'vgg19.instrset');
% vgg19_mat_dir = fullfile(matlabshared.supportpkg.getSupportPackageRoot, '3P.instrset', 'vgg19.instrset');
% vgg19_infos = "installLocation = " + vgg19_mat_dir;
% writelines(vgg19_infos, fullfile(vgg19_info_dir,'vgg19.instrset_install_info.txt'));
% end

