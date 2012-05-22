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
%   reshapes, consider using setimsize to change the implicit dimensions
%   before reshaping.
%
%   See also: invvec, dataContainer.vec, iCon.double, setimsize

% Check for the collapsibility of reshape
% Do the calculation
imsize  = x.header.size;
while (imsize(end) == 1) % Strip singleton dimensions
   imsize(end)  = [];
end
redims          = [varargin{:}];
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

% Reshape
y        = iCon(reshape(x.data,redims));
y.header.size = x.header.size;
y.exsize = collapsed_dims;
y.perm   = 1:length(collapsed_dims);