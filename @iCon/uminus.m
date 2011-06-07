function y = uminus(x)
%-  Unary minus.
%   -A negates the elements of A.

y      = x;
y.data = uminus(double(x));