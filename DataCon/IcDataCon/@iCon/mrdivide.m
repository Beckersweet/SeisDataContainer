function x = mrdivide(A,B)
%/   Slash or right matrix divide.
%   A/B is the matrix division of B into A, which is roughly the
%   same as A*INV(B) , except it is computed in a different way.
%   More precisely, A/B = (B'\A')'. See MLDIVIDE for details.

if isscalar(A) && isscalar(B)
   x = double(A) / double(B);
else
   x = (B'\A')';   
end
