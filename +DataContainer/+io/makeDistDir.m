function tmpdirs = makeDistDir(varargin)
%   makeDistDir creates unique temporary directories
%                 on worker processes
%
%   TMPDIRS = makeDistDir()
%       returns new directories created inside of the directory defined by
%       getenv('TMPDIR') or '/tmp' if TMPDIR environment is not set.
%   TMPDIRS = makeDistDir(PARENT)
%       returns new directories created inside of PARENT directory.
%
%   In either case makeDistDir returns:
%   - TMPDIRS: composite of temporary directories for workers
%
    error(nargchk(0, 1, nargin, 'struct'));
    assert(matlabpool('size') > 0,'matlabpool has to be open');

    tmpdirs = Composite();

    if nargin > 0
        assert(ischar(varargin{1}),'Fatal error: argument is not a string');
        spmd
            tmpdirs = DataContainer.io.makeDir(varargin{1});
        end
    else
        spmd
            tmpdirs = DataContainer.io.makeDir();
        end
    end

    tmpdirs = DataContainer.utils.Composite2Cell(tmpdirs);
end
