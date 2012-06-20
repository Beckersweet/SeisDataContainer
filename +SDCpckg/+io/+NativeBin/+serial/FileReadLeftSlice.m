function [x header] = FileReadLeftSlice(dirname,slice,varargin)
%FILEREADLEFTSLICE  Read serial left slice data from binary file
%
%   [X, HEADER] = FileReadLeftSlice(DIRNAME,SLICE,X_PRECISION) reads
%   the serial left slice from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   SLICE       - A vector specifying the slice index
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%

SDCpckg.io.isFileClean(dirname);
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
assert(SDCpckg.io.isFileClean(dirname));

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>2
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
% Read file
x=SDCpckg.io.NativeBin.serial.DataReadLeftSlice(dirname,'real',...
    header.size,slice,header.precision,x_precision);
if header.complex
    dummy=SDCpckg.io.NativeBin.serial.DataReadLeftSlice(dirname,'imag',...
        header.size,slice,header.precision,x_precision);
    x=complex(x,dummy);
end 
end
