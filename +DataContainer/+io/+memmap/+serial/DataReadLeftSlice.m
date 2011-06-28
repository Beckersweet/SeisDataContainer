function x = DataReadLeftSlice(dirname,filename,dimensions,slice,file_precision,x_precision)
%DATAREADLEFTSLICE  Reads left slice from binary file
%
%   X = DataReadLeftSlice(DIRNAME,FILENAME,DIMENSIONS,SLICE,FILE_PRECISION,X_PRECISION) reads
%   the slice (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%
%   *_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
error(nargchk(6, 6, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')

% Setup variables
x_precision = 'double';
[slice_dims, slice_offset] =...
    DataContainer.utils.getLeftSliceInfo(dimensions,slice);

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
slice_byte_offset = slice_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{file_precision,slice_dims,'x'},...
        'offset',slice_byte_offset,...
        'writable', false);
        
% Read local data
x = M.data(1).x;
        
% swap x_precision
x = DataContainer.utils.switchPrecisionIP(x,x_precision);

end
