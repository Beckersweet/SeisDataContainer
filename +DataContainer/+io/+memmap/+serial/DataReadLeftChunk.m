function x = DataReadLeftChunk(dirname,filename,dimensions,range,slice,file_precision,x_precision)
%DATAWRITE  Write serial data slice to binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,range,SLICE,FILE_PRECISION,X_PRECISION) reads
%   the slice (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%
%   *_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
error(nargchk(7, 7, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')

% Setup variables
[chunk_dims, chunk_offset] =...
    DataContainer.utils.getLeftChunkInfo(dimensions,range,slice);

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
chunk_byte_offset = chunk_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{file_precision,chunk_dims,'x'},...
        'offset',chunk_byte_offset,...
        'writable', false);
        
% Read local data
x = M.data(1).x;
        
% swap x_precision
x = DataContainer.utils.switchPrecisionIP(x,x_precision);

end
