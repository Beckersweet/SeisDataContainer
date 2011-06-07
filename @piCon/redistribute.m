function y = redistribute(x,varargin)
%REDISTRIBUTE   Redistribution for data container
%   
%   y = redistribute(x) redistributes the underlying distributed
%   data in data container x to the last dimension.
%
%   y = redistribute(x,DDIM) redistributes x to specified distribution
%   dimensions DDIM.
%
%   y = redistribute(x,DDIM,PART) additional specifies the distribution
%   partition to be PART. Note that the sum of the distribution partition
%   must be equal to the correct dimension in the global size of x.

% Setup variables
dim   = ndims(x);
part  = [];
if length(varargin) >= 1, dim  = varargin{1}; end
if length(varargin) == 2, part = [varargin{2:end}]; end
data  = double(x);
sizes = size(x);

% Check variables
% assert(dim <= ndims(x), ...
%     'Distribution dimension must be within the dimensionality of x')
if ~isempty(part)
assert(sum(part) == size(x,dim),...
    'Sum of partition must be equal to size of distributed dimension')
end

% Redistribute
spmd
    % Build codistributor
    cod = codistributor1d(dim,part,sizes);
    
    % Redistribute
    data = redistribute(data,cod);
    
end % spmd

% Set variables
y           = x;
cod         = cod{1};
y.data      = data;
y.excoddims = cod.Dimension;
y.excodpart = cod.Partition;