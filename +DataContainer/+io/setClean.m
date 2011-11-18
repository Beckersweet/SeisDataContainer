function status = setClean(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    lockname = '_IOinProgress';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'lock name is not a string');
        lockname = varargin{1};
    end

    lockfile = fullfile(dirname,lockname);
    assert(DataContainer.io.isFile(lockfile),...
        'File seems to be already clean: probably missing prior setDirty?')
    delete(lockfile);

end
