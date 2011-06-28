function FileWrite(dirname,x,varargin)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Optional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to type of x
%               Supported precisions: 'double', 'single'
%   HEADER_STRUCT - An optional header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
header = DataContainer.io.basicHeaderStructFromX(x);
f_precision = header.precision;

% Preprocess input arguments
if nargin>2
    assert(ischar(varargin{1})|isstruct(varargin{1}),...
        'argument mast be either file_precision string or header struct')
    if ischar(varargin{1})
        f_precision = varargin{1};
        header.precision = f_precision;
    elseif isstruct(varargin{1})
        header = varargin{1};
        f_precision = header.precision;
    end
end;
DataContainer.io.verifyHeaderStructWithX(header,x);

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Write file
DataContainer.io.memmap.serial.DataAlloc(dirname,'real',size(x),f_precision);
DataContainer.io.memmap.serial.DataWrite(dirname,'real',real(x),f_precision);
if ~isreal(x)
    DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',size(x),f_precision);
    DataContainer.io.memmap.serial.DataWrite(dirname,'imag',imag(x),f_precision);
end
% Write header
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

end
