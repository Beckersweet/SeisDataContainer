function [dims, origin] = getLeftSliceInfo(dimensions,slice)
% getSliceInfo returns slice information
%
%   [SLICE_DIMS, SLICE_ORIGIN] = getLeftSliceInfo(dimensions,slice)
%   where:
%        dimensions - file data dimensiosn
%        slice indecies
%
%   Note: slice indecies have to be in last dimesions
%
    assert(isvector(dimensions), 'dimensions must be a vector')
    assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

    l_s = length(slice);
    dims = dimensions(1:end-l_s);
    l_d = length(dims);
    rdims = dimensions(end-l_s+1:end);
    origin=0;
    if isequal(slice,[])
        return
    end

    for i=1:l_s
        assert(0<slice(i)&slice(i)<=rdims(i),...
            'Fatal error: slice index %d out of range(1,%d)',slice(i),rdims(i))
        ldims = dimensions(1:l_d+i-1);
        origin = origin + prod(ldims)*(slice(i)-1);
    end
end
