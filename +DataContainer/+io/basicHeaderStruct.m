<<<<<<< HEAD
function header = basicHeaderStruct(xsize,xprecision,xcomplex,xdistributed)
=======
function header = minimalHeaderStruct(xsize,xprecision,xcomplex,xdistributed)
>>>>>>> ea79f1c65b83917a20fd5cd3f1df7cba8bc28bea
    header = struct();
    dims = length(xsize);

    header.dims = dims;
    header.size = xsize;
    header.offset = zeros(1,dims);
    header.interval = ones(1,dims);

    header.precision = xprecision;
    header.complex = xcomplex;

    for i=1:dims % units
        u(i) = {['u',int2str(i)]};
    end
    header.unit = u;
    for i=1:dims % labels
        l(i) = {['l',int2str(i)]};
    end
    header.label = l;

    header.distributed = xdistributed;
    header.distribution = struct();
    header.distribution.dim = nan;
    header.distribution.distribution = nan;
    header.distribution.location =nan;

end
