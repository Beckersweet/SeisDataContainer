function x = DataRead(distributed,dirname,filename,dimensions,localsize,localidx,distdim,partition,file_precision,x_precision)
%DATAREAD Reads serial data from binary file
%
%   X = DataRead(DISTRIBUTED,DIRNAMES,FILENAME,DIMENSIONS,DISTRIBUTION,FILE_PRECISION,X_PRECISION)
%   reads the serial real array X from file DIRNAME/FILENAME.
%
%   DISTRIBUTED  - 1 for distributed or 0 otherwise
%   DIRNAMES     - A string specifying the directory name
%   FILENAME     - A string specifying the file name
%   DIMENSIONS   - A vector specifying the dimensions
%   LOCALSIZE    - A vector specifying the local size
%   LOCALINDX    - A vector specifying the local index range
%   DISTDIM      - A scalar with distribution dimension
%   PARTITION    - A vector holding partition
%   *_PRECISION  - An string specifying the precision of one unit of data,
%                  Supported precisions: 'double', 'single'
%
error(nargchk(10, 10, nargin, 'struct'));
assert(isscalar(distributed),'distributed flag must be a scalar')
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(isscalar(distdim), 'distribution dimension must be a scalar')
assert(isvector(partition), 'distribution partition be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')

% Check File
filecheck=fullfile(dirname,filename);
assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);

% Read data
if distributed
    assert(isvector(localsize), 'local sizes must be a vector')
    lx = SDCpckg.io.NativeBin.serial.DataRead(dirname,filename,localsize,file_precision,x_precision);
else
    assert(isvector(localidx), 'local index range must be a vector')
    lx = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(dirname,filename,...
        dimensions,localidx,[],file_precision,x_precision);
end
codist = codistributor1d(distdim,partition,dimensions);
% 'noCommunication' below is faster but dangerous
x = codistributed.build(lx,codist,'noCommunication');

% Check dimensions
assert(isequal(dimensions,size(x)),'dimensions does not match the size of codistributed x')

end
