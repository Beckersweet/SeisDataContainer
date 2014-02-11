function verifyHeaderStructWithX(header,x)
    xsize = size(x);
    xcomplex = ~isreal(x);
    dims = length(xsize);
    
    if length(xsize)==2 && (xsize(1) == 1 || xsize(2) == 1) % 1-D case
        assert(header.dims==1,'Fatal error: wrong header.dims')
        assert(norm(header.size-xsize)==0,'Fatal error: wrong header.size')
        assert(length(header.origin)==1,'Fatal error: wrong header.origin')
        assert(length(header.delta)==1,'Fatal error: wrong header.delta');
    else % not 1-D case
        assert(header.dims==dims,'Fatal error: wrong header.dims')
        assert(norm(header.size-xsize)==0,'Fatal error: wrong header.size')
        assert(length(header.origin)==dims,'Fatal error: wrong header.origin')
        assert(length(header.delta)==dims,'Fatal error: wrong header.delta');
    end
    assert(strcmp(header.precision,'single')|...
           strcmp(header.precision,'double'),'Fatal error: wrong header.precision');
    assert(header.complex==xcomplex,'Fatal error: wrong header.complex');
    
    if length(xsize)==2 && (xsize(1) == 1 || xsize(2) == 1) % 1-D case
        assert(length(header.unit)==1,'Fatal error: wrong header.unit');
        assert(length(header.label)==1,'Fatal error: wrong header.label');
    else % not 1-D case
        assert(length(header.unit)==dims,'Fatal error: wrong header.unit');
        assert(length(header.label)==dims,'Fatal error: wrong header.label');
    end
end
