function  SeisDataContainer_clean(name,mode)
% SeisDataContainer_finalize cleans global and local temporary directories
%
    global SDCglobalTmpDir;
    global SDClocalTmpDir;
    global SDCbufferSize;
    global SDCdefaultIOdist;
    global SDCdebugFlag;
    if strcmp(name,'Verbose')
        verbose = mode;
    else
        verbose = 1;
    end

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
    if verbose
        fprintf('Deleted local temporary home %s\n',SDClocalTmpDir);
    end
    if isdir(SDCglobalTmpDir)
        rmdir(SDCglobalTmpDir,'s')
    end
    if verbose
        fprintf('Deleted global temporary home in %s\n',SDCglobalTmpDir);
    end

    clear global SDCglobalTmpDir;
    clear global SDClocalTmpDir;
    clear global SDCbufferSize;
    clear global SDCdefaultIOdist;
    clear global SDCdebugFlag;
    
    if verbose
        fprintf('SDC global variables were cleared\n');
    end
end
