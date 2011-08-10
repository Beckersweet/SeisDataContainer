function DataAlloc(dirnames,filename,dimensions,file_precision)
%DATAALLOC Allocates file for binary data
%
%   DataAlloc(DIRNAMES,FILENAME,DIMENSIONS,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   DIRNAMES       - A cell specifying the directory names
%   FILENAME       - A string specifying the file name
%   DIMENSIONS     - A vector specifying the dimensions
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%                    supported precisions: 'double', 'single'
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

% convert to composite
cdirnames = DataContainer.utils.Cell2Composite(dirnames);
cdimensions = DataContainer.utils.Cell2Composite(dimensions);

% Preallocate File
spmd
    assert(ischar(cdirnames),'dirnames{%d} is not a string',labindex)
    assert(isdir(cdirnames),'dirnames{%d} %s does not exist',labindex,dirnames{labindex})
    filename=fullfile(cdirnames,filename);
    assert(isvector(cdimensions),'dimensions{%d} is not a vector',labindex)
    DataContainer.io.allocFile(filename,prod(cdimensions),bytesize);
end

end
