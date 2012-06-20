function [x header] = FileReadLeftChunk(dirname,range,slice,varargin)
%FILEREADLEFTCHUNK Reads serial left chunck data from binary file
%
%   [X, HEADER] = FileReadLeftChunk(DIRNAME,RANGE,SLICE,X_PRECISION) reads
%   the serial left chunk from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   RANGE       - A vector with two elements specifying the range of data
%   SLICE       - A vector specifying the slice index
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%

SDCpckg.io.isFileClean(dirname);
error(nargchk(3, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(SDCpckg.io.isFileClean(dirname));

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>3
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
% Read file
x=SDCpckg.io.NativeBin.serial.DataReadLeftChunk(dirname,'real',...
    header.size,range,slice,header.precision,x_precision);
if header.complex
    dummy=SDCpckg.io.NativeBin.serial.DataReadLeftChunk(dirname,'imag',...
        header.size,range,slice,header.precision,x_precision);
    x=complex(x,dummy);
end 
end
