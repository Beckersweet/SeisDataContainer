function [x header] = FileRead(dirname,varargin)
%FILEREAD  Read serial data and header from binary file
%
%   [X, HEADER] = FileRead(DIRNAME,X_PRECISION) reads
%   the serial file from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%

SDCpckg.io.isFileClean(dirname);
error(nargchk(1, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(SDCpckg.io.isFileClean(dirname));

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>1
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Read header
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
% Read file
x=SDCpckg.io.NativeBin.serial.DataRead(dirname,'real',...
    header.size,header.precision,x_precision);
if header.complex
    dummy=SDCpckg.io.NativeBin.serial.DataRead(dirname,'imag',...
        header.size,header.precision,x_precision);
    x=complex(x,dummy);
end 
end
