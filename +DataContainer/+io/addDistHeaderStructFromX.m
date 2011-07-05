function header = addDistHeaderStructFromX(x,headerin)
    assert(isdistributed(x),'x has to be distributed');
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(matlabpool('size')>0,'matlabpool has to open');

    header = headerin;
    dims = length(size(x));
    poolsize = matlabpool('size');
    cdim = Composite();
    csize = Composite();
    cpart = Composite();
    cindecies = Composite();
    header.distribution = struct();

    spmd
        codist = getCodistributor(x);
        cdim = codist.Dimension;
        cpart = codist.Partition;
        csize = header.size;
        csize(cdim) = cpart(labindex);
        cindecies = codist.globalIndices(cdim);
        cindecies = [cindecies(1) cindecies(end)];
    end

    ddim = cdim{1};
    header.distribution.dim = ddim;

    for l=1:poolsize
        dummy = csize{l};
        while length(dummy) < dims
            dummy(end+1) = 1;
        end
        xsize{l} = dummy;
    end
    header.distribution.size = xsize;

    dpart = cpart{1};
    header.distribution.partition = dpart;

    min_indx = ones(1,poolsize);
    max_indx = zeros(1,poolsize);
    for l=1:poolsize
       dummy = cindecies{l};
       min_indx(l) = dummy(1);
       max_indx(l) = dummy(2);
    end
    header.distribution.min_indx = min_indx;
    header.distribution.max_indx = max_indx;
end
