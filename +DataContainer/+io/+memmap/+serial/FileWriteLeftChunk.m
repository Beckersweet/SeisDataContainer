function FileWriteLeftChunk(dirname,x,range,slice)
%FILEWRITELEFTCHUNK  Write serial left chunk data to binary file
%
%   FileWriteLeftChunk(DIRNAME,DATA,RANGE,SLICE) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Addtional argument is either of:
%   RANGE - A vector with two elements representing the range of
%           data that we want to write            
%   SLICE - A vector representing the specific slice that we want
%
%   Warning: If the specified dirname exists, it will be removed.
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
