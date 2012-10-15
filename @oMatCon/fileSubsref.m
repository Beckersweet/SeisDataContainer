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
elseif len == size(x.exsize,2) || len == length(x.header.size)
    % Implicit OR explicit indexing
    % Extract range and slice
    % Remove colons
    while(varargin{1} == ':')
        varargin = varargin(2:end);
    end
    
    range = varargin{1};
    if length(varargin) > 1
        slice = varargin{2:end};
    else
        slice = varargin{1};
    end
    
else
    error(['The laws of Time and Space has been broken by your ',...
        'unsupported use of weird indexing, and the blood is on your ',...
        'hands...']);
end

% Preallocate y as oMatCon
y = oMatCon.zeros(alloc_size);

% Extract data
FileCopyLeftChunkToFile(path(x.pathname),path(y.pathname),range,slice);

% Useful warnings
% A long time ago in a galaxy far, far away...