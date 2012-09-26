function h = getHeaderLeftChunk(header,index)
%GETHEADERLEFTCHUNK subsref for headers
%   H = getHeaderLeftChunk(HEADER,INDEX) returns the header corresponding
%   to the data container indexed according to INDEX. Index has to be a
%   scalar or 1xn array of scalars or a 2xn array of scalars. Please refer
%   below for specific use cases:
%
%   Left Slice indexing:
%   H = getHeaderLeftChunk(HEADER,i) returns the header H corresponding to
%   the ith slice of the parent header (eg. if this is 5D data
%   container we will assume the index is (:,:,:,:,i) )
%
%   H = getHeaderLeftChunk(HEADER,[ i1 i2 i3 ] returns the header H
%   corresponding to the slices indices [ i1 i2 i3] (eg. if this is 5D data
%   we will assume the index is (:,:,i1,i2,i3) ). NOTE: the length of INDEX
%   here has to be equal or less than the total number of implicit 
%   dimensions according to parent header HEADER (ie. length of 
%   HEADER.size). Also it goes without saying that it has to be of length 
%   at least one.
%
%   Left Chunk indexing:
%   H = getHeaderLeftChunk(HEADER, [ i1, i2, i3; f1, f2, f3 ] ) returns a
%   header chunk H corresponding to the indices (assuming 5D data),
%   (:, :, i1:f1, i2, i3). Due to the fact that we only support contiguous
%   indexing in out-of-core operations we will not be parsing f2 and f3 and
%   will pretend that i2 and i3 are slice indices only. Though in general
%   it is good practice (also aesthetically pleasing) to pass in the index
%   with f2 = i2, f3 = i3... and so forth. 

% setup variables
isize   = header.size;
origin  = header.origin;
delta   = header.delta;
unit    = header.unit;
label   = header.label;

% Calculate new last dimension
lastdim = length(isize) - size(index,2);

% Calculate chunk size
if size(index,1) == 2
    chunksize = index(2,1) - index(1,1) + 1;
elseif size(index,1) == 1
    chunksize = 1;
else
    error('index can only be a 1xn or 2xn array');
end

% Fill in the new ranges
h        = header;
h.dims   = lastdim;
h.size   = isize(1:lastdim);
h.origin = origin(1:lastdim);
h.delta  = delta(1:lastdim);
h.unit   = unit(1:lastdim);
h.label  = label(1:lastdim);
% If chunk indexed
if size(index,1) == 2
    h.size(end)   = chunksize;
    h.origin(end) = h.origin(end) + index(1,1)*h.delta(end);
end