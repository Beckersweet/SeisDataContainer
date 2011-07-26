function  SeisDataContainer_init(varargin)
    error(nargchk(0, 2, nargin, 'struct'));
    global globalSDCTmpDir;
    global localSDCTmpDir;

    % set global temporary directory
    % accessible from every worker
    if nargin > 0
        globalSDCTmpDir = varargin{1};
    else
        envdir = getenv('GLOBTMPDIR');
        if length(envdir) > 0
            globalSDCTmpDir = envdir;
        else
            disp('Warrning: Missing GLOBTMPDIR environment. Using current directory.')
            globalSDCTmpDir = fullfile(pwd,'SDC.tmp');
        end
    end
    if ~strcmp(globalSDCTmpDir(1),filesep)
        globalSDCTmpDir = fullfile(pwd,globalSDCTmpDir);
    end
    if ~isdir(globalSDCTmpDir)
        mkdir(globalSDCTmpDir)
    end
    fprintf('Global temporary directory is %s\n',globalSDCTmpDir);

    % set local temporary directory
    % might not accessible form every worker
    if nargin > 1
        localSDCTmpDir = varargin{2};
    else
        envdir = getenv('TMPDIR');
        if length(envdir) > 0
            localSDCTmpDir = envdir;
        else
            localSDCTmpDir = '/tmp/SDC.tmp';
        end
    end
    if ~strcmp(localSDCTmpDir(1),filesep)
        localSDCTmpDir = fullfile(pwd,localSDCTmpDir);
    end
    fprintf('Local temporary directory is %s\n',localSDCTmpDir);

    % check gloabl directory on the workers
    % and create local directories
    if matlabpool('size') > 0
        spmd
            assert(isdir(globalSDCTmpDir),'Global temporary directory %s missing on the worker.')
            if ~isdir(localSDCTmpDir)
                mkdir(localSDCTmpDir);
            end
        end
    end
    if strcmp(globalSDCTmpDir,localSDCTmpDir)
        warning('Having SAME GLOBAL AND LOCAL TEMPORARY DIRECTORIES might be a BAD IDEA.')
    end

end
