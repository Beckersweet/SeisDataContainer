function DataWriteLeftSlice(distribute,dirnames,filename,x,dimensions,distribution,slice,file_precision)
%DATAREAD Reads serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DATA,DIMENSIONS,DISTRIBUTION,SLICE,FILE_PRECISION,FILE_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIRNAME      - A cell specifying the directory name
%   FILENAME     - A string specifying the file name
%   DATA         - Real data
%   DIMENSIONS   - A vector specifying the dimensions
%   DISTRIBUTION - A header struct specifying the distribution
%   SLICE        - A vector specifying the slice index
%   *_PRECISION  - An string specifying the precision of one unit of data,
%                  Supported precisions: 'double', 'single'
%
error(nargchk(8, 8, nargin, 'struct'));
assert(isscalar(distribute),'distributed flag must be a scalar')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(isreal(x), 'data must be real')
assert(isstruct(distribution), 'distribution must be a headser struct')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(matlabpool('size')>0,'matlabpool must be open')
if distribute
    assert(iscell(dirnames), 'directory names must be a cell')
    dirname = DataContainer.utils.Cell2Composite(dirnames);
else
    assert(ischar(dirnames), 'directory name must be a string')
    dirname = dirnames;
    cindx_rng = DataContainer.utils.Cell2Composite(distribution.indx_rng);
end
csize = DataContainer.utils.Cell2Composite(distribution.size);

spmd
    % Check File
    filecheck=fullfile(dirname,filename);
    assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);
    % write data
    lx = getLocalPart(x);
    if distribution.dim==1
        assert(isequal([csize(1:distribution.dim) 1],size(lx)),...
            'distribution.size does not match the size of LocalPart')
    else
        assert(isequal(csize(1:distribution.dim),size(lx)),...
            'distribution.size does not match the size of LocalPart')
    end
    if distribute
        DataContainer.io.memmap.serial.DataWriteLeftSlice(dirname,filename,lx,...
            csize,slice,file_precision);
    else
        DataContainer.io.acquireIOlock(dirname);
        DataContainer.io.memmap.serial.DataWriteLeftChunk(dirname,filename,lx,...
            dimensions,cindx_rng,slice,file_precision);
        DataContainer.io.releaseIOlock(dirname);
    end
end

end
