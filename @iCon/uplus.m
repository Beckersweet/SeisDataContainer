function y = uplus(x)
%+  Unary plus.
%   +A for numeric arrays is A. 

y      = x;
y.data = uplus(double(x));