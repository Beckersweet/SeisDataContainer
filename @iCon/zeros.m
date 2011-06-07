function x = zeros(varargin)
%ICON.ZEROS  Zeros array.
%
%   iCon.zeros(N) is an N-by-N matrix of zeros.
%
%   iCon.zeros(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   iCon.zeros(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   iCon.zeros(SIZE(A)) is the same size as A and all zeros.
%
%   iCon.zeros with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.

x = iCon(zeros(varargin{:}));