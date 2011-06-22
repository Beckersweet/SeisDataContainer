function FileAlloc(dirname,header)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%
%   HEADER_STRUCT - An optional header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')

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
save(fullfile(dirname,'header.mat'),'-struct','header');

end
