function [tmpdirs, toptmpdir] = makeDistDir(varargin)
%   makeDistDir creates unique temporary directories
%                 on worker processes
%
%   TMPDIRS = makeDistDir()
%       returns new directories created inside of the directory defined by
%       SDClocalTmpDir (see SeisDataContainer_init.m)
%   TMPDIRS = makeDistDir(PARENT)
%       returns new directories created inside of PARENT directory.
%
%   In either case makeDistDir returns:
%   - TMPDIRS: composite of temporary directories for workers
%
    error(nargchk(0, 1, nargin, 'struct'));
    assert(matlabpool('size')>0,'matlabpool has to be open');
    global SDClocalTmpDir;

    tmpdirs = Composite();

    if nargin > 0
        assert(ischar(varargin{1}),'Fatal error: argument is not a string');
        toptmpdir = varargin{1};
    else
        assert(~isempty(SDClocalTmpDir),'you first need to execute SeisDataContainer_init')
        toptmpdir = SDClocalTmpDir;
    end
    spmd
        tmpdirs = DataContainer.io.makeDir(toptmpdir);
    end

    tmpdirs = DataContainer.utils.Composite2Cell(tmpdirs);
end
