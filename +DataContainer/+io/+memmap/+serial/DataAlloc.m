function DataAlloc(dirname,filename,dimensions,varargin)
%DATAALLOC  Allocate file space for binary data
%
%   DataAlloc(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION) allocates
%   binary file for serial data writing.
%   Optional parameter:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified file already exist,
%            it will be overwritten.
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')

% Setup variables
precision = 'double';

% Preprocess input arguments
error(nargchk(3, 4, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>3
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    precision = varargin{1};
end;

% Set bytesize
bytesize = DataContainer.utils.getByteSize(precision);

% Preallocate File
DataContainer.io.allocFile(filename,prod(dimensions),bytesize);

end
