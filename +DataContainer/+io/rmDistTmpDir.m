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
    if isdir(tmpdir)
        rmdir(tmpdir,'s');
    end

    if matlabpool('size') > 0 & isa(tmpdirs,'Composite')
	assert(length(tmpdirs)==matlabpool('size'),'Fatal error: matlabpool size does not match tmpdirs length')
        spmd
            if isdir(tmpdirs)
                rmdir(tmpdirs,'s');
            end
        end
    end
end
