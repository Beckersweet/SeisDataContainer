function verifyHeaderStructWithX(header,x)
    xsize = size(x);
    xcomplex = ~isreal(x);
    dims = length(xsize);

    assert(header.dims==dims,'Fatal error: wrong header.dims')
    assert(norm(header.size-xsize)==0,'Fatal error: wrong header.size')
    assert(length(header.origin)==dims,'Fatal error: wrong header.origin')
    assert(length(header.delta)==dims,'Fatal error: wrong header.delta');

    assert(strcmp(header.precision,'single')|...
           strcmp(header.precision,'double'),'Fatal error: wrong header.precision');
    assert(header.complex==xcomplex,'Fatal error: wrong header.complex');

    assert(length(header.unit)==dims,'Fatal error: wrong header.unit');
    assert(length(header.label)==dims,'Fatal error: wrong header.label');
end
