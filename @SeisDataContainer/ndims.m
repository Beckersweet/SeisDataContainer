function y = ndims(x)
%NDIMS  Number of dimensions of data container
%
%   NDIMS(X) returns the number of dimensions in the data container X.
%   The number of dimensions in an array is always greater than
%   or equal to 2.  Trailing singleton dimensions are ignored.
%   Put simply, it is LENGTH(SIZE(X)).
%
%   Note: This returns a Matlab numeric data array

y = length(size(x));