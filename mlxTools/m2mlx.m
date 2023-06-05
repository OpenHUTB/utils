%% m2mlx.m
% Converts m files to mlx files
% Apache V2 License - Copyright (c) 2020 Amin Yahyaabadi - aminyahyaabadi74@gmail.com
% https://github.com/aminya/mlxTools.m
% 真正的转换函数为：matlab.internal.liveeditor.openAndSave()

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m2mlx(method, rename, varargin)
    %% Converts m files to mlx files
    % `mlx2m(method, rename, foldersWithSubFolder, foldersWithoutSubFolder)`
    %
    % # Arguments:
    % `m2mlx(method::String, rename::Bool, [folders::Array{String}/Cell{Char}],[folders::Array{String}/Cell{Char}])`
    %
    %  - method: can be `"all","all_exclude","specific","GUI_all","GUI_specific"`
    %  - folders (optional):
    %   - if method is `"all_exclude"`: pass the folder names that should be excluded
    %   - if method is `"specific"`: pass the folder names that should be included.
    %       - 3rd argument are the folders that their subfolders are considered
    %       - 4th argument are the folders that their subfolders are ignored.
    %
    %  Folders specified can have a relative as well as absolute path.
    %
    % # Example
    % Choose the method, and run the function.
    % ```matlab
    % m2mlx("all", true);
    % ```
    %
    % Pass a 2nd and 3rd input to include/exclude specific folders if you chose "all_exclude" or "specific"
    % ```matlab
    % m2mlx("specified", true, ["Functions"],[pwd]);
    % m2mlx("specified", true, ["Functions"],[]);
    % m2mlx("exclude", true, ["Functions"],[]);
    % ```

    disp("m to mlx conversion started")
    %% files collect

    % '**/*.m' % means all under that folder
    % '*.m' % means only files in the root folder

    switch method

        % To include all
        case 'all'
            mFiles=dir('**/*.m');

        case 'all_exclude'
            mFiles=dir('**/*.m');

            % folders with their subfolders to be excluded
            excludedFoldersWSub = varargin{1};

            if ~isempty(excludedFoldersWSub)
                % 1
                mFiles = dir(fullfile([excludedFoldersWSub(i),"**/*.m"]));
                % 2:end
                for j=2:length(excludedFoldersWSub)
                    mFiles = [mFiles; dir(fullfile([excludedFoldersWSub(j),"**/*.m"]))];
                end
            end

            % folders without their subfolders to be excluded
            if nargin == 2
                excludedFoldersWOSub = varargin{2};

                if ~isempty(excludedFoldersWOSub)
                    for j=1:length(excludedFoldersWOSub)
                        mFiles = [mFiles; dir(fullfile([excludedFoldersWOSub(j),"*.m"]))];
                    end
                end
            end

            % excluding files of that folder
            removeList=zeros(size(mFilesExclude));
            iRem=1;
            for j=1:size(mFiles,1)
                if  ismember({mFiles(j).folder},{mFilesExclude(:).folder})
                    removeList(iRem)=j;
                    iRem=iRem+1;
                end
            end

            mFiles(removeList)=[];

        % To include all under a folder with GUI
        case 'GUI_all'
            d = uigetdir(pwd, 'Select a folder');
            mFiles = dir(fullfile(d, '**/*.m'));

        % To include a specific folder with GUI
        case 'GUI_specific'
            d = uigetdir(pwd, 'Select a folder');
            mFiles = dir(fullfile(d, '*.m'));

            while d~=0  % continue until user press cancel
                d = uigetdir(pwd, 'Select a folder');
                mFiles = [mFiles;dir(fullfile(d, '*.m'))];
            end

        % To include specific folders
        case 'specific'

            % folders with their subfolders
            includedFoldersWSub = varargin{1};

            if ~isempty(includedFoldersWSub)
                % 1
                mFiles = dir(fullfile([includedFoldersWSub(j),"**/*.m"]));
                % 2:end
                for j=2:length(includedFoldersWSub)
                    mFiles = [mFiles; dir(fullfile([includedFoldersWSub(j),"**/*.m"]))];
                end
            end

            % folders without their subfolders
            if nargin == 2
                includedFoldersWOSub = varargin{2};

                if ~isempty(includedFoldersWOSub)
                    for j=1:length(includedFoldersWOSub)
                        mFiles = [mFiles; dir(fullfile([includedFoldersWOSub(j),"*.m"]))];
                    end
                end
            end
    end


    %% create m folder and folder structure for storing files
    if isfolder('mlx')
        %     disp('Warning: m folder already exists!')
        %     warning('off','MATLAB:MKDIR:DirectoryExists')
        answer = questdlg('mlx folder already exists. Do you want to remove it? ', ...
        'm Folder removal', ...
        'Yes','No','Yes');
        % Handle response
        switch answer
        case 'Yes'
            rmdir mlx s
        case 'No'
            warning('off','MATLAB:MKDIR:DirectoryExists')
            disp('Warning: overwriting files')
        end
    end

    currentFolder = pwd;
    mFolders=fullfile('mlx',erase(unique({mFiles.folder}),currentFolder));
    for j=1:length(mFolders)
        mkdir(mFolders{j})
    end

    %% start conversion
    mlxFiles=mFiles;
    for j=1:length(mFiles)

        mFiles(j).path=fullfile(mFiles(j).folder, mFiles(j).name);
        if rename
            % adds an M to the end to avoid conflicts
            mlxFiles(j).path=fullfile('mlx',erase(mFiles(j).folder,currentFolder),[mFiles(j).name(1:end-4),'M.mlx']);
        else
            mlxFiles(j).path=fullfile('mlx',erase(mFiles(j).folder,currentFolder),[mFiles(j).name(1:end-4),'.mlx']);
        end

        matlab.internal.liveeditor.openAndSave(mFiles(j).path, fullfile(mFiles(j).folder, mlxFiles(j).path))  % need the fullpath of destinationFile

        % progress bar:
        per=floor(j/length(mFiles)*100);
        fprintf([repmat('.',1,round(per/2)),'%d%%',repmat('.',1,round(per/2)),'|\n'],per)
    end

    disp("finished")

end
