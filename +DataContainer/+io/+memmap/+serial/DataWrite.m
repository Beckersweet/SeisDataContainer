function DataWrite(dirname,filename,x,file_precision)
%DATAWRITE Writes serial data to binary file
%
%   DataWrite(DIRNAME,FILENAME,DATA,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   DIRNAME        - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DATA           - Non-distributed real data
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
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

% swap file_precision
x = DataContainer.utils.switchPrecisionIP(x,file_precision);

% Write local data
fid = fopen(filename,'r+');
fwrite(fid,x(:),file_precision);
fclose(fid);

end
