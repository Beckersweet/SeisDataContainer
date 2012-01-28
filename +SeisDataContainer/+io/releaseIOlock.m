function status = releaseIOlock(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    lockname = '_IOlock';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'lock name is not a string');
        lockname = varargin{1};
    end

    lockdir = fullfile(dirname,lockname);
    status = 0;
    assert(isdir(lockdir),'IO lock %s is not a directory or does not exist',lockdir)
    [status msg msgid] = rmdir(lockdir);

end
