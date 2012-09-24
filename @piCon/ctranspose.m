function y = ctranspose(x)
%'  Complex conjugate tranpose.
%
%   x' is the complex conjugate transpose of x.
%
%   ctranspose(x) is called for the syntax x' when x is a data container.
%
%   See also iCon.transpose.

% Conjugate Transpose
y        = ctranspose(double(x));
if isa(y, 'distributed')
    y = piCon(y);
else
    y = iCon(y);
end
y        = metacopy(x,y);
y.perm   = fliplr(x.perm);
y.exsize = fliplr(x.exsize);
indshift      = y.exsize(1);
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + y.exsize(end,1);

if x.imcoddims == 1
    y.imcoddims = 2;
    y.imcodpart = SDCpckg.utils.defaultDistribution(size(y,2));
else
    y.imcoddims = 1;    
    y.imcodpart = SDCpckg.utils.defaultDistribution(size(y,1));
end
