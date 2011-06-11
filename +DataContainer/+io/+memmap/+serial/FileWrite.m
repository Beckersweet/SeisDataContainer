function FileWrite(dirname,x,varargin)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Addtional parameter:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to type of x
%               Supported precisions: 'double', 'single'
%
%   Warning: If the specified dirname will be removed,
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
precision = DataContainer.utils.getPrecision(x);

% Preprocess input arguments
error(nargchk(2, 3, nargin, 'struct'));
if nargin>2
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    precision = varargin{1};
end;

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Write file
DataContainer.io.memmap.serial.DataAlloc(dirname,'real',size(x),precision);
DataContainer.io.memmap.serial.DataWrite(dirname,'real',real(x),precision);
if ~isreal(x)
    DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',size(x),precision);
    DataContainer.io.memmap.serial.DataWrite(dirname,'imag',imag(x),precision);
end

end
