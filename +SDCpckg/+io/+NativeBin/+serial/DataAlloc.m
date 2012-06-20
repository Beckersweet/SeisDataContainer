function DataAlloc(dirname,filename,dimensions,file_precision)
%DATAALLOC Allocates file space for binary data
%
%   DataAlloc(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   DIRNAME        - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DIMENSIONS     - A vector specifying the dimensions
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%                    Supported precisions: 'double', 'single'
%
%   Warning: If the specified file already exists, it will be overwritten.
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'dirname must be a string')
assert(isdir(dirname),'dirname %s does not exist',dirname)
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision must be a string')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Set bytesize
bytesize = SDCpckg.utils.getByteSize(file_precision);

% Preallocate File
SDCpckg.io.allocFile(filename,prod(dimensions),bytesize);

end
