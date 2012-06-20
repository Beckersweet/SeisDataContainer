function FileAlloc(dirname,header)
%FILEALLOC Allocates file space for header
%
%   FileAlloc(DIRNAME,HEADER) allocates file for serial writing.
%   The file size is specified in the header.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the file properties
%

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==0,'header have file distribution for serial file alloc?')
SDCpckg.io.isFileClean(dirname);
SDCpckg.io.setFileDirty(dirname);

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Write header
SDCpckg.io.NativeBin.serial.HeaderWrite(dirname,header);
% Write file
SDCpckg.io.NativeBin.serial.DataAlloc(dirname,'real',header.size,header.precision);
if header.complex
    SDCpckg.io.NativeBin.serial.DataAlloc(dirname,'imag',header.size,header.precision);
end

SDCpckg.io.setFileClean(dirname);
end
