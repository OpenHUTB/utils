
%%
% 包含需要安装的网络：
% googlenet, vgg19, inceptionv3
% densenet201, mobilenetv2, resnet18, resnet50, resnet101, 
% xception, inceptionresnetv2, nasnetlarge, nasnetmobile,
% shufflenet, darknet19, darknet53, alexnet, vgg16
% 有些网络的权重已经自带，不需要安装：
% squeezenet
% 不包括高于2020a版本的:
% efficientnetb0

%% 获取已安装的附加功能
addons_installed = matlab.addons.installedAddons;

% 安装样例
% cd /opt/MATLAB/R2018b/bin/glnxa64
%         ./install_supportsoftware.sh -matlabroot /opt/MATLAB/R2018b -archives /home/jdoe/Downloads/MathWorks/SupportPackages/R2018b

if ispc
    filename_suffix = '.exe';
else
    filename_suffix = '.sh';
end
install_script_path = fullfile(matlabroot, 'bin', computer('arch'), ['install_supportsoftware', filename_suffix]);

archives_dir = 'C:\baidunetdiskdownload\dl_2020a';  % 百度网盘只保留了兼容linux的安装包？
install_cmd = [install_script_path, ' -matlabroot ', matlabroot, ' -archives ', archives_dir];
% 执行安装（会弹出交互界面）
% /usr/local/Polyspace/R2020a/bin/glnxa64/install_supportsoftware.sh -matlabroot /usr/local/Polyspace/R2020a -archives /data2/install/matlab/install/install/googlenet
% /data2/whd/software/matlab_2020b/bin/glnxa64/install_supportsoftware.sh -matlabroot /data2/whd/software/matlab_2020b/ -archives /data2/install/matlab/install/install/dl_2020a
[status, cmdout] = system(install_cmd);

%%
% 测试（安装完成需要重启matlab才能生效）
% net = googlenet;

% 不加载权重
% googlenet('Weights','none')
