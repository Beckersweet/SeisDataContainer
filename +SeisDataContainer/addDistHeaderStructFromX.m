function header = addDistHeaderStructFromX(headerin,x)
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(isdistributed(x),'x has to be distributed');
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
    header.distribution.indx_rng = SeisDataContainer.utils.Composite2Cell(cindecies);
end
