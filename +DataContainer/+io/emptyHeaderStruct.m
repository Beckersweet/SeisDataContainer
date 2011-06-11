function header = emptyHeaderStruct(x)
    header = struct();
    dims = length(size(x));

    header.dims = dims;
    header.size = size(x);
    header.offset = zeros(1,dims);
    header.interval = ones(1,dims);

    header.precision = DataContainer.utils.getPrecision(x);
    header.complex = ~isreal(x);

    for i=1:dims % units
        u(i) = {['u',int2str(i)]};
    end
    header.unit = u;
    for i=1:dims % labels
        l(i) = {['l',int2str(i)]};
    end
    header.label = l;

end
