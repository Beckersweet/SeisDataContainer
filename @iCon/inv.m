function y = inv(x)
%INV    Matrix inverse.
%   INV(X) is the inverse of the square matrix X.
%   A warning message is printed if X is badly scaled or
%   nearly singular.

y        = dataCon(inv(double(x)));
y        = metacopy(x,y);
y.header.size = fliplr(x.header.size);
y.perm   = fliplr(x.perm);