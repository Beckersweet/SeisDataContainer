function DataWriteLeftSlice(dirname,filename,dimensions,x,slice,file_precision)
%DATAWRITELEFTSCLICE  Write serial data left slice to binary file
%
%   DataWriteLeftSlice(DIRNAME,FILENAME,DIMENSION,DATA,SLICE,FILE_PRECISION) writes
%   the slice (from last dimension) of the real serial array X into file DIRNAME/FILENAME.
%
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
error(nargchk(6, 6, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isreal(x), 'data must be real')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision must be a string')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
[slice_dims, slice_offset] =...
    DataContainer.utils.getLeftSliceInfo(dimensions,slice);
assert(prod(slice_dims)==prod(size(x)))

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
x = DataContainer.utils.switchPrecisionIP(x,file_precision);
slice_byte_offset = slice_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{file_precision,size(x),'x'},...
        'offset',slice_byte_offset,...
        'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
