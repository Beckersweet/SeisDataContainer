function result = ctranspose(x)
%'  Complex conjugate tranpose.
%
%   x' is the complex conjugate transpose of x.
%
%   ctranspose(x) is called for the syntax x' when x is a data container.
%
%   See also iCon.transpose.

% Conjugate Transpose
result        = dataCon(ctranspose(double(x)));
result        = metacopy(x,result);
result.imdims = fliplr(x.imdims);
result.perm   = fliplr(x.perm);