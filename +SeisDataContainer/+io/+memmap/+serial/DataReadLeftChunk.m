function x = DataReadLeftChunk(dirname,filename,dimensions,range,slice,file_precision,x_precision)
%DATAREADLEFTCHUNCK Reads left chunck from binary file
%
%   X = DataReadLeftChunk(DIRNAME,FILENAME,DIMENSIONS,RANGE,SLICE,FILE_PRECISION,X_PRECISION)
%   reads the chunk (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   RANGE       - A vector with two elements specifying the range of data
%   SLICE       - A vector specifying the slice index
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
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
[chunk_dims, chunk_origin] =...
    SeisDataContainer.utils.getLeftChunkInfo(dimensions,range,slice);

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = SeisDataContainer.utils.getByteSize(file_precision);
chunk_byte_origin = chunk_origin*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Read local data
fid = fopen(filename,'r');
fseek(fid,chunk_byte_origin,-1);
x = fread(fid,prod(chunk_dims),file_precision);
if length(chunk_dims)>1
    x = reshape(x,chunk_dims);
end
fclose(fid);

% swap x_precision
x = SeisDataContainer.utils.switchPrecisionIP(x,x_precision);

end
