function x = randn(varargin)
%RANDN Normally distributed pseudorandom numbers.
%
%   x = iCon.randn(N) returns an N-by-N matrix containing pseudorandom 
%   values drawn from the standard normal distribution.  iCon.randn(M,N) or
%   iCon.randn([M,N]) returns an M-by-N matrix. iCon.randn(M,N,P,...) or 
%   iCon.randn([M,N,P,...]) returns an M-by-N-by-P-by-... array. 
%   iCon.randn returns a scalar.  iCon.randn(SIZE(A)) returns
%   an array the same size as A.
%
%   Note: The size inputs M, N, P, ... should be nonnegative integers.
%   Negative integers are treated as 0.

x = iCon(randn(varargin{:}));