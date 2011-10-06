function y = invvec(x)
%INVVEC  Inverse-vectorization of a data container
%
%   invvec(X) reshapes the data container back into the original implicit
%   dimensions as specified in the property, x.header.size. The implicit
%   dimensions of X can be found by calling isize(x).
%
%   See also: dataContainer.vec, isize

redims = [x.header.size{:}];
while(redims(end) == 1 && length(redims) > 2) % Strip singleton dimensions
    redims(end) = [];
end
y      = reshape(x,redims);