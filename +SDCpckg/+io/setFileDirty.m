function setFileDirty(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    assert(isdir(dirname),'dirname %s is not a directory or does not exist',dirname)
    lockname = '_IOinProgress';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'file name is not a string');
        lockname = varargin{1};
    end

    lockfile = fullfile(dirname,lockname);
    assert(~SDCpckg.io.isFile(lockfile),...
        'File %s\n\tis dirty: either operation in progress or using leftovers from crashed process',dirname)
    SDCpckg.io.allocFile(lockfile,1,1);
    
end
