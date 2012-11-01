function y = reshape(varargin)
%RESHAPE    Reshape data container object to desired shape
%
%   reshape([DIM],X,N1,N2,...,N) reshapes data container X into the
%   dimensions defined as [N1,N2,...,N]. Note that the number of elements
%   must be conserved.
%
%   DIM specifies the distribution dimension you want your reshaped array
%   to be 'glued' in. If unspecified, the default will be the last
%   dimension of the new reshaped dimensions.
%
%   Always keep in mind that reshape on distributed arrays always conserve
%   the elements locally on the labs, ie. There will be no communication
%   between labs. Therefore, the local parts size after reshaping has to be
%   the same locally. This is generally not an issue if you preserve the
%   size of the distributed dimension. Or some special symmetrical
%   distribution scheme is used.
%
%   See also: invvec, dataContainer.vec, iCon.double

% Check and extract dim
if isa(varargin{2},'piCon')
    assert( isscalar(varargin{1}), 'Distributed dimension must be positive scalar')
    dim = varargin{1};
    varargin = varargin(2:end);
else
    dim = length([varargin{2:end}]);
end

% Check and extract x and sizes
x       = varargin{1};
assert(isa(x,'piCon'), 'X must be a parallel data container')
sizes   = [varargin{2:end}];

% Check for the collapsibility of reshape
% Do the calculation
imsize  = x.header.size;

while(imsize(end) == 1) % Strip singleton dimensions
   imsize(end) = [];
end
redims          = sizes;
j               = 1;
collapsed_chunk = [];
collapsed_dims  = 1;

for i = 1:length(imsize)
    collapsed_chunk = [collapsed_chunk imsize(i)];
    if  prod(collapsed_chunk) == redims(j)
        collapsed_dims(end+1)  = i;
        if i < length(imsize)
            collapsed_dims(end+1)  = i+1;
        end
        j = j + 1;
        collapsed_chunk = [];
    elseif prod(collapsed_chunk) > redims(j)
        error(['Reshape dimensions must be collapsed '...
            'or multiples of implicit dimension']);
    end
end

% Reshape collapsed dims
collapsed_dims = reshape(collapsed_dims,2,[]);

% Check for number of elements
assert(numel(x.data) == prod(sizes),'Number of elements must be conserved')

% Setup variables
data = x.data;
if ~dim, dim  = x.excoddims; end

% Pick the smallest dimension
dim = min(dim,length(sizes));

% Vec case
if prod(sizes) == sizes(1)
    spmd
        % Setup local parts
        data = getLocalPart(data);
        data = data(:); % vec
        part = codistributed.zeros(1,numlabs);
        
        % Setup codistributor and combine
        if ~isempty(data)
            part(labindex)  = length(data);
        end
        
        % Build codistributed
        cod  = codistributor1d(1,part,sizes);
        data = codistributed.build(data,cod,'noCommunication');
    end
    
else % Everything else
    spmd
        % Setup local parts
        data = getLocalPart(data);
        part = codistributed.zeros(1,numlabs);
        
        % Reshape
        if ~isempty(data)
            locsizes        = num2cell(sizes);
            locsizes{dim}   = [];
            data            = reshape(data,locsizes{:});
            part(labindex)  = size(data,dim);
        else
            empty_size      = sizes;
            empty_size(dim) = 0;
            data = zeros(empty_size);
        end
        
        % Build codistributed
        cod  = codistributor1d(dim,part,sizes);
        data = codistributed.build(data,cod,'noCommunication');
    end
end

% Set variables
% Compensate for 1D case
if length(collapsed_dims) == 1
    collapsed_dims(end + 1) = 1;
end

% Set variables
y             = piCon(data);
cod           = cod{1};
y.imcoddims   = cod.Dimension; % Old distribution is obsolete
y.imcodpart   = cod.Partition; % Old distribution is obsolete
y.header.size = x.header.size;
y.exsize      = collapsed_dims;
y.perm        = 1:length(collapsed_dims); % Old permutation is GONE