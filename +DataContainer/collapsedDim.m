function y = collapsedDim(exdims,imdims)
%COLLAPSEDDIM   Search Algorithm for the Fundamental Theorem of Henryk
%
%   collapsedDim(exdims,imdims) returns the implicit dimension that is the
%   contiguous dimension in the second dimension of the explicit dimensions
%   ie. If x has implicit dimensions n1 x n2 x n3 and explicit dimensions
%   n1 x n2*n3, then collapsedDim will return 2, indicating that n2 is the
%   contiguous dimension of the collapsed dimensions n2*n3
%
%   Note: This algorithm only applies if explicit dimensions are 2D

% Check nargin
assert(nargin == 2, 'Must have exactly 2 input arguments')
imdims = [imdims{:}];

% Check 2D-ness of exdims
assert(length(exdims) == 2, 'Exdims must be 2D')

% Do the calculation
y = -1;
collapsed_dims = 1;
for i = 1:length(imdims)
    collapsed_dims = collapsed_dims * imdims(i);
    if  collapsed_dims == exdims(1)
        y = i + 1;
        break;
    end
end