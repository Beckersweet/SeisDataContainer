function DataWriteLeftChunk(dirname,filename,dimensions,range,slice,x,varargin)
%DATAWRITE  Write serial data slice to binary file
%
%   DataWrite(DIRNAME,FILENAME,DIMENSION,range,SLICE,DATA,FILE_PRECISION) writes
%   the slice (from last dimension) of the real serial array X into file DIRNAME/FILENAME.
%   Addtional parameter:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified file must exist,
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isvector(slice), 'slice index must be a vector')
assert(isreal(x), 'data must be real')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
precision = 'double';
[chunk_dims, chunk_offset] =...
    DataContainer.utils.getLeftChunkInfo(dimensions,range,slice);
assert(prod(chunk_dims)==prod(size(x)),'X array does not match the given dimensions')

% Preprocess input arguments
error(nargchk(6, 7, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>6
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    precision = varargin{1};
end;

% Set bytesize
bytesize = DataContainer.utils.getByteSize(precision);
x = DataContainer.utils.switchPrecision(x,precision);
chunk_byte_offset = chunk_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{precision,size(x),'x'},...
        'offset',chunk_byte_offset,...
        'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
