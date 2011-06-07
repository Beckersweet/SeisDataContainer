function x = randn(varargin)
%RANDN Normally distributed pseudorandom numbers.
%
%   x = piCon.randn(N) returns an N-by-N matrix containing pseudorandom 
%   values drawn from the standard normal distribution.  piCon.randn(M,N) or
%   piCon.randn([M,N]) returns an M-by-N matrix. piCon.randn(M,N,P,...) or 
%   piCon.randn([M,N,P,...]) returns an M-by-N-by-P-by-... array. 
%   piCon.randn returns a scalar.  piCon.randn(SIZE(A)) returns
%   an array the same size as A.
%
%   Note: 
%   - The size inputs M, N, P, ... should be nonnegative integers.
%   Negative integers are treated as 0.
%   - The data is always distributed to the last dimension

x = piCon(distributed.randn(varargin{:}));