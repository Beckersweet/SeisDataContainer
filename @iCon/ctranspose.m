function y = ctranspose(x)
%'  Complex conjugate tranpose.
%
%   x' is the complex conjugate transpose of x.
%
%   ctranspose(x) is called for the syntax x' when x is a data container.
%
%   See also iCon.transpose.

% Conjugate Transpose
y             = dataCon(ctranspose(double(x)));
y             = metacopy(x,y);
y.perm        = fliplr(x.perm);
y.exsize      = fliplr(x.exsize);
indshift      = y.exsize(1);
y.header.size = [x.header.size(x.exsize(1,2):x.exsize(2,2)) ...
                 x.header.size(x.exsize(1,1):x.exsize(2,1))];
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + y.exsize(end,1);