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
y.header.size = fliplr(x.header.size);
y.perm   = fliplr(x.perm);
if x.imcoddims == 1
    y.imcoddims = 2;
    y.imcodpart = x.imcodpart;
else
    y.imcoddims = 1;    
    y.imcodpart = x.imcodpart;
end