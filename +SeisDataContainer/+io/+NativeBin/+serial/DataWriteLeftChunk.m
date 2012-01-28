function DataWriteLeftChunk(dirname,filename,x,dimensions,range,slice,file_precision)
%DATAWRITELEFTCHUNCK Writes serial data left chunck to binary file
%
%   DataWriteLeftChunk(DIRNAME,FILENAME,DATA,DIMENSIONS,RANGE,SLICE,FILE_PRECISION) writes
%   the chunk (from last dimension) of the real serial array X into file DIRNAME/FILENAME.
%
%   DIRNAME        - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DATA           - Non-distributed real data
%   DIMENSIONS     - A vector specifying the dimensions
%   RANGE          - A vector with two elements specifying the range of data
%   SLICE          - A vector specifying the slice index
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%                    Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
error(nargchk(7, 7, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(~isdistributed(x), 'data must not be distributed')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision must be a string')

% Setup variables
[chunk_dims, chunk_origin] =...
    SeisDataContainer.utils.getLeftChunkInfo(dimensions,range,slice);
assert(prod(chunk_dims)==prod(size(x)),'X array does not match the given dimensions')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = SeisDataContainer.utils.getByteSize(file_precision);
x = SeisDataContainer.utils.switchPrecisionIP(x,file_precision);
chunk_byte_origin = chunk_origin*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Write local data
fid = fopen(filename,'r+');
fseek(fid,chunk_byte_origin,-1);
fwrite(fid,x(:),file_precision);
fclose(fid);

end
