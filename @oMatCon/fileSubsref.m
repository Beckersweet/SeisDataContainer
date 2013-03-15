function y = fileSubsref(x,varargin)
%FILESUBSREF  out-of-core-to-out-of-core subscripted reference
%
%   Y = fileSubsref(X,ind1,ind2,....) subsrefs the omatCon X with indices
%   (ind1,ind2,...) and returns omatCon Y. The index range must be totally
%   contiguous.
%
%   Y = X.fileSubsref(ind1,ind2...) also works and may be more intuitive to
%   use.

% Preprocess input arguments
assert( length(varargin) <= ndims(x), ['Your indexing into more dimensions ',...
    'than the data container has has resulted in a glitch in the Matrix.',...
    ' Expect a visit from Agent Smith']);
assert( ~isempty(varargin), ['Your indexing into zero dimensions ',...
    ' has resulted in a glitch in the Matrix.',...
    ' Expect a visit from Agent Smith']);

len = length(varargin);
if len == 1 && varargin{1} == ':' % Vec case
    y = x(:);
    return;
end

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

% Calculate colon length
col_len = len - length(varargin);

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

% Preallocate y as oMatCon
alloc_size = [work_header.size(1:col_len) length(range)];
if isscalar(alloc_size) % singleton padding
    alloc_size = [alloc_size 1];
end
y = oMatCon.zeros(alloc_size);

% Extract data
% Accomodate the weird syntax of the FileCopyLeftChunkToFile function
range = [range(1) range(end)];
SDCpckg.io.NativeBin.serial.FileCopyLeftChunkToFile(path(x.pathname),...
    path(y.pathname),range,slice);

% Return original header to original state
if len == size(x.exsize,2) % Explicit indexing
    SDCpckg.io.NativeBin.serial.HeaderWrite(path(x.pathname),x.header);
end

% Useful warnings
% A long time ago in a galaxy far, far away...