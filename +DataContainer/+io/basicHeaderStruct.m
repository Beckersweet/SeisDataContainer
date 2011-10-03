function header = basicHeaderStruct(xsize,xprecision,xcomplex)
    header = struct();
    dims = length(xsize);

    header.variable = 'unknown';
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

    header.distributed = 0;

end
