function FileWrite(dirname,x,varargin)
%FILEWRITE Writes serial data to binary file
% TODO: be able to create directory, >3 dims 
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
%                    by DataContainer.io.basicHeaderStructFromX
%                    or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname exists, it will be removed.
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
%assert(~isdistributed(x), 'data must not be distributed')

%{
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
% if isdir(dirname); rmdir(dirname,'s'); end;
% status = mkdir(dirname);
% assert(status,'Fatal error while creating directory %s',dirname);
% At this time, the directory must already exist. 
%}

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
    
position = zeros(dimensions,1);

% Write file
for i = 1:size(x,3)
    position(dimensions)=i-1;
    data = x(:,:,i);
    data=data';
    seisio.setTraceDataArray(data);
    seisio.setPosition(position);
    seisio.writeFrame(size(data,1));% writes one 2D "Frame"
end

    seisio.close();

end
