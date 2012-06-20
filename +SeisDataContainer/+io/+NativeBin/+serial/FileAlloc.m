function FileAlloc(dirname,header)
%FILEALLOC Allocates file space for header
%
%   FileAlloc(DIRNAME,HEADER) allocates file for serial writing.
%   The file size is specified in the header.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the file properties
%

SeisDataContainer.io.isFileClean(dirname);
SeisDataContainer.io.setFileDirty(dirname);
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==0,'header have file distribution for serial file alloc?')

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Write header
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirname,header);
% Write file
SeisDataContainer.io.NativeBin.serial.DataAlloc(dirname,'real',header.size,header.precision);
if header.complex
    SeisDataContainer.io.NativeBin.serial.DataAlloc(dirname,'imag',header.size,header.precision);
end

SeisDataContainer.io.setFileClean(dirname);
end
