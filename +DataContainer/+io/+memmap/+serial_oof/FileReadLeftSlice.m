function [x header] = FileReadLeftSlice(dirname,slice,varargin)
%FILEWRITE  Write serial data to binary file
%
%   [X, HEADER] = FileReadLeftSlice(DIRNAME,DIMENSIONS,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%   Addtional parameter:
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
error(nargchk(2, 3, nargin, 'struct'));
if nargin>2
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = load(fullfile(dirname,'header.mat'));
% Read file
x=DataContainer.io.memmap.serial_oof.DataReadLeftSlice(dirname,'real',...
    header.size,slice,header.precision,x_precision);
if header.complex
    dummy=DataContainer.io.memmap.serial_oof.DataReadLeftSlice(dirname,'imag',...
        header.size,slice,header.precision,x_precision);
    x=complex(x,dummy);
end
 
end
