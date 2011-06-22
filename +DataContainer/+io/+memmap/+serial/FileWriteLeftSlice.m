function FileWriteLeftSlice(dirname,x,slice)
%FILEWRITE  Write serial data to binary file
%
%   FileWriteLeftSlice(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   Warning: If the specified dirname will be removed,
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Read header
header = load(fullfile(dirname,'header.mat'));

% Write file
DataContainer.io.memmap.serial.DataWriteLeftSlice(dirname,'real',...
    header.size,real(x),slice,header.precision);
if ~isreal(x)
    DataContainer.io.memmap.serial.DataWriteLeftSlice(dirname,'imag',...
        header.size,imag(x),slice,header.precision);
end

end
