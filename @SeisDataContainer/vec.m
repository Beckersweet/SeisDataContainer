function y = vec(x)
%VEC    Vectorization of data container
%
%   vec(x) reshapes x into a <no. elements>-by-1 column vector
%   
%   See also: invvec

y = reshape(x,prod(size(x)),1);