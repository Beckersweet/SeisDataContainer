function status = setDirty(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    assert(isdir(dirname),'dirname %s is not a directory or does not exist',dirname)
    lockname = '_IOinProgress';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'lock name is not a string');
        lockname = varargin{1};
    end

    lockfile = fullfile(dirname,lockname);
    assert(~DataContainer.io.isFile(lockfile),...
        'File is dirty: either operation in progress or using leftovers from crashed process')
    DataContainer.io.allocFile(lockfile,1,1);
    
end
