function header = addDistHeaderStruct(headerin,dimension,partition)
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(isscalar(dimension),'dimensions must be a scalar')
    assert(isvector(partition)|isequal(partition,[]),'partition must be a vector or empty vector [] (for default)')
    assert(matlabpool('size')>0,'matlabpool has to open');
    assert(dimension>0&dimension<=headerin.dims,'distributed dimensions outside of arrey dimensions')

    header = headerin;
    dims = header.dims;
    poolsize = matlabpool('size');
    csize = Composite();
    cindecies = Composite();
    header.distribution = struct();
    if isequal(partition,[])
        partition = DataContainer.utils.defaultDistribution(header.size(dimension));
    end

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
