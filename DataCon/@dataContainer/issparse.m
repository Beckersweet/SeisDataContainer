function result = issparse(x)
%ISSPARSE True for sparse matrix.
%   ISSPARSE(S) is 1 if the storage class of S is sparse
%   and 0 otherwise.
%
%   See also SPARSE, FULL.

result = issparse(double(x));