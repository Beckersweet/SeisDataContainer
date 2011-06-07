function DataCollector( filename,dimensions,dirname,varargin )
%DATACOLLECTOR reads the real data and merge them in one binary file
%
%   DataCollector(FILENAME,DIMENSIONS,DIRNAME,PARAM1,VALUE1,PARAM2,VALUE2,...)
%   reads the real binary files in the specified directory and merges them
%   into a single binary file. Addtional parameters include:
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


% Preallocate collector output file
global_size = dimensions(1:end);
DataCon.io.allocFile(dirname,prod([global_size 8]),8);

spmd % reading all real files 
    for o=1:dimensions(end)
        % Setup global memmapfile
        outcoreoffset = offset + prod(dimensions(1:end))*o*bytesize;
        paroffset     = dimensions(1:end-1)*sum(labwidth(1:labindex-1))...
                         *bytesize;
        M = memmapfile(fullfile(dirname,int2str(labindex),'real'),...
            'format',{precision,[global_size(1:end) 1],'x'}, 'offset',...
            outcoreoffset+paroffset,'repeat',repeat);

        % Setup memmap of local file
        globoffset     = global_size(1:end)*o*8;
        MW = memmapfile(fullfile(dirname,'collected'),'format',...
            {'double',global_size,'x'},'offset',globoffset,'writable',...
            true,'repeat',repeat);

        % Read global data and Write global data
        MW.data(1).x = double(M.data(1).x);
    end
end