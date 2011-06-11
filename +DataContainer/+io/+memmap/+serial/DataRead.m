function x = DataRead(dirname,filename,dimensions,file_precision,varargin)
%DATAWRITE  Write serial data to binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%   Addtional parameter:
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision name must be a string')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
error(nargchk(4, 5, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>4
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
            'format',{file_precision,dimensions,'x'},...
	    'writable', false);
        
% Read local data
x = M.data(1).x;
        
% swap x_precision
x = DataContainer.utils.switchPrecision(x,x_precision);

end
