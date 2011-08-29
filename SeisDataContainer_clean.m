function  SeisDataContainer_clean()
% SeisDataContainer_finalize cleans global and local temporary directories
%
    global SDCglobalTmpDir;
    global SDClocalTmpDir;
    global SDCbufferSize;
    global SDCdefaultIOdist;
    global SDCdebugFlag;

    if isdir(SDClocalTmpDir)
        rmdir(SDCglobalTmpDir)
    end

    if matlabpool('size') > 0
        spmd
            if isdir(SDClocalTmpDir)
                rmdir(SDClocalTmpDir);
            end
        end
    end
    fprintf('SDC temporary directories were deleted\n');

    clear global SDCglobalTmpDir;
    clear global SDClocalTmpDir;
    clear global SDCbufferSize;
    clear global SDCdefaultIOdist;
    clear global SDCdebugFlag;

    fprintf('SDC global variables were cleared\n');
end
