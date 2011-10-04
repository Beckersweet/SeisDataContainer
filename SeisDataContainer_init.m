function  SeisDataContainer_init(varargin)
% SeisDataContainer_init initializes necessary global variables for 
%       SeisDataContainer environment
%
%   Optional keyword arguments:
%       'SDCglobalTmpDir' is home for global temorary directories
%           see notes below
%       'SDClocalTmpDir' is home for local temporary directories
%           see notes below
%       'SDCbufferSize' is size of buffer for some IO operations
%           size of the buffer in 'double' elements (dafault=8M)
%       'SDCdefaultIOdist' is defult distribution flag
%           0=non-distributed (default); 1=distributed
%       'SDCdebugFlag' is gloabl debug flag
%           0=off (default); 1=on
%
%   Notes:
%       If either 'SDCglobalTmpDir' or 'SDClocalTmpDir' are not given
%       SeisDataContainer_init will try to get GLOBTMPDIR and TMPDIR environment
%       to initialize respectively global and local temporary directories.
%       If GLOBTMPDIR environment is not set,
%           it will use fullfile(pwd,'SDC.tmp') directory instead.
%       If TMPDIR environment is not set,
%           it will use '/tmp/SDC.tmp' directory instead.
%
    error(nargchk(0, 8, nargin, 'struct'));
    global SDCglobalTmpDir;
    global SDClocalTmpDir;
    global SDCbufferSize;
    global SDCdefaultIOdist;
    global SDCdebugFlag;
    MBsize = 1024*1024;
    doubleSize = DataContainer.utils.getByteSize('double');

    % parse varargin
    p = inputParser;
    p.addParamValue('SDCglobalTmpDir',getenv('GLOBTMPDIR'),@ischar);
    p.addParamValue('SDClocalTmpDir',getenv('TMPDIR'),@ischar);
    p.addParamValue('SDCbufferSize',doubleSize*MBsize,@(x)isnumeric(x)||isscalar(x));
    p.addParamValue('SDCdefaultIOdist',0,@(x)isnumeric(x)||isscalar(x));
    p.addParamValue('SDCdebugFlag',0,@(x)isnumeric(x)||isscalar(x));
    p.parse(varargin{:});
    %p.Results

    % create global temporary directory
    % accessible from every worker
    if length(p.Results.SDCglobalTmpDir) > 0
        SDCglobalTmpDir = p.Results.SDCglobalTmpDir;
    else
        disp('Warrning: Missing GLOBTMPDIR environment. Using SDC.tmp in current directory.')
        SDCglobalTmpDir = fullfile(pwd,'SDC.tmp');
    end
    if ~strcmp(SDCglobalTmpDir(1),filesep)
        SDCglobalTmpDir = fullfile(pwd,SDCglobalTmpDir);
    end
    SDCglobalTmpDir = tempname(SDCglobalTmpDir);
    if ~isdir(SDCglobalTmpDir)
        mkdir(SDCglobalTmpDir)
    end
    fprintf('Global temporary home in %s\n',SDCglobalTmpDir);

    % set local temporary directories
    % might not accessible form every worker
    if length(p.Results.SDClocalTmpDir) > 0
        SDClocalTmpDir = p.Results.SDClocalTmpDir;
    else
        disp('Warrning: Missing TMPDIR environment. Using /tmp/SDC.tmp.')
        SDClocalTmpDir = '/tmp/SDC.tmp';
    end
    if ~strcmp(SDClocalTmpDir(1),filesep)
        SDClocalTmpDir = fullfile(pwd,SDClocalTmpDir);
    end
    SDClocalTmpDir = tempname(SDClocalTmpDir);
    fprintf('Local temporary home in %s\n',SDClocalTmpDir);

    % check gloabl directory on the workers
    % and create local temporary directories
    if matlabpool('size') > 0
        spmd
            assert(isdir(SDCglobalTmpDir),...
                'Global temporary directory missing on the worker %d.',labindex)
            pause(rand());
            if ~isdir(SDClocalTmpDir)
                mkdir(SDClocalTmpDir);
            end
        end
    end
    if strcmp(SDCglobalTmpDir,SDClocalTmpDir)
        warning('Having SAME GLOBAL AND LOCAL TEMPORARY DIRECTORIES might be a BAD IDEA.')
    end

    % set buffer size
    SDCbufferSize = DataContainer.utils.getByteSize('double')*p.Results.SDCbufferSize;
    fprintf('IO buffer size set to %d MB\n',SDCbufferSize/MBsize);

    % set debug flag
    SDCdefaultIOdist = p.Results.SDCdefaultIOdist;
    fprintf('Default IO distribution flag is set to %d\n',SDCdefaultIOdist);

    % set debug flag
    SDCdebugFlag = p.Results.SDCdebugFlag;
    fprintf('Debug flag is set to %d\n',SDCdebugFlag);
end
