function idxout = sliceIndexS2V(sizes,idxin)
    assert(isvector(sizes),'sizes is not a vector')
    assert(isscalar(idxin),'index is not a scalar')
    assert(0<idxin&idxin<=prod(sizes),'index out of range')

    L=length(sizes);
    idxout = zeros(1,L);

    for i=L:-1:1
        idxout(i) = floor((idxin-1)/prod(sizes(1:i-1)))+1;
        assert(0<idxout(i)&idxout(i)<=sizes(i),...
            'Fatal error: slice index %d out of range(1,%d)',idxout(i),sizes(i))
        idxin = idxin-prod(sizes(1:i-1))*(idxout(i)-1);
    end
end
