function status = acquireIOlock(dirname,varargin)
    assert(ischar(dirname),'dirname must be a string')
    assert(isdir(dirname),'dirname %s is not a directory or does not exist',dirname)
    lockname = '_IOlock';

    error(nargchk(1, 2, nargin, 'struct'));
    if nargin > 1
        assert(ischar(varargin{1}),'lock name is not a string');
        lockname = varargin{1};
    end

    lockdir = fullfile(dirname,lockname);
    flag = true;
    status = 0;
    while flag
        while isdir(lockdir)
            mypause();
        end
        [status msg msgid] = mkdir(lockdir);
        if status==1 & length(msg)==0 & length(msgid)==0
            flag = false;
        end
    end
    
end

function mypause()
    denom = 1000;
    fact = 10;
    if SDCpckg.inspmd
        rndmax = numlabs*fact;
    else
        rndmax = fact;
    end
    time = randi(rndmax)/denom;
    pause(time);
end
