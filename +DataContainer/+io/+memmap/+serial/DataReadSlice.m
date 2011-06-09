function x = DataReadSlice(dirname,filename,dimensions,slice,file_precision,varargin)
%DATAWRITE  Write serial data slice to binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,SLICE,FILE_PRECISION,X_PRECISION) reads
%   the slice (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%   Addtional parameter:
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isnumeric(slice), 'slice index must be numeric')
assert(ischar(file_precision), 'file_precision name must be a string')

% Setup variables
x_precision = 'double';
slice_dims = dimensions(1:end-1);
slice_offset = prod(slice_dims)*(slice-1);

% Preprocess input arguments
error(nargchk(5, 6, nargin, 'struct'));
filename=fullfile(dirname,filename);
if nargin>5
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
slice_byte_offset = slice_offset*bytesize;

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Setup memmapfile
M = memmapfile(filename,...
            'format',{file_precision,slice_dims,'x'},...
	    'offset',slice_byte_offset,...
	    'writable', true);
        
% Read local data
x = M.data(1).x;
        
% swap x_precision
switch x_precision
    case 'single'
        if ~isa(x,'single'); x=single(x); end;
    case 'double'
        if ~isa(x,'double'); x=double(x); end;
    otherwise
        error('Unsupported precision for X');
end

end
