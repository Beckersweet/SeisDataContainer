function DataWriteLeftSlice(distribute,dirnames,filename,x,dimensions,distribution,slice,file_precision)
%DATAREAD  Read serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%   *_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
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
end

spmd
    % Check File
    filecheck=fullfile(dirname,filename);
    assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);
    % write data
    lx = getLocalPart(x);
    assert(isequal(distribution.size{labindex}(1:distribution.dim),size(lx)),...
        'distribution.size does not match the size of LocalPart')
    if distribute
        DataContainer.io.memmap.serial.DataWriteLeftSlice(dirname,filename,distribution.size{labindex},lx,...
            slice,file_precision);
    else
        DataContainer.io.acquireIOlock(dirname);
        DataContainer.io.memmap.serial.DataWriteLeftChunk(dirname,filename,...
            dimensions,lx,[distribution.min_indx(labindex) distribution.max_indx(labindex)],slice,file_precision);
        DataContainer.io.releaseIOlock(dirname);
    end
end

end
