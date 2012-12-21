function FileWrite(dirname,x,varargin)
%FILEWRITE Writes serial data to binary file
%
%   FileWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%
%   Optional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%                    defaults to type of x
%                    Supported precisions: 'double', 'single'
%   HEADER_STRUCT  - An optional header struct as created
%                    by SDCpckg.basicHeaderStructFromX
%                    or SDCpckg.basicHeaderStruct
%
%   Warning: If the specified dirname exists, it will be removed.

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
assert(~isdistributed(x), 'data must not be distributed')

% Setup variables
header = SDCpckg.basicHeaderStructFromX(x);
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
SDCpckg.verifyHeaderStructWithX(header,x);

% Write header
SDCpckg.io.setFileDirty(dirname);
SDCpckg.io.JavaSeis.serial.HeaderWrite(dirname,header);
SDCpckg.io.setFileClean(dirname);

% Write file
SDCpckg.io.setFileDirty(dirname);
SDCpckg.io.JavaSeis.serial.DataWrite(dirname,'TraceFile',x,f_precision);
SDCpckg.io.setFileClean(dirname);
end