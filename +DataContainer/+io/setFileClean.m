function setFileClean(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    assert(isdir(dirname),'dirname %s is not a directory or does not exist',dirname)
    lockname = '_IOinProgress';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'file name is not a string');
        lockname = varargin{1};
    end

    lockfile = fullfile(dirname,lockname);
    assert(DataContainer.io.isFile(lockfile),...
        'File %s\n\tseems to be already clean: probably missing prior setDirty?',dirname)
    delete(lockfile);

end
