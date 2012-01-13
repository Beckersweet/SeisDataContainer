function FileAlloc(dirname,header)
%FILEALLOC Allocates file space for header
%
%   FileAlloc(DIRNAME,HEADER) allocates file for serial header writing.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%

DataContainer.io.isFileClean(dirname);
DataContainer.io.setFileDirty(dirname);
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==0,'header have file distribution for serial file alloc?')

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Write file
DataContainer.io.memmap.serial.DataAlloc(dirname,'real',header.size,header.precision);
if header.complex
    DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',header.size,header.precision);
end
% Write header
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

DataContainer.io.setFileClean(dirname);
end
