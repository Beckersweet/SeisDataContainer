function [x header] = FileRead(dirname,varargin)
%FILEWRITE  Write serial data to binary file
%
%   [X, HEADER] = FILEREAD(DIRNAME,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%   Addtional parameter:
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
error(nargchk(1, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>1
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = DataContainer.io.memmap.serial.HeaderRead(dirname);
% Read file
if header.distributed
    x=DataContainer.io.memmap.dist.DataRead(1,header.directories,'real',...
        header.size,header.distribution,header.precision,x_precision);
    if header.complex
        dummy=DataContainer.io.memmap.dist.DataRead(1,header.directories,'imag',...
            header.size,header.distribution,header.precision,x_precision);
        x=complex(x,dummy);
    end
else
    header = DataContainer.io.addDistHeaderStruct(header.dims,...
        DataContainer.utils.defaultDistribution(header.size(end)),header);
    x=DataContainer.io.memmap.dist.DataRead(0,dirname,'real',...
        header.size,header.distribution,header.precision,x_precision);
    if header.complex
        dummy=DataContainer.io.memmap.dist.DataRead(0,dirname,'imag',...
            header.size,header.distribution,header.precision,x_precision);
        x=complex(x,dummy);
    end
end
 
end
