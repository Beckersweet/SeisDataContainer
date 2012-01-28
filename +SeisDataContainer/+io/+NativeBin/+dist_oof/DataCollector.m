function DataCollector( filename,dimensions,dirname,varargin )
%DATACOLLECTOR reads the real data and merge them in one binary file
%
%   DataCollector(FILENAME,DIMENSIONS,DIRNAME,PARAM1,VALUE1,PARAM2,VALUE2,...)
%   reads the real binary files in the specified directory and merges them
%   into a single binary file. Addtional parameters include:
%   ORIGIN    - An integer specifying the number of bits to skip from the 
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
precision; % = 'double';
repeat; %    = inf;
origin; %    = 0;

% Preprocess input arguments
assert(ischar(filename), 'filename must be a string')
assert(isnumeric(dimensions), 'dimensions must be numeric')

% Parse inputs with parser
p = inputParser;
p.addParamValue('precision','double',@ischar);
p.addParamValue('repeat',inf,@isscalar);
p.addParamValue('origin',0,@isscalar);
p.parse(varargin{:});

% error(nargchk(1, nargin, nargin, 'struct'));
% if rem(length(varargin), 2) ~= 0
%     error('Param/value pairs must come in pairs.');
% end
% % Parse param-value pairs
% for i = 1:2:length(varargin)
%     
%     assert(ischar(varargin{i}),...
%         'Parameter at input %d must be a string.', i);
%     
%     fieldname = lower(varargin{i});
%     switch fieldname
%         case {'origin', 'precision', 'repeat'}
%             eval([fieldname ' = varargin{i+1};']);
%         otherwise
%             error('Parameter "%s" is unrecognized.', ...
%                 varargin{i});
%     end
% end

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
labwidth = SeisDataContainer.utils.defaultDistribution(dimensions(end-1));

SeisDataContainer.io.allocFile(filename,prod(dimensions)*8*numlabs,bytesize);
%prod(local_size)*dimensions(end)*8
spmd    
    %loclabwidth = labwidth(labindex);
    local_size = dimensions(1:end);
    
    for o=1:dimensions(end)
        % Setup global memmapfile
        outcoreorigin = origin + prod(dimensions(1:end-1))*(o-1)*bytesize;
        parorigin     = dimensions(1:end-2)*sum(labwidth(1:labindex-1))...
                         *bytesize;
        M = memmapfile(fullfile(dirname,int2str(labindex),'real'),...
            'format',{precision,local_size,'x'},...
            'origin',outcoreorigin+parorigin,'repeat',repeat);
             
        % Setup memmap of local file
        locorigin     = prod(local_size(1:end-1))*(o-1)*8;
        MW = memmapfile(fullfile(dirname,filename),'format',...
            {'double',local_size,'x'},'origin',locorigin,'writable',...
            true,'repeat',repeat);
        
        % Read global data and Write local data
        MW.data(1).x  = double(M.data(1).x);
    end
end