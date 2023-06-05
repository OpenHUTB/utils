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
% 用户路径（默认Examples放置的路径）
% userpath(fullfile(matlabroot, 'data'))
% 
% % 设置和获取自定义支持包根文件夹
% matlabshared.supportpkg.setSupportPackageRoot(fullfile(matlabroot, 'data', 'SupportPackages'));
% % matlabshared.supportpkg.getSupportPackageRoot
% 
% addpath(fullfile(matlabroot, 'utils'));

% 启动时候打开工作空间C:/dong
% if exist('C:\dong', 'dir')
%     cd C:\dong
% end

