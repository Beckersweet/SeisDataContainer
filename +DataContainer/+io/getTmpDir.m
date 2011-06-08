function [tmpdir, toptmpdir] = getTmpDir(varargin)
%   getTmpDir(varargin) creates unique temporary directory
% 
%   [TMPDIR, TOPTMPDIR] = getTmpDir()
%       returns new directory created inside of the directory defined by
%       getenv('TMPDIR') or '/tmp' if TMPDIR environment is not set.
%   [TMPDIR, TOPTMPDIR] = getTmpDir(PARENT)
%       returns new directory created inside of PARENT directory.
%
%   In either case getTmpDir returns:
%   - TMPDIR: temporary directory on master process
%   - TOPTMPDIR: detected parent directory of TMPDIR
%
    toptmpdir = '/tmp';
    envtmpdir = getenv('TMPDIR');

    if nargin>0 & isstr(varargin{1})
        toptmpdir = varargin{1};
    elseif length(envtmpdir)>0
        toptmpdir = envtmpdir;
    end

    tmpdir = tempname(toptmpdir);
    status = mkdir(tmpdir);
    assert(status,'Fatal error while creating directory %s',tmpdir)
end
