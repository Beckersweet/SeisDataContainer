function [tmpdir, toptmpdir] = makeDir(varargin)
%   makeDir(varargin) creates unique temporary directory
% 
%   [TMPDIR, TOPTMPDIR] = makeDir()
%       returns new directory created inside of the directory defined by
%       globalSDCTmpDir (see SeisDataContainer_init.m)
%   [TMPDIR, TOPTMPDIR] = makeDir(PARENT)
%       returns new directory created inside of PARENT directory.
%
%   In either case makeDir returns:
%   - TMPDIR: temporary directory on master process
%   - TOPTMPDIR: detected parent directory of TMPDIR
%
    error(nargchk(0, 1, nargin, 'struct'));
    global globalSDCTmpDir;

    if nargin > 0
        assert(ischar(varargin{1}),'Fatal error: argument is not a string');
        toptmpdir = varargin{1};
    else
        assert(~isempty(globalSDCTmpDir),'you first need to execute SeisDataContainer_init')
        toptmpdir = globalSDCTmpDir;
    end

    tmpdir = tempname(toptmpdir);
    status = mkdir(tmpdir);
    assert(status,'Fatal error while creating directory %s',tmpdir);
end
