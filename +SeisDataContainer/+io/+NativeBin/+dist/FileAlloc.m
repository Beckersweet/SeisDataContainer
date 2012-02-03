function FileAlloc(dirname,header)
%FILEALLOC Allocates binary file in the specified directory
%
%   FILEALLOC(DIRNAME,HEADER) Allocates binary file in the specified
%   directory. The file size is specified in the header.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%
%   Warning: If the specified file already exist,
%            it will be overwritten.

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==1,'header is missing file distribution')

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Write file
SeisDataContainer.io.NativeBin.dist.DataAlloc(header.directories,'real',header.distribution.size,header.precision);
if header.complex
    SeisDataContainer.io.NativeBin.dist.DataAlloc(header.directories,'imag',header.distribution.size,header.precision);
end
% Write header
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirname,header);

end
