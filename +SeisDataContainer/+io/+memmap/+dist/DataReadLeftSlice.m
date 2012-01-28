function x = DataReadLeftSlice(distributed,dirnames,filename,dimensions,distribution,slice,file_precision,x_precision)
%DATAREADLEFTSLICE Reads serial data from binary file
%
%   X = DataReadLeftSlice(DISTRIBUTED,DIRNAMES,FILENAME,DIMENSIONS,DISTRIBUTION,SLICE,FILE_PRECISION,X_PRECISION)
%   reads the serial real left slice from file DIRNAME/FILENAME.
%
%   DISTRIBUTED  - 1 for distributed or 0 otherwise
%   DIRNAMES     - A string specifying the directory name
%   FILENAME     - A string specifying the file name
%   DIMENSIONS   - A vector specifying the dimensions
%   DISTRIBUTION - A header struct specifying the distribution
%   SLICE        - A vector specifying the slice index
%   *_PRECISION  - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
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
    dirname = SeisDataContainer.utils.Cell2Composite(dirnames);
    csize = SeisDataContainer.utils.Cell2Composite(distribution.size);
else
    assert(ischar(dirnames), 'directory name must be a string')
    dirname = dirnames;
    cindx_rng = SeisDataContainer.utils.Cell2Composite(distribution.indx_rng);
end

spmd
    % Check File
    filecheck=fullfile(dirname,filename);
    assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);
    % read data
    if distributed
        lx = SeisDataContainer.io.memmap.serial.DataReadLeftSlice(dirname,filename,...
            csize,slice,file_precision,x_precision);
    else
        lx = SeisDataContainer.io.memmap.serial.DataReadLeftChunk(dirname,filename,...
            dimensions,cindx_rng,slice,file_precision,x_precision);
    end
    if distribution.dim==1
        codist = codistributor1d(distribution.dim,distribution.partition,[dimensions(1:distribution.dim) 1]);
    else
        codist = codistributor1d(distribution.dim,distribution.partition,dimensions(1:distribution.dim));
    end
    % 'noCommunication' below is faster but dangerous
    x = codistributed.build(lx,codist,'noCommunication');
end
if distribution.dim==1
    assert(isequal([dimensions(1:distribution.dim) 1],size(x)),...
        'dimensions does not match the size of codistributed x')
else
    assert(isequal(dimensions(1:distribution.dim),size(x)),...
        'dimensions does not match the size of codistributed x')
end

end
