function x = FileRead(dirname,dimensions,imaginary,file_precision,varargin)
%FILEWRITE  Write serial data to binary file
%
%   X = DataRead(DIRNAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%   Addtional parameter:
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
assert(ischar(dirname), 'directory name must be a string')
assert(isvector(dimensions), 'dimensions must a vector')
assert(isnumeric(imaginary), 'imaginary must be a numeric')
assert(ischar(file_precision), 'file_precision name must be a string')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
error(nargchk(4, 5, nargin, 'struct'));
if nargin>4
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read file
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
x=DataContainer.io.memmap.serial.DataRead(dirname,'real',...
    dimensions,file_precision,x_precision);
if imaginary
    dummy=DataContainer.io.memmap.serial.DataRead(dirname,'imag',...
        dimensions,file_precision,x_precision);
    x=complex(x,dummy);
end
 
end
