function e = end(A,k,n)
%END serves as the last index in an indexing expression.  In
%   that context, END = SIZE(X,k) when used as part of the k-th index.
%   Examples of this use are, X(3:end) and X(1,1:2:end-1).  When using END
%   to grow an array, as in X(end+1) = 5, make sure X exists first.
%
%   END(A,K,N) is called for indexing expressions involving the object A
%   when END is part of the K-th index out of N indices.  For example,
%   the expression A(end-1,:) calls A's END method with END(A,1,2).
%
%   See also: iCon.subsref, iCon.subsasgn

s = size(A);
s = [s ones(1,n-length(s)+1)];
if n == 1 && k == 1
   e = prod(s);
elseif n == ndims(A) || k < n
   e = s(k);
else % k == n || n ~= ndims(A)
   e = prod(s(k:end));
end