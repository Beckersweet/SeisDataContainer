function FileWriteLeftChunk(dirname,x,range,slice)
%FILEWRITE  Write serial data to binary file
%
%   FileWriteLeftChunk(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Addtional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to type of x
%               Supported precisions: 'double', 'single'
%   HEADER_STRUCT - An optional header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Read header
header = DataContainer.io.memmap.serial.HeaderRead(dirname);

% Write file
DataContainer.io.memmap.serial.DataWriteLeftChunk(dirname,'real',...
    header.size,real(x),range,slice,header.precision);
if ~isreal(x)
    DataContainer.io.memmap.serial.DataWriteLeftChunk(dirname,'imag',...
        header.size,imag(x),range,slice,header.precision);
end

end
