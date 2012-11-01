function y = full(x)
%FULL   Convert sparse matrix to full matrix.
%   A = FULL(X) converts a sparse matrix S to full storage
%   organization.  If X is a full matrix, it is left unchanged.
%
%   If A is full, issparse(A) returns 0.

y = full(double(x));
if isa(y, 'distributed')
    y = piCon(y);
else
    y = iCon(y);
end
y = metacopy(x,y);