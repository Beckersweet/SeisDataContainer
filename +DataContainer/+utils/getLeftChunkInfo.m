function [cdims, offset] = getLeftChunkInfo(dimensions,range,slice)
% getSliceInfo returns slice information
%
%   [CHUNK_DIMS, CHUNK_OFFSET] = getLeftChunkInfo(dimensions,range,slice)
%   where:
%        dimensions - file data dimensiosn
%        range - chunk's index range
%        slice - slice indecies
%
%   Note: slice indecies have to be in last dimesions
%
    assert(isvector(dimensions), 'dimensions must be a vector')
    assert(isvector(range)&length(range)==2, 'chunk range must be a vector with two elements')
    assert(range(2)>=range(1),'range indecies must be sorted')
    assert(isvector(slice), 'slice index must be a vector')

    cslice = [range(1) slice];
    l_s = length(cslice);
    sdims = dimensions(1:end-l_s);
    l_sd = length(sdims);
    assert(1<=range(1),'left range index %d is smaller than 1',range(1))
    assert(range(2)<=dimensions(l_sd+1),'right range index %d is biger than %d',range(2),dimensions(l_sd+1))
    csize = range(2)-range(1)+1;
    cdims = [sdims csize];
    rdims = dimensions(end-l_s+1:end);
    offset=0;

    % chunk offset
    for i=1:l_s
        assert(0<cslice(i)&cslice(i)<=rdims(i),...
	    'Fatal error: slice index %d out of range(1,%d)',cslice(i),rdims(i))
	ldims = dimensions(1:l_sd+i-1);
	offset = offset + prod(ldims)*(cslice(i)-1);
    end
end
