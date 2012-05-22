function x = ones(varargin)
%ICON.ONES  Ones array.
%
%   iCon.ones(N) is an N-by-N matrix of ones.
%
%   iCon.ones(M,N) or iCon.ones([M,N]) is an M-by-N matrix of ones.
%
%   iCon.ones(M,N,P,...) or iCon.ones([M N P ...]) is an 
%   M-by-N-by-P-by-... array of ones.
%
%   iCon.ones(SIZE(A)) is the same size as A and all ones.
%
%   iCon.ones with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.

stringIndex = SeisDataContainer.utils.getFirstStringIndex(varargin{:});
if(stringIndex)
    x = iCon(ones(varargin{1:stringIndex-1}),varargin{stringIndex:end});
else
    x = iCon(ones(varargin{:}));
end
