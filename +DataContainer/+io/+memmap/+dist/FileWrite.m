function FileWrite(dirname,x,distribute,varargin)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Addtional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to type of x
%               Supported precisions: 'double', 'single'
%   HEADER_STRUCT - An optional header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
error(nargchk(3, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdistributed(x), 'data must not be distributed')
assert(isscalar(distribute),'distribute flag must be a scalar')

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Setup variables
header = DataContainer.io.basicHeaderStructFromX(x);
header = DataContainer.io.addDistHeaderStructFromX(x,header);
if distribute
    header=DataContainer.io.addDistFileHeaderStruct(dirname,header);
end
f_precision = header.precision;

% Preprocess input arguments
if nargin>3
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

% Write file
if distribute
    DataContainer.io.memmap.dist.DataAlloc(header.directories,'real',...
        header.distribution.size,f_precision);
    DataContainer.io.memmap.dist.DataWrite(1,header.directories,'real',...
        real(x),header.distribution,f_precision);
    if ~isreal(x)
        DataContainer.io.memmap.dist.DataAlloc(header.directories,'imag',...
            header.distribution.size,f_precision);
        DataContainer.io.memmap.dist.DataWrite(1,header.directories,'imag',...
            imag(x),header.distribution,f_precision);
    end
else
    DataContainer.io.memmap.serial.DataAlloc(dirname,'real',...
        size(x),f_precision);
    DataContainer.io.memmap.dist.DataWrite(0,dirname,'real',...
        real(x),header.distribution,f_precision);
    if ~isreal(x)
        DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',...
            size(x),f_precision);
        DataContainer.io.memmap.dist.DataWrite(0,dirname,'imag',...
            imag(x),header.distribution,f_precision);
    end
end
if ~distribute
    header.distribution = struct();
    header = rmfield(header,'distribution');
end
% Write header
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

end
