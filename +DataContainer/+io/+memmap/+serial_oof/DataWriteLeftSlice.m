function DataWriteLeftSlice(dirname,filename,dimensions,slice,x,varargin)
%DATAWRITE  Write serial data slice to binary file
%
%   DataWriteLeftSlice(DIRNAME,FILENAME,DIMENSION,SLICE,DATA,FILE_PRECISION) writes
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
[slice_dims, slice_offset] =...
    DataContainer.utils.getLeftSliceInfo(dimensions,slice);
assert(prod(slice_dims)==prod(size(x)))

% Preprocess input arguments
error(nargchk(5, 6, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>5
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    precision = varargin{1};
end;

% Set bytesize
bytesize = DataContainer.utils.getByteSize(precision);
x = DataContainer.utils.switchPrecisionIP(x,precision);
slice_byte_offset = slice_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{precision,size(x),'x'},...
        'offset',slice_byte_offset,...
        'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
