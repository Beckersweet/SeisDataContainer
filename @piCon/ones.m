function x = ones(varargin)
%PICON.ONES  Ones array.
%
%   piCon.ones(N) is an N-by-N matrix of ones.
%
%   piCon.ones(M,N) or iCon.ones([M,N]) is an M-by-N matrix of ones.
%
%   piCon.ones(M,N,P,...) or iCon.ones([M N P ...]) is an 
%   M-by-N-by-P-by-... array of ones.
%
%   piCon.ones(SIZE(A)) is the same size as A and all ones.
%
%   piCon.ones with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.

stringIndex = SDCpckg.utils.getFirstStringIndex(varargin{:});
if(stringIndex)
    x = piCon(distributed.ones(varargin{1:stringIndex-1}),varargin{stringIndex:end});
else
    x = piCon(distributed.ones(varargin{:}));
end
