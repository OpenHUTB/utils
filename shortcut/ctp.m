%% cd temporary directory using 'cdtmp' in Command Window
% 临时新建一个目录并进入
function ctp()
    tmp = tempname;
    mkdir(tmp)
    cd(tmp)
%     pwd
%     dir(tmp)
%     eval(['cd ' tmp]);
end