function y = oppMatrix(x,varargin)
%OPPMATRIX   Convert a distributed matrix into a pSpot operator.
%
%   oppMatrix(A,DESCRIPTION) creates an operator that performs
%   matrix-vector multiplication with matrix A. The optional parameter
%   DESCRIPTION can be used to override the default operator name when
%   printed.
%
%   Note: divide is only supported if the matrix is square.

y = oppMatrix(double(x),varargin{:});