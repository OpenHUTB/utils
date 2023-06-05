function filePath = getSupportFilePath(modelName,fileName)
% getSupportFilePath   This function is for converting any differences
% between the model names presented to the user and the support files
% URLs.

% Copyright 2021 The MathWorks, Inc.
arguments
    modelName (1,1) string
    fileName (1,1) string
end
directory = bert.internal.convertModelNameToDirectories(modelName);
sd = matlab.internal.examples.utils.getSupportFileDir();
localFile = fullfile(sd,"nnet",directory{:},fileName);

% 尝试从本地ssd中加载数据
local_ssd = 'D:\ssd';
local_ssd_file = fullfile(local_ssd, "nnet",directory{:},fileName);

if exist(local_ssd_file, 'file') ~= 2
    if exist(localFile,'file')~=2
        disp("Downloading "+fileName+" to: "+localFile);
    end
    fileURL = strjoin([directory,fileName],"/");
    filePath = matlab.internal.examples.downloadSupportFile("nnet",fileURL);
else
    filePath = local_ssd_file;
end

end