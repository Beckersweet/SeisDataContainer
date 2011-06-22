function FileWriteLeftSlice(dirname,x,slice)
%FILEWRITE  Write serial data to binary file
%
%   FileWriteLeftSlice(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
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
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Read header
header = load(fullfile(dirname,'header.mat'));

% Write file
DataContainer.io.memmap.serial_oof.DataWriteLeftSlice(dirname,'real',...
    header.size,real(x),slice,header.precision);
if ~isreal(x)
    DataContainer.io.memmap.serial_oof.DataWriteLeftSlice(dirname,'imag',...
        header.size,imag(x),slice,header.precision);
end

end
