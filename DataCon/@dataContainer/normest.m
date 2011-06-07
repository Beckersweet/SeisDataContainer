function [e,cnt] = normest(x,varargin)
%NORMEST Estimate the matrix 2-norm.
%
%   normest(x) is an estimate of the 2-norm of the matrix S.
%
%   normest(x,tol) uses relative error tol instead of 1e-6.
%
%   [nrm,cnt] = normest(..) also gives the number of iterations used.
%
%   This function is a minor adaptation of Matlab's built-in NORMEST.
%
%   See also NORM, COND, RCOND, CONDEST.

[e,cnt] = normest(double(x),varargin{:});