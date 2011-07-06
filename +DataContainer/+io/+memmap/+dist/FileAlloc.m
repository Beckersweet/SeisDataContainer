function FileAlloc(dirname,header)
%FILEALLOC  Allocate binary file in the specified directory
%
%   FILEALLOC(DIRNAME,HEADER) Allocate binary file in the specified
%   directory. The file size is specified in the header.
%   Warning: If the specified file already exist,
%            it will be overwritten.

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributed==1,'header is missing file distribution')

% Write file
DataContainer.io.memmap.dist.DataAlloc(header.directories,'real',header.distribution.size,header.precision);
if header.complex
    DataContainer.io.memmap.dist.DataAlloc(header.directories,'imag',header.distribution.size,header.precision);
end
% Write header
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

end
