function [x header] = FileReadLeftSlice(dirname,slice,varargin)
%FILEREADLEFTSLICE Reads serial left slice data from binary file
%
%   [X, HEADER] = FileReadLeftSlice(DIRNAME,SLICE,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   SLICE       - A vector specifying the slice index
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>2
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end

% Read header
header = DataContainer.io.memmap.serial.HeaderRead(dirname);
distdim = header.dims - length(slice);
assert(distdim>0,'invalid distributed diemnsion; too many indecies in the slice?')
partition = DataContainer.utils.defaultDistribution(header.size(distdim));
if ~header.distributedIO
    header = DataContainer.addDistHeaderStruct(header,distdim,partition);
else
    assert(distdim==header.distribution.dim,...
        'distributed dimension of reading request (%d) does not match (%d) in stored file',distdim,header.distribution.dim)
    assert(isequal(partition,header.distribution.partition),'partitioning of reading request does not match stored file')
end
% Read file
if header.distributedIO
    x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,header.directories,'real',...
        header.size,header.distribution,slice,header.precision,x_precision);
    if header.complex
        dummy=DataContainer.io.memmap.dist.DataReadLeftSlice(1,header.directories,'imag',...
            header.size,header.distribution,slice,header.precision,x_precision);
        x=complex(x,dummy);
    end
else
    x=DataContainer.io.memmap.dist.DataReadLeftSlice(0,dirname,'real',...
        header.size,header.distribution,slice,header.precision,x_precision);
    if header.complex
        dummy=DataContainer.io.memmap.dist.DataReadLeftSlice(0,dirname,'imag',...
            header.size,header.distribution,slice,header.precision,x_precision);
        x=complex(x,dummy);
    end
end
 
end
