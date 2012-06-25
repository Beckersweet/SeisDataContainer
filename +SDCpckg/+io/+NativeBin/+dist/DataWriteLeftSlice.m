function DataWriteLeftSlice(distribute,dirname,filename,x,dimensions,localsize,localindx,distdim,slice,file_precision)
%DATAREAD Reads serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DATA,DIMENSIONS,DISTRIBUTION,SLICE,FILE_PRECISION,FILE_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIRNAME      - A cell specifying the directory name
%   FILENAME     - A string specifying the file name
%   DATA         - Real data
%   DIMENSIONS   - A vector specifying the dimensions
%   LOCALSIZE    - A vector specifying the local size
%   LOCALINDX    - A vector specifying the local index range
%   DISTDIM      - A scalar with distribution dimension
%   SLICE        - A vector specifying the slice index
%   *_PRECISION  - An string specifying the precision of one unit of data,
%                  Supported precisions: 'double', 'single'
%
error(nargchk(10, 10, nargin, 'struct'));
assert(isscalar(distribute),'distributed flag must be a scalar')
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(iscodistributed(x), 'data must be distributed')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(isvector(localsize),'localsize must be a vector')
assert(isscalar(distdim), 'distribution dimension must be a scalar')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')

% Check File
filecheck=fullfile(dirname,filename);
assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);

% Write data
lx = getLocalPart(x);
lxs = size(lx);
lcsize = localsize(1:distdim);
if length(lxs)<length(lcsize); lxs(end+1) = lcsize(end); end
if length(lxs)>length(lcsize); lcsize(end+1) = lxs(end); end
assert(isequal(lcsize,lxs),...
    'distribution.size does not match the size of LocalPart')
if distribute
    SDCpckg.io.NativeBin.serial.DataWriteLeftSlice(dirname,filename,lx,...
        localsize,slice,file_precision);
else
    assert(isvector(localindx),'localindx must be a vector')
    SDCpckg.io.acquireIOlock(dirname);
    SDCpckg.io.NativeBin.serial.DataWriteLeftChunk(dirname,filename,lx,...
        dimensions,localindx,slice,file_precision);
    SDCpckg.io.releaseIOlock(dirname);
end

end
