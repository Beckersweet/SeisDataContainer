function status = acquireIOlock(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    assert(isdir(dirname),'dirname %s is not a directory or does not exist',dirname)
    lockname = '_IOlock';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'lock name is not a string');
        lockname = varargin{1};
    end

    lockfile = fullfile(dirname,lockname);
    flag = true;
    status = 0;
    while flag
        while isdir(lockfile)
            mypause();
        end
        [status msg msgid] = mkdir(lockfile);
        if status==1 & length(msg)==0 & length(msgid)==0
            flag = false;
        end
    end
    
end

function mypause()
    time = rand();
    pause(time);
end
