function y = abs(x)
%   ABS(X) is the absolute value of the elements of X. When
%   X is complex, ABS(X) is the complex modulus (magnitude) of
%   the elements of X.
%
%   Note: This returns a Matlab data array %%%
%   Note: Now returns dataContainer for testing purpose

%y = abs(double(x));
y = iCon(abs(double(x)));
y.header = x.header;
y.exsize = x.exsize;