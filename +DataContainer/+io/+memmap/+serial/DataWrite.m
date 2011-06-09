function DataWrite(dirname,filename,x,varargin)
%DATAWRITE  Write distributed data to binary file
%
%   DataWrite(DIRNAME,FILENAME,DATA,FILE_PRECISION) writes
%   the serial array X into file DIRNAME/FILENAME.
%   Addtional parameter:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified file already exist,
%            it will be overwritten.
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isnumeric(x), 'data must be numeric')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
precision = 'double';

% Preprocess input arguments
error(nargchk(3, 4, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>3
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    precision = varargin{1};
end;

% Set bytesize
switch precision
    case 'single'
        bytesize = 4;
	x=single(x);
    case 'double'
        bytesize = 8;
	x=double(x);
    otherwise
        error('Unsupported precision');
end

% Preallocate File
DataContainer.io.allocFile(filename,prod(size(x)),bytesize);

% Setup memmapfile
M = memmapfile(filename,...
            'format',{precision,size(x),'x'},...
	    'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
