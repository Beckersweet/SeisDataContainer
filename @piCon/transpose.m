function result = transpose(x)
%.'   Data container tranpose.
%   A.' is the (non-conjugate) transpose of A.
%
%   transpose(A) is called for the syntax A.' when A is an data container.
%
%   See also iCon.ctranspose.

% Transpose
result        = dataCon(transpose(double(x)));
result        = metacopy(x,result);
result.imdims = fliplr(x.imdims);
result.perm   = fliplr(x.perm);
if x.imcoddims == 1
    result.imcoddims = 2;
    result.imcodpart = pSPOT.utils.defaultDistribution(size(result,2));
else
    result.imcoddims = 1;    
    result.imcodpart = pSPOT.utils.defaultDistribution(size(result,1));
end