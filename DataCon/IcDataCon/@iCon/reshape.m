function y = reshape(x,varargin)
%RESHAPE    Reshape data container object to desired shape
%
%   reshape(X,N1,N2,...,N) reshapes data container X into the
%   dimensions defined as [N1,N2,...,N]. Note that the number of elements
%   must be conserved.
%
%   Note: The new reshape dimensions must always be a collapsed or
%   uncollapsed form of the original implicit dimension. Cross-dimensional
%   reshapes are not allowed. If you insist on doing cross-dimensional
%   reshapes, consider using setImDims to change the implicit dimensions
%   before reshaping.
%
%   See also: invvec, dataContainer.vec, iCon.double, setImDims

% Check for the collapsibility of reshape
% Do the calculation
imdims  = [x.imdims{:}];
perm    = [x.perm{:}];
while(imdims(end) == 1) % Strip singleton dimensions
    imdims(end) = [];
end
redims          = [varargin{:}];
j               = 1;
collapsed_chunk = [];
collapsed_perm  = [];
for i = 1:length(imdims)
    collapsed_chunk = [collapsed_chunk imdims(i)];
    collapsed_perm  = [collapsed_perm perm(i)];
    if  prod(collapsed_chunk) == redims(j)
        collapsed_dims{j}  = collapsed_chunk;
        collapsed_perms{j} = collapsed_perm;
        j = j + 1;
        collapsed_chunk = [];
        collapsed_perm  = [];
    elseif prod(collapsed_chunk) > redims(j)
        error(['Reshape dimensions must be collapsed '...
            'or multiples of implicit dimension']);
    end
end

% Compensate for 1D case
if length(collapsed_dims) == 1
    collapsed_dims{end + 1} = 1;
end

% Reshape
y        = iCon(reshape(x.data,redims));
y.imdims = collapsed_dims;
y.perm   = collapsed_perms;