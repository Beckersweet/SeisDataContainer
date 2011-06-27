function [tmpdir, toptmpdir] = makeDir(varargin)
%   makeDir(varargin) creates unique temporary directory
% 
%   [TMPDIR, TOPTMPDIR] = makeDir()
%       returns new directory created inside of the directory defined by
%       getenv('TMPDIR') or '/tmp' if TMPDIR environment is not set.
%   [TMPDIR, TOPTMPDIR] = makeDir(PARENT)
%       returns new directory created inside of PARENT directory.
%
%   In either case makeDir returns:
%   - TMPDIR: temporary directory on master process
%   - TOPTMPDIR: detected parent directory of TMPDIR
%
    error(nargchk(0, 1, nargin, 'struct'));

    toptmpdir = '/tmp';
    envtmpdir = getenv('TMPDIR');

    if nargin > 0
        assert(ischar(varargin{1}),'Fatal error: argument is not a string');
        toptmpdir = varargin{1};
    elseif length(envtmpdir)>0
        toptmpdir = envtmpdir;
    end

    tmpdir = tempname(toptmpdir);
    status = mkdir(tmpdir);
    assert(status,'Fatal error while creating directory %s',tmpdir);
end
