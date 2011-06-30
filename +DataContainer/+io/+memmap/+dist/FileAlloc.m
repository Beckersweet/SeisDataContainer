function FileAlloc(dirname,header)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%
%   HEADER_STRUCT - A header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
error(nargchk(2, 2, nargin, 'struct'));
assert(matlabpool('size')>0,'matlabpool must be running')
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
