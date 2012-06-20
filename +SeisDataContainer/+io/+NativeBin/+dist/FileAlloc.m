function FileAlloc(dirname,header)
%FILEALLOC Allocates binary file in the specified directory
%
%   FILEALLOC(DIRNAME,HEADER) allocates binary files for distributed writing.
%   The file sizes are specified in the header.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the file properties
%
%   Warning: If the specified file already exist,
%            it will be overwritten.

SeisDataContainer.io.isFileClean(dirname);
SeisDataContainer.io.setFileDirty(dirname);
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==1,'header is missing file distribution')

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Write header
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirname,header);
% Write file
SeisDataContainer.io.NativeBin.dist.DataAlloc(header.directories,'real',header.distribution.size,header.precision);
if header.complex
    SeisDataContainer.io.NativeBin.dist.DataAlloc(header.directories,'imag',header.distribution.size,header.precision);
end

end
