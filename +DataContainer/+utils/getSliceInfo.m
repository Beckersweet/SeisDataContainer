function [dims, offset] = getSliceInfo(dimensions,slice)
% getSliceInfo returns slice information
%
%   [SLICE_DIMS, SLICE_OFFSET] = getSliceInfo(dimensions,slice)
%   where:
%        dimensions - file data dimensiosn
%        slice indecies
%
%   Note: slice indecies have to be in last dimesions
%
    assert(isvector(dimensions), 'dimensions must be a vector')
    assert(isvector(slice), 'slice index must be a vector')

    ls = length(slice);
    dims = dimensions(1:end-ls);
    ld = length(dims);
    rdims = dimensions(end-ls+1:end);

    offset=0;
    for i=1:ls
        assert(0<slice(i)&slice(i)<=rdims(i),...
	    'Fatal error: slice index %d out of range(1,%d)',slice(i),rdims(i))
	ldims = dimensions(1:ld+i-1);
	offset = offset + prod(ldims)*(slice(i)-1);
    end
end
