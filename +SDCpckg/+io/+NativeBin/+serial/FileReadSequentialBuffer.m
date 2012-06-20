function [x header] = FileReadSequentialBuffer(dirname,dims,range,varargin)
%FILEREADLEFTCHUNK Reads serial left chunck data from binary file
%
%   [X, HEADER] = FileReadLeftChunk(DIRNAME,RANGE,SLICE,X_PRECISION) reads
%   the serial left chunk from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   DIMS        - A vector with dims prod equivalent to header sizes
%   RANGE       - A vector with two elements specifying the range of data
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%

SDCpckg.io.isFileClean(dirname);
error(nargchk(3, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(dims)&length(dims)==2, 'range index must be a vector with 2 elements')
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
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

% Check consistency of header with arguments
assert(prod(dims)==prod(header.size),'Fatal error: dims not consistent with header');
assert(range(1,1)>0&range(1,2)<=prod(dims),'Fatal error: range outside of the prod(dims)');

% Read file
x=SDCpckg.io.NativeBin.serial.DataReadLeftChunk(dirname,'real',...
    dims,range,[],header.precision,x_precision);
if header.complex
    dummy=SDCpckg.io.NativeBin.serial.DataReadLeftChunk(dirname,'imag',...
        dims,range,[],header.precision,x_precision);
    x=complex(x,dummy);
end 
end
