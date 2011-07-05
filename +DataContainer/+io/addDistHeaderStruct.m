function header = addDistHeaderStruct(dimension,partition,headerin)
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(matlabpool('size')>0,'matlabpool has to open');

    header = headerin;
    dims = length(header.size);
    poolsize = matlabpool('size');
    csize = Composite();
    cindecies = Composite();
    header.distribution = struct();

    spmd
        codist = codistributor1d(dimension,partition,header.size);
        csize = header.size;
        csize(dimension) = partition(labindex);
        cindecies = codist.globalIndices(dimension);
        cindecies = [cindecies(1) cindecies(end)];
    end

    header.distribution.dim = dimension;

    for l=1:poolsize
        xsize{l} = csize{l};
    end
    header.distribution.size = xsize;

    header.distribution.partition = partition;

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
