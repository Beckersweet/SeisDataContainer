function DataWrite(distribute,dirnames,filename,x,distribution,file_precision)
%DATAWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,FILENAME,DATA,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
error(nargchk(6, 6, nargin, 'struct'));
assert(isscalar(distribute),'distribute flag must be a scalar')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(isdistributed(x), 'data must be distributed')
assert(ischar(file_precision), 'file_precision name must be a string')
if distribute
    assert(iscell(dirnames), 'directory names must be a cell')
    dirname = DataContainer.utils.Cell2Composite(dirnames);
else
    assert(ischar(dirnames), 'directory name must be a string')
    dirname = dirnames;
end
distribution

spmd
    % Check File
    filecheck=fullfile(dirname,filename);
    assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);
    % write data
    lx = getLocalPart(x);
    assert(isequal(distribution.size{labindex},size(lx)),'distribution.size does not match the size of LocalPart')
    if distribute
        DataContainer.io.memmap.serial.DataWrite(dirname,filename,lx,file_precision);
    else
        DataContainer.io.acquireIOlock(dirname);
        DataContainer.io.memmap.serial.DataWriteLeftChunk(dirname,filename,...
            size(x),lx,[distribution.min_indx(labindex) distribution.max_indx(labindex)],[],file_precision);
        DataContainer.io.releaseIOlock(dirname);
    end
end

end
