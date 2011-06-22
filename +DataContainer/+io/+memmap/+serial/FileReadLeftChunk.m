function [x header] = FileReadLeftChunk(dirname,range,slice,varargin)
%FILEWRITE  Write serial data to binary file
%
%   [X, HEADER] = FileReadLeftChunk(DIRNAME,DIMENSIONS,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
error(nargchk(3, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>3
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = load(fullfile(dirname,'header.mat'));
% Read file
x=DataContainer.io.memmap.serial.DataReadLeftChunk(dirname,'real',...
    header.size,range,slice,header.precision,x_precision);
if header.complex
    dummy=DataContainer.io.memmap.serial.DataReadLeftChunk(dirname,'imag',...
        header.size,range,slice,header.precision,x_precision);
    x=complex(x,dummy);
end
 
end
