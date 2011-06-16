function DataSliceRead(filename,dimensions,sliceIndex,tempdirname,varargin)
%DATASLICEREAD Reads the specified slice and writes to a binary file
%
%   DataSliceRead(FILENAME,DIMENSIONS,SLICEINDEX,PARAM1,VALUE1,PARAM2,VALUE2,...)
%   reads the binary file specified by FILENAME and stores the real data in 
%   seperate directories depending on the number of labs. 
%   Addtional parameters include:
%   OFFSET    - An integer specifying the number of bits to skip from the 
%               start of file before actual reading occurs, defaults to 0
%   PRECISION - A string specifying the precision of one unit of data, 
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%   REPEAT    - Positive integer or Inf (defaults to Inf).
%               Number of times to apply the specified format to the mapped
%               region of the file. If Inf, repeat until end of file. 
%
%   Note: The absolute path to the file must be provided.

% Setup variables
precision = 'double';
repeat    = inf;
offset    = 0;
name      = ['slice' int2str(sliceIndex)];
% Preprocess input arguments
error(nargchk(1, nargin, nargin, 'struct'));

if rem(length(varargin), 2) ~= 0
    error('Param/value pairs must come in pairs.');
end

assert(ischar(filename), 'filename must be a string')
assert(isnumeric(dimensions), 'dimensions must be numeric')

% Parse param-value pairs
for i = 1:2:length(varargin)
    
    assert(ischar(varargin{i}),...
        'Parameter at input %d must be a string.', i);
    
    fieldname = lower(varargin{i});
    switch fieldname
        case {'offset', 'precision', 'repeat'}
            eval([fieldname ' = varargin{i+1};']);
        otherwise
            error('Parameter "%s" is unrecognized.', ...
                varargin{i});
    end
end

% Set bytesize
switch precision
    case 'single'
        bytesize = 4;
    case 'double'
        bytesize = 8;
    otherwise
        error('Unsupported precision');
end

% Setup labwidth
labwidth = pSPOT.utils.defaultDistribution(dimensions(end-1));

spmd
    tempdirname = [tempdirname int2str(labindex)];
    mkdir(tempdirname);
    loclabwidth = labwidth(labindex);
    local_size  = [dimensions(1:end-2) loclabwidth];
    DataContainer.io.allocFile([tempdirname filesep name],prod(local_size(1:end-1))*8,8);
    % Setup global memmapfile
    outcoreoffset = offset + prod(dimensions(1:end-1))*(sliceIndex-1)*bytesize;
    paroffset     = prod(dimensions(1:end-2))*sum(labwidth(1:labindex-1))*bytesize;
    M = memmapfile(filename,'format',{precision,local_size,'x'},...
        'offset',outcoreoffset+paroffset,'repeat',repeat);
    % Setup memmap of local file
    locoffset     = prod(local_size(1:end-1))*8;
    MW = memmapfile(fullfile(tempdirname,name),'format',...
        {'double',local_size,'x'},'offset',locoffset,'writable',...
        true,'repeat',repeat);
    % Read global data and Write local data
    MW.data(1).x  = double(M.data(1).x);
end % spmd
end % function