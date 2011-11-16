function FileWrite(dirname,x,distribute,varargin)
%FILEWRITE Writes serial data to binary file
%
%   FILEWRITE(DIRNAME,DATA,DISTRIBUTE,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   DIRNAME    - A string specifying the directory name
%   DATA       - Non-distributed data
%   DISTRIBUTE - A scalar that takes 1 for distribute or 0 for no distribute
%
%   Addtional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%                    defaults to type of x
%                    Supported precisions: 'double', 'single'
%   HEADER_STRUCT  - An optional header struct as created
%                    by DataContainer.basicHeaderStructFromX
%                    or DataContainer.basicHeaderStruct
%
%   Warning: If the specified dirname already exist,
%            it will be overwritten.  
error(nargchk(3, 5, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdistributed(x), 'data must not be distributed')
assert(isscalar(distribute),'distribute flag must be a scalar')

% Make Directory
if isdir(dirname); rmdir(dirname,'s'); end;
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);

% Setup variables
header = DataContainer.basicHeaderStructFromX(x);
header = DataContainer.addDistHeaderStructFromX(header,x);
if distribute
    assert(iscell(varargin{1}), 'distributed output directories names must form cell')
    header=DataContainer.io.addDistFileHeaderStruct(header,varargin{1});
end
f_precision = header.precision;
assert(header.dims==header.distribution.dim,'x must be distributed over the last dimension')

% Preprocess input arguments
if nargin>4
    assert(ischar(varargin{1+distribute})|isstruct(varargin{1+distribute}),...
        'argument mast be either file_precision string or header struct')
    if ischar(varargin{1+distribute})
        f_precision = varargin{1+distribute};
        header.precision = f_precision;
    elseif isstruct(varargin{1+distribute})
        header = varargin{1+distribute};
        f_precision = header.precision;
    end
end;
DataContainer.verifyHeaderStructWithX(header,x);

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
% Write header
if ~distribute
    header = DataContainer.io.deleteDistHeaderStruct(header);
end
DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

end
