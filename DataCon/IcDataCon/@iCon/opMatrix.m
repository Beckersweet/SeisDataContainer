function A = opMatrix(x,varargin)
%OPMATRIX   Spot converter for data container
%   opMatrix(A,DESCRIPTION) creates an operator that performs
%   matrix-vector multiplication with matrix A. The optional parameter
%   DESCRIPTION can be used to override the default operator name when
%   printed.

A = opMatrix(double(x),varargin{:});