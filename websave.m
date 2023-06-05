% dataFolder = tempdir; 
% dataFilename = "PandasetSensorData.zip";
% url = "https://ssd.mathworks.com/supportfiles/driving/data/" + dataFilename;
% filePath = fullfile(dataFolder,dataFilename);
% if ~isfile(filePath)
%     websave(filePath,url)
% end
% websave(filePath,url)

% C:\BaiduSyncdisk\matlab\toolbox\matlab\external\interfaces\webservices\restful\websave.m

% 重写文件下载函数：如果本地ssd目录存在就不从网上下载。
function filename = websave(filename, url, options)
    cur_dir = pwd;
    disp('custom websave');
    [~, name, ext] = fileparts(url);
    global local_ssd
    local_filename = fullfile(local_ssd, append(name, ext));
    
    if exist('local_ssd', 'var') && exist(local_filename, 'file')
        copyfile(local_filename, fileparts(filename));
    else
        cd(fullfile(toolboxdir('matlab'), 'external', 'interfaces', 'webservices', 'restful'));
        if nargin == 2
            websave(filename, url)
        else
            websave(filename, url, options)
        end       
        
        cd(cur_dir);
    end
end