function result = transpose(x)
%.'   Data container tranpose.
%   A.' is the (non-conjugate) transpose of A.
%
%   transpose(A) is called for the syntax A.' when A is an data container.
%
%   See also iCon.ctranspose.

% Transpose
result        = transpose(double(x));
if isa(result, 'distributed')
    result = piCon(result);
else
    result = iCon(result);
end
result        = metacopy(x,result);
result.perm   = fliplr(x.perm);
y.exsize      = fliplr(x.exsize);
indshift      = y.exsize(1);
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + y.exsize(end,1);
if x.imcoddims == 1
    result.imcoddims = 2;
    result.imcodpart = SDCpckg.utils.defaultDistribution(size(result,2));
else
    result.imcoddims = 1;    
    result.imcodpart = SDCpckg.utils.defaultDistribution(size(result,1));
end