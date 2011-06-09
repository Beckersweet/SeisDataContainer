function rmDistTmpDir(tmpdir,tmpdirs)
%   rmDistTmpDir deletes temporary directories
%                on master and worker processes
%
%   rmDistTmpDir(tmpdir,tmpdirs) takes the following:
%   - TMPDIR: temporary directory on master process
%   - TMPDIRS: composite of temporary directories on workers
%
%   Note: rmDistTmpDir will not clean TMPDIRS if called after
%         closing matlabpool
%
    assert(ischar(tmpdir),'Fatal error: first argument is not a string');
    if isdir(tmpdir)
        status = rmdir(tmpdir,'s');
	if ~status; warning('Warning: error while removing directory %s on master',tmpdir); end;
    else
        warning('Warning: directory %s does not exist on master',tmpdir);
    end

    if matlabpool('size') > 0
        assert(isa(tmpdirs,'Composite'),'Fatal error: 2nd argument is not a Composite');
	assert(length(tmpdirs)==matlabpool('size'),...
	    'Fatal error: matlabpool size does not match tmpdirs length');
        spmd
            if isdir(tmpdirs)
                status = rmdir(tmpdirs,'s');
	        if ~status; warning('Warning: error while removing directory %s on lab %d',tmpdirs,labindex); end;
	    else
	        warning('Warning: directory %s does not exist on lab %d',tmpdirs,labindex);
            end
        end
    else
    	warning('Warning: called outside of matlabpool/batch call');
    end
end
