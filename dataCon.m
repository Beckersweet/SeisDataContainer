function x = dataCon(varargin)
%DATACON Generic constructor for data container classes
%
%   dataCon(X) will return a piCon if X is distributed, and an iCon if its
%   not.

x = varargin{1};
if isdistributed(x)
    x = piCon(x);
else
    x = iCon(x);
end