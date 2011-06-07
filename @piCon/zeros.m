function x = zeros(varargin)
%PICON.ZEROS  Zeros array.
%
%   piCon.zeros(N) is an N-by-N matrix of zeros.
%
%   piCon.zeros(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   piCon.zeros(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   piCon.zeros(SIZE(A)) is the same size as A and all zeros.
%
%   piCon.zeros with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.

x = piCon(distributed.zeros(varargin{:}));