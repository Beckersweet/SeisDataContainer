function  SeisDataContainer_init(varargin)
% SeisDataContainer_init initializes global and local temporary directories
%
%   SeisDataContainer_init() will try to get GLOBTMPDIR and TMPDIR environment
%       to initialize respectively global and local temporary directories.
%       If GLOBTMPDIR environment is not set,
%           it will use fullfile(pwd,'SDC.tmp') directory instead.
%       If TMPDIR environment is not set,
%           it will use '/tmp/SDC.tmp' directory instead.
%   SeisDataContainer_init(GLOBTMPDIR) will use
%       GLOBTMPDIR argument instead of GLOBTMPDIR environment.
%   SeisDataContainer_init(GLOBTMPDIR,LOCALTMPDIR) will use
%       GLOBTMPDIR argument instead of GLOBTMPDIR environment and
%       LOCALTMPDIR argument instead of TMPDIR environment.
    error(nargchk(0, 3, nargin, 'struct'));
    global globalSDCTmpDir;
    global localSDCTmpDir;
    global SDCBufferSize;

    % set global temporary directory
    % accessible from every worker
    if nargin > 0 & length(varargin{1}) > 1
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
    if nargin > 1 & length(varargin{2})>1
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

    % set buffer size
    MBsize = 1024*1024;
    mfactor = 8*MBsize;
    if nargin > 2
        SDCBufferSize = DataContainer.utils.getByteSize('double')*varargin{3};
    else
        SDCBufferSize = DataContainer.utils.getByteSize('double')*mfactor;
    end
    fprintf('IO buffer size set to %d MB\n',SDCBufferSize/MBsize);

end
