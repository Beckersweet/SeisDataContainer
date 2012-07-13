function y = transpose(x)
%.'   Data container tranpose.
%   A.' is the (non-conjugate) transpose of A.
%
%   transpose(A) is called for the syntax A.' when A is an data container.
%
%   See also iCon.ctranspose.

% Transpose
y             = dataCon(transpose(double(x)));
y             = metacopy(x,y);
y.perm        = fliplr(x.perm);
y.exsize      = fliplr(x.exsize);
indshift      = y.exsize(1);
y.header.size = [x.header.size(x.exsize(1,2):x.exsize(2,2)) ...
                 x.header.size(x.exsize(1,1):x.exsize(2,1))];
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + y.exsize(end,1);