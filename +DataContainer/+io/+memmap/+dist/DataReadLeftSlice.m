function x = DataReadLeftSlice(distributed,dirnames,filename,dimensions,distribution,slice,file_precision,x_precision)
%DATAREAD  Read serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIMENSIONS  - A vector specifying the dimensions
%   *_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
error(nargchk(8, 8, nargin, 'struct'));
assert(isscalar(distributed),'distributed flag must be a scalar')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(isstruct(distribution), 'distribution must be a headser struct')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')
assert(matlabpool('size')>0,'matlabpool must be open')
if distributed
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
    % read data
    if distributed
        lx = DataContainer.io.memmap.serial.DataReadLeftSlice(dirname,filename,distribution.size{labindex},slice,file_precision,x_precision);
    else
        lx = DataContainer.io.memmap.serial.DataReadLeftChunk(dirname,filename,...
            dimensions,[distribution.min_indx(labindex) distribution.max_indx(labindex)],slice,file_precision,x_precision);
    end
    codist = codistributor1d(distribution.dim,distribution.partition,dimensions(1:distribution.dim));
    x = codistributed.build(lx,codist);
end
assert(isequal(dimensions(1:distribution.dim),size(x)),'dimensions does not match the size of codistributed x')

end
