function y = uplus(x)
%+  Unary plus.
%   +A for numeric arrays is A. 

y = iCon(uplus(double(x)));
y.imdims = x.imdims;