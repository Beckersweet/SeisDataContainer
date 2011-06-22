function header = addDistHeaderStructFromX(x,hdrin)
    assert(isdistributed(x),'x has to be distributed');

    header = hdrin;
    dims = length(size(x));
    poolsize = matlabpool('size');
    cdim = Composite();
    csize = Composite();
    cpart = Composite();
    header.distribution = struct();

    spmd
        lx = getLocalPart(x);
        csize = size(lx);
        codist = getCodistributor(x);
        cdim = codist.Dimension;
        cpart = codist.Partition;
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

    minidx = ones(1,poolsize);
    for l=2:poolsize
       minidx(l) = minidx(l-1) + dpart(l-1);
    end
    header.distribution.minidx = minidx;

    maxidx = zeros(1,poolsize);
    for l=1:poolsize
       maxidx(l) = minidx(l) + dpart(l) - 1;
    end
    header.distribution.maxidx = maxidx;
end
