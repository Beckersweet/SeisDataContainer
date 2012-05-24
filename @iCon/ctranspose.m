function y = ctranspose(x)
%'  Complex conjugate tranpose.
%
%   x' is the complex conjugate transpose of x.
%
%   ctranspose(x) is called for the syntax x' when x is a data container.
%
%   See also iCon.transpose.

% Conjugate Transpose
y        = dataCon(ctranspose(double(x)));
y        = metacopy(x,y);
y.perm   = fliplr(x.perm);
y.exsize = fliplr(x.exsize);
indshift      = y.exsize(1);
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + indshift - 1;