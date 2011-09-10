function  SeisDataContainer_clean()
% SeisDataContainer_finalize cleans global and local temporary directories
%
    global SDCglobalTmpDir;
    global SDClocalTmpDir;
    global SDCbufferSize;
    global SDCdefaultIOdist;
    global SDCdebugFlag;

    if matlabpool('size') > 0
        spmd
            pause(rand());
            if isdir(SDClocalTmpDir)
                try
                    rmdir(SDClocalTmpDir,'s');
                end
            end
        end
    end
    if isdir(SDCglobalTmpDir)
        rmdir(SDCglobalTmpDir,'s')
    end
    fprintf('SDC temporary directories were deleted\n');

    clear global SDCglobalTmpDir;
    clear global SDClocalTmpDir;
    clear global SDCbufferSize;
    clear global SDCdefaultIOdist;
    clear global SDCdebugFlag;

    fprintf('SDC global variables were cleared\n');
end
