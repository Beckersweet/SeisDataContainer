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
redims  = sizes;

% Reshape data 
y = piCon(reshape(x.data,redims));

% Strip singleton dimensions
while (imsize(end) == 1) 
   imsize(end) = [];
end

while (redims(end) == 1) 
   redims(end) = [];
end

if length(redims) > length(imsize) % Expanding implicit size
    warning('iCon:reshape:imsize',...
        ['reshape dimensions more than implicit dimensions. Old metadata '...
         'will be replaced']);
else % Collapsing implicit size

    % Calculate collapsed dimensiosn
    j               = 1;
    collapsed_chunk = [];
    collapsed_dims  = 1;

    for i = 1:length(imsize)
        collapsed_chunk = [collapsed_chunk imsize(i)];
        if  prod(collapsed_chunk) == redims(j)
            collapsed_dims(end+1) = i;
            if i < length(imsize)
                collapsed_dims(end+1) = i+1;
            end
            j = j + 1;
            collapsed_chunk = [];
        elseif prod(collapsed_chunk) > redims(j)
            warning('iCon:reshape:imsize',...
            ['reshape dimensions not collapsible from implicit dimensions. '...
            'old metadata will be replaced']);
            return;
        end
    end

    % Reshape collapsed dims
    collapsed_dims = reshape(collapsed_dims,2,[]);
    y.perm         = 1:length(collapsed_dims);
    y.exsize       = collapsed_dims;

    % Metadata transfer
    y_header               = y.header;
    y_header.dims          = x.header.dims;
    y_header.varName       = x.header.varName;
    y_header.varUnits      = x.header.varUnits;
    y_header.origin        = x.header.origin;
    y_header.delta         = x.header.delta;
    y_header.precision     = x.header.precision;
    y_header.complex       = x.header.complex;
    y_header.unit          = x.header.unit;
    y_header.label         = x.header.label;
    y_header.distributedIO = x.header.distributedIO;
    y_header.size          = x.header.size;
    y.header               = y_header;
end % collapsing implicit size