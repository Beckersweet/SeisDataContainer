function x = fileSubsasgn(x,a,varargin)
%FILESUBSASGN   out-of-core-to-out-of-core subscripted assignment
%
%   X = fileSubsasgn(X,A,ind1,ind2,...) subsasgns the oMatCon X with
%   oMatCon A using indices (ind1,ind2,...) and returns X. The index range
%   must be totally contiguous
%
%   X = X.fileSubsasgn(A,ind1,ind2,...) also works if you are more
%   comfortable with this notation.

% Preprocess input arguments
assert( length(varargin) <= ndims(x), ['Your indexing into more dimensions ',...
    'than the data container has has resulted in a glitch in the Matrix.',...
    ' Expect a visit from Agent Smith']);
assert( ~isempty(varargin), ['Your indexing into zero dimensions ',...
    ' has resulted in a glitch in the Matrix.',...
    ' Expect a visit from Agent Smith']);

len = length(varargin);

% Check for implicit and explicit indexing sizes
assert(len == size(x.exsize,2) || len == length(x.header.size),...
    ['The laws of Time and Space has been broken by your ',...
        'unsupported use of weird indexing...']);
    
% Implicit OR explicit indexing
% Extract range and slice
% Remove colons
while(varargin{1} == ':')
    varargin = varargin(2:end);
end

% Modify headers for implicit or explicit indexing
if len == size(x.exsize,2) % Explicit indexing
    % Change working header to reflect this size
    work_header = x.header;
    work_header.size = size(x);
    work_header.dims = ndims(x);

    % Temporarily write header to file
    SDCpckg.io.NativeBin.serial.HeaderWrite(path(x.pathname),work_header);
else % implicit indexing, use current header
    work_header = x.header;
end

% Check and extract range and slice
range = varargin{1};
slice = [];
if isempty(varargin)
    error(['Chuck Norris dissaproves of your weird usage of colon ',...
        ' indexing']);
elseif length(varargin) == 1 % last dimension ranging or slicing
    if isscalar(varargin{1}) % last dimension slicing
        slice = varargin{1};
        range = 1:work_header.size(end-1);
    end
else % last (few) dimensions slicing plus possible ranging
    if isscalar(varargin{1}) % All slices
        slice = varargin{1:end};
        range = 1:work_header.size(end-length(slice));
    else % range is present
        slice = varargin{2:end};
    end
    check = arrayfun(@isscalar,slice);
    assert(all(check) && length(check) == length(slice),...
        'Last few dimensions must be scalars, or else...');
end

% Inject data
% Accomodate the weird syntax of the FileCopyLeftChunkToFile function
range = [range(1) range(end)];
SDCpckg.io.NativeBin.serial.FileCopyLeftChunkFromFile(path(a.pathname),...
    path(x.pathname),range,slice);

% Return original header to original state
if len == size(x.exsize,2) % Explicit indexing
    SDCpckg.io.NativeBin.serial.HeaderWrite(path(x.pathname),x.header);
end
