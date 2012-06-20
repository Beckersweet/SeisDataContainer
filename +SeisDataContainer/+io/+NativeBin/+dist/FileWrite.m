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
%                    by SeisDataContainer.basicHeaderStructFromX
%                    or SeisDataContainer.basicHeaderStruct
%
%   Warning: If the specified dirname already exist,
%            it will be overwritten.
%
error(nargchk(3, 5, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdistributed(x), 'data must not be distributed')
assert(isscalar(distribute),'distribute flag must be a scalar')

% Setup variables
header = SeisDataContainer.basicHeaderStructFromX(x);
header = SeisDataContainer.addDistHeaderStructFromX(header,x);
if distribute
    assert(iscell(varargin{1}), 'distributed output directories names must form cell')
    header=SeisDataContainer.addDistFileHeaderStruct(header,varargin{1});
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
SeisDataContainer.verifyHeaderStructWithX(header,x);

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Allocate file
if distribute
    SeisDataContainer.io.NativeBin.dist.FileAlloc(dirname,header);
else
    hdrsrl = SeisDataContainer.deleteDistHeaderStruct(header);
    SeisDataContainer.io.NativeBin.serial.FileAlloc(dirname,hdrsrl);
end

% Write file
if distribute
    SeisDataContainer.io.NativeBin.dist.DataWrite(1,header.directories,'real',...
        real(x),header.distribution,f_precision);
    if ~isreal(x)
        SeisDataContainer.io.NativeBin.dist.DataWrite(1,header.directories,'imag',...
            imag(x),header.distribution,f_precision);
    end
else
    SeisDataContainer.io.NativeBin.dist.DataWrite(0,dirname,'real',...
        real(x),header.distribution,f_precision);
    if ~isreal(x)
        SeisDataContainer.io.NativeBin.dist.DataWrite(0,dirname,'imag',...
            imag(x),header.distribution,f_precision);
    end
end

end
