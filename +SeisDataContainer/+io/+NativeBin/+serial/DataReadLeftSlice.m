function x = DataReadLeftSlice(dirname,filename,dimensions,slice,file_precision,x_precision)
%DATAREADLEFTSLICE Reads left slice from binary file
%
%   X = DataReadLeftSlice(DIRNAME,FILENAME,DIMENSIONS,SLICE,FILE_PRECISION,X_PRECISION) reads
%   the slice (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   SLICE       - A vector specifying the slice index
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
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
[slice_dims, slice_origin] =...
    SeisDataContainer.utils.getLeftSliceInfo(dimensions,slice);

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = SeisDataContainer.utils.getByteSize(file_precision);
slice_byte_origin = slice_origin*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Read local data
fid = fopen(filename,'r');
fseek(fid,slice_byte_origin,-1);
x = fread(fid,prod(slice_dims),file_precision);
if length(slice_dims)>1
    x = reshape(x,slice_dims);
end
fclose(fid);

% swap x_precision
x = SeisDataContainer.utils.switchPrecisionIP(x,x_precision);

end
