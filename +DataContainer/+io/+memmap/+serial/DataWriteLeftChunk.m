function DataWriteLeftChunk(dirname,filename,dimensions,x,range,slice,file_precision)
%DATAWRITE  Write serial data slice to binary file
%
%   DataWrite(DIRNAME,FILENAME,DIMENSION,DATA,RANGE,SLICE,FILE_PRECISION) writes
%   the slice (from last dimension) of the real serial array X into file DIRNAME/FILENAME.
%
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: the specified file must exist,
error(nargchk(7, 7, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision must be a string')
assert(isreal(x), 'data must be real')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
[chunk_dims, chunk_offset] =...
    DataContainer.utils.getLeftChunkInfo(dimensions,range,slice);
assert(prod(chunk_dims)==prod(size(x)),'X array does not match the given dimensions')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
x = DataContainer.utils.switchPrecisionIP(x,file_precision);
chunk_byte_offset = chunk_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{file_precision,size(x),'x'},...
        'offset',chunk_byte_offset,...
        'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
