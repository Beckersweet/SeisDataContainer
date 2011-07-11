function FileAlloc(dirname,header)
%FILEALLOC Allocates file space for header
%
%   FileAlloc(DIRNAME,HEADER) allocates file for serial header writing.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributed==0,'header have file distribution for serial file alloc?')

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Write file
DataContainer.io.memmap.serial.DataAlloc(dirname,'real',header.size,header.precision);
if header.complex
    DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',header.size,header.precision);
end
% Write header
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

end
