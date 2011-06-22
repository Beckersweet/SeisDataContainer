function DataWrite(dirname,filename,x,file_precision)
%DATAWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,FILENAME,DATA,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified file must exist,
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(~isdistributed(x), 'data must not be distributed')
assert(ischar(file_precision), 'file_precision name must be a string')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

% Set bytesize
bytesize = DataContainer.utils.getByteSize(file_precision);
x = DataContainer.utils.switchPrecisionIP(x,file_precision);

% Setup memmapfile
M = memmapfile(filename,...
        'format',{file_precision,size(x),'x'},...
        'writable', true);
        
% Write local data
M.data(1).x = x;
        
end
