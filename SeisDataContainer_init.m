function  SeisDataContainer_init(varargin)
    error(nargchk(0, 2, nargin, 'struct'));
    global globalTmpDir
    global localTmpDir

    % set global temporary directory
    % accessible from every worker
    if nargin > 0
        globalTmpDir = varargin{1};
    else
        envdir = getenv('GLOBTMPDIR');
        if length(envdir) > 0
            globalTmpDir = envdir;
        else
            disp('Warrning: Missing GLOBTMPDIR environment. Using current directory.')
            globalTmpDir = fullfile(pwd,'SDC.tmp');
        end
    end
    if ~strcmp(globalTmpDir(1),filesep)
        globalTmpDir = fullfile(pwd,globalTmpDir);
    end
    if ~isdir(globalTmpDir)
        mkdir(globalTmpDir)
    end
    fprintf('Global temporary directory is %s\n',globalTmpDir);

    % set local temporary directory
    % might not accessible form every worker
    if nargin > 1
        localTmpDir = varargin{2};
    else
        envdir = getenv('TMPDIR');
        if length(envdir) > 0
            localTmpDir = envdir;
        else
            localTmpDir = '/tmp/SDC.tmp';
        end
    end
    if ~strcmp(localTmpDir(1),filesep)
        localTmpDir = fullfile(pwd,localTmpDir);
    end
    fprintf('Local temporary directory is %s\n',localTmpDir);

    % check gloabl directory on the workers
    % and create local directories
    if matlabpool('size') > 0
        spmd
            assert(isdir(globalTmpDir),'Global temporary directory %s missing on the worker.')
            if ~isdir(localTmpDir)
                mkdir(localTmpDir);
            end
        end
    end
    if strcmp(globalTmpDir,localTmpDir)
        warning('Having SAME GLOBAL AND LOCAL TEMPORARY DIRECTORIES might be a BAD IDEA.')
    end

end
