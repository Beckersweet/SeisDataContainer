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
    error(nargchk(0, 4, nargin, 'struct'));
    global SDCglobalTmpDir;
    global SDClocalTmpDir;
    global SDCbufferSize;
    global SDCdebugFlag;

    % set global temporary directory
    % accessible from every worker
    if nargin > 0 & length(varargin{1}) > 1
        SDCglobalTmpDir = varargin{1};
    else
        envdir = getenv('GLOBTMPDIR');
        if length(envdir) > 0
            SDCglobalTmpDir = envdir;
        else
            disp('Warrning: Missing GLOBTMPDIR environment. Using current directory.')
            SDCglobalTmpDir = fullfile(pwd,'SDC.tmp');
        end
    end
    if ~strcmp(SDCglobalTmpDir(1),filesep)
        SDCglobalTmpDir = fullfile(pwd,SDCglobalTmpDir);
    end
    SDCglobalTmpDir = tempname(SDCglobalTmpDir);
    if ~isdir(SDCglobalTmpDir)
        mkdir(SDCglobalTmpDir)
    end
    fprintf('Global temporary directory is %s\n',SDCglobalTmpDir);

    % set local temporary directory
    % might not accessible form every worker
    if nargin > 1 & length(varargin{2})>1
        SDClocalTmpDir = varargin{2};
    else
        envdir = getenv('TMPDIR');
        if length(envdir) > 0
            SDClocalTmpDir = envdir;
        else
            SDClocalTmpDir = '/tmp/SDC.tmp';
        end
    end
    if ~strcmp(SDClocalTmpDir(1),filesep)
        SDClocalTmpDir = fullfile(pwd,SDClocalTmpDir);
    end
    SDClocalTmpDir = tempname(SDClocalTmpDir);
    fprintf('Local temporary directory is %s\n',SDClocalTmpDir);

    % check gloabl directory on the workers
    % and create local directories
    if matlabpool('size') > 0
        spmd
            assert(isdir(SDCglobalTmpDir),'Global temporary directory %s missing on the worker.')
            if ~isdir(SDClocalTmpDir)
                mkdir(SDClocalTmpDir);
            end
        end
    end
    if strcmp(SDCglobalTmpDir,SDClocalTmpDir)
        warning('Having SAME GLOBAL AND LOCAL TEMPORARY DIRECTORIES might be a BAD IDEA.')
    end

    % set buffer size
    MBsize = 1024*1024;
    mfactor = 8*MBsize;
    if nargin > 2
        SDCbufferSize = DataContainer.utils.getByteSize('double')*varargin{3};
    else
        SDCbufferSize = DataContainer.utils.getByteSize('double')*mfactor;
    end
    fprintf('IO buffer size set to %d MB\n',SDCbufferSize/MBsize);

    % set debug flag
    if nargin > 3
        SDCdebugFlag = varargin{4};
    else
        SDCdebugFlag = 0;
    end
    fprintf('Debug flag is set to %d\n',SDCdebugFlag);
end
