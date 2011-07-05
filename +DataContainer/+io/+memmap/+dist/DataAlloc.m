function DataAlloc(dirnames,filename,dimensions,file_precision)
%DATAALLOC  Allocate file space for binary data
%
%   DataAlloc(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified file already exist,
%            it will be overwritten.
error(nargchk(4, 4, nargin, 'struct'));
assert(matlabpool('size')>0,'matlabpool must be open')
assert(iscell(dirnames), 'directory name must be a cell')
assert(ischar(filename), 'file name must be a string')
assert(iscell(dimensions), 'dimensions must be given as a cell')
assert(ischar(file_precision), 'file_precision must be a string')

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);

% Preallocate File
spmd
    assert(ischar(dirnames{labindex}),'dirnames{%d} is not a string',labindex)
    assert(isdir(dirnames{labindex}),'dirnames{%d} %s does not exist',labindex,dirnames{labindex})
    filename=fullfile(dirnames{labindex},filename);
    assert(isvector(dimensions{labindex}),'dimensions{%d} is not a vector',labindex)
    DataContainer.io.allocFile(filename,prod(dimensions{labindex}),bytesize);
end

end
