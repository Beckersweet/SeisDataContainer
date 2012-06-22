function DataWrite(distribute,dirname,filename,x,localsize,localindx,file_precision)
%DATAWRITE Writes serial data to binary file
%
%   DataWrite(DISTRIBUTE,DIRNAMES,FILENAME,DATA,DISTRIBUTION,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   DISTRIBUTE     - A scalar that takes 1 for distribute or 0 for no distribute
%   DIRNAMES       - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DATA           - Distributed real data
%   LOCALSIZE      - A vector specifying the local size
%   LOCALINDX      - A vector specifying the local index range
%   DISTRIBUTION   - A header struct specifying the distribution
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%                    Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
error(nargchk(7, 7, nargin, 'struct'));
assert(isscalar(distribute),'distribute flag must be a scalar')
assert(ischar(dirname), 'directory names must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(iscodistributed(x), 'data must be distributed')
assert(isvector(localsize),'localsize must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')

% Check File
filecheck=fullfile(dirname,filename);
assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);

% Write data
lx = getLocalPart(x);
lxs = size(lx);
if length(lxs)<length(localsize); lxs(end+1) = 1; end
assert(isequal(localsize,lxs),'distribution.size does not match the size of LocalPart')
if distribute
    SDCpckg.io.NativeBin.serial.DataWrite(dirname,filename,lx,file_precision);
else
    assert(isvector(localindx),'localindx must be a vector')
    SDCpckg.io.acquireIOlock(dirname);
    SDCpckg.io.NativeBin.serial.DataWriteLeftChunk(dirname,filename,lx,...
        size(x),localindx,[],file_precision);
    SDCpckg.io.releaseIOlock(dirname);
end

end
