function distFileWrite(name,x,varargin)
%DISTWRITE  Write distributed data to binary file
%
%   x = distFileWrite(FILENAME,DATA,PARAM1,VALUE1,PARAM2,VALUE2,...) writes
%   the distributed data DATA into file FILENAME. Addtional
%   parameters include:
%   OFFSET    - An integer specifying the number of bits to skip from the
%               start of file before actual reading occurs, defaults to 0
%   PRECISION - A string specifying the precision of one unit of data,
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%   REPEAT    - Positive integer or Inf (defaults to Inf).
%               Number of times to apply the specified format to the mapped
%               region of the file. If Inf, repeat until end of file.
%   VERBOSE   - True if verbose output is desired after every sucessful lab
%               write. Defaults to false.
%
%   Warning: If the file name defined by the path FILENAME already exist,
%   it will be overwritten.

% Setup variables
filename  = name;
precision = 'double';
repeat    = inf;
offset    = 0;
verbose   = false;

% Preprocess input arguments
error(nargchk(1, nargin, nargin, 'struct'));

if rem(length(varargin), 2) ~= 0
    error('Param/value pairs must come in pairs.');
end

assert(ischar(name), 'filename must be a string')
assert(isdistributed(x), 'Data must be distributed')

% Parse param-value pairs
for i = 1:2:length(varargin)
    
    assert(ischar(varargin{i}),...
        'Parameter at input %d must be a string.', i);
    
    fieldname = lower(varargin{i});
    switch fieldname
        case {'offset', 'precision', 'repeat','verbose'}
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

% Preallocate File
DataCon.io.allocFile(filename,prod(size(x)),bytesize);

spmd
    % Setup local chunk size
    poolsize        = numlabs;
    local_data      = getLocalPart(x);
    local_size      = size(local_data);
    
    % Convert to single if single
    if strcmp(precision,'single')
        if verbose, tsingle = tic; end
        local_data = single(local_data);
        if verbose
            tsingle = toc(tsingle);
            disp(['Lab ' int2str(labindex) ' converted to single in '...
                int2str(tsingle) 's']);
        end
    end
    
    % Setup offsets
    global_elements = codistributed.zeros(1,numlabs);
    global_elements(labindex) = prod(local_size);
    global_elements = gather(global_elements);
    elements_offset = sum(global_elements(1:labindex-1));
    local_offset    = offset + elements_offset*bytesize;
    
    if labindex == 1   % Lab 1 always gets to write first
        % Setup memmapfile
        M = memmapfile(filename,'format',{precision,local_size,'x'},...
            'offset',local_offset, 'writable', true,...
            'repeat',repeat);
        
        % Write local data
        if verbose, twrite = tic; end
        M.data(1).x = local_data;
        
        % Verbose output
        if verbose
            twrite = toc(twrite);
            disp(['1/' int2str(poolsize) ' labs written! Time taken: '...
                int2str(twrite) 's']);
        end
        
    end
    labBarrier; % Synchronize
    
    if labindex == 1
        labs     = 2:numlabs;
        while ~isempty(labs)
            if( labProbe(labs(1)) )
                labReceive(labs(1)); % Get the ready signal
                labSend('Go ahead',labs(1)); % Send the go ahead signal
                if verbose, twrite = tic; end
                labReceive(labs(1)); % Wait for the done signal
                labs(1) = [];
                
                % Verbose output
                if verbose
                    twrite = toc(twrite);
                    disp([int2str(poolsize - length(labs)) '/'...
                    int2str(poolsize) ' labs written! Time taken: '...
                    int2str(twrite) 's']);
                end
                
            else
                labs = circshift( labs, [0 -1] );
            end
        end
    else % Other labs
        labSend('Im Ready!',1); % Send ready signal
        labReceive(1); % Wait for the go ahead signal
        % Setup memmapfile
        M = memmapfile(filename,'format',{precision,local_size,'x'},...
            'offset',local_offset, 'writable', true,...
            'repeat',repeat);
        
        % Write local data        
        M.data(1).x = local_data;
        labSend('Im Done!',1);
        
    end
    
end % spmd
