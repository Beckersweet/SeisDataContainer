function x = zeros(varargin)
%OMATCON.ZEROS  Zeros array.
%
%   oMatCon.ones(N) is an N-by-N matrix of zeros.
%
%   oMatCon.ones(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   oMatCon.ones(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   oMatCon.ones(SIZE(A)) is the same size as A and all zeros.
%
%   oMatCon.ones with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
    x = oMatCon(zeros(varargin{:}));
end
