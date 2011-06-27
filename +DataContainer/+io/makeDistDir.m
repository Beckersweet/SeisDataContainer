function [tmpdir, tmpdirs] = makeDistDir(varargin)
%   makeDistDir creates unique temporary directories
%                 on master and worker processes
%
%   [TMPDIR, TMPDIRS] = makeDistDir()
%       returns new directories created inside of the directory defined by
%       getenv('TMPDIR') or '/tmp' if TMPDIR environment is not set.
%   [TMPDIR, TMPDIRS] = makeDistDir(PARENT)
%       returns new directories created inside of PARENT directory.
%
%   In either case makeDistDir returns:
%   - TMPDIR: temporary directory on master process
%   - TMPDIRS: composite of temporary directories for workers
%
%   Note: makeDistDir will still work if matlabpool is not called
%         except TMPDIRS will be empty.
%
    error(nargchk(0, 1, nargin, 'struct'));

    tmpdirs = Composite();

    if nargin > 0
        assert(ischar(varargin{1}),'Fatal error: argument is not a string');
        [tmpdir,dtd] = DataContainer.io.makeDir(varargin{1});
    else
        [tmpdir,dtd] = DataContainer.io.makeDir();
    end

    if matlabpool('size') > 0
        spmd
            tmpdirs = DataContainer.io.makeDir(dtd);
        end
    else
        warning('Warning: called outside of matlabpool/batch call');
    end
end
