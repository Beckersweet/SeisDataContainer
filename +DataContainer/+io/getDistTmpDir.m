function [tmpdir, tmpdirs] = getDistTmpDir(varargin)
%   getDistTmpDir creates unique temporary directories
%                 on master and worker processes
%
%   [TMPDIR, TMPDIRS] = getDistTmpDir()
%       returns new directories created inside of the directory defined by
%       getenv('TMPDIR') or '/tmp' if TMPDIR environment is not set.
%   [TMPDIR, TMPDIRS] = getDistTmpDir(PARENT)
%       returns new directories created inside of PARENT directory.
%
%   In either case getDistTmpDir returns:
%   - TMPDIR: temporary directory on master process
%   - TMPDIRS: composite of temporary directories for workers
%
%   Note: getDistTmpDir will still work if matlabpool is not called
%         except TMPDIRS will be empty.
%
    tmpdirs=Composite();

    if nargin>0 & isstr(varargin{1})
        [tmpdir,dtd] = DataContainer.io.getTmpDir(varargin{1});
    else
        [tmpdir,dtd] = DataContainer.io.getTmpDir();
    end

    if matlabpool('size') > 0
        spmd
            tmpdirs=DataContainer.io.getTmpDir(dtd);
        end
    end
end
