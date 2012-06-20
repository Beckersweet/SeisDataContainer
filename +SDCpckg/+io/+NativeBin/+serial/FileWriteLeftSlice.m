function FileWriteLeftSlice(dirname,x,slice)
%FILEWRITELEFTSLICE  Write serial left slice data to binary file
%
%   FileWriteLeftSlice(DIRNAME,DATA,SLICE) writes
%   the real serial left slice into DIRNAME/FILENAME.
%
%   DIRNAME  - A string specifying the directory name
%   DATA     - Non-distributed float data
%   SLICE    - A vector specifying the slice index
%
%   Warning: If the specified dirname exists, it will be removed

SDCpckg.io.isFileClean(dirname);
SDCpckg.io.setFileDirty(dirname);
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Read header
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);

% Write file
SDCpckg.io.NativeBin.serial.DataWriteLeftSlice(dirname,'real',real(x),...
    header.size,slice,header.precision);
if ~isreal(x)
    SDCpckg.io.NativeBin.serial.DataWriteLeftSlice(dirname,'imag',imag(x),...
        header.size,slice,header.precision);
end
SDCpckg.io.setFileClean(dirname);
end
