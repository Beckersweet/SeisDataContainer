function idxout = sliceIndexV2S(sizes,idxin)
    assert(isvector(sizes),'sizes is not a vector')
    assert(isvector(idxin)&~isscalar(idxin),'indecies is not a vector')
    assert(length(sizes)==length(idxin),'length of sizes and indecies does not match');

    L=length(sizes);

    idxout = 1;
    for i=1:L
        assert(0<idxin(i)&idxin(i)<=sizes(i),...
            'Fatal error: slice index %d out of range(1,%d)',idxin(i),sizes(i))
        idxout = idxout + prod(sizes(1:i-1))*(idxin(i)-1);
    end
end
