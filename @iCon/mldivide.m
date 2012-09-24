function y = mldivide(A,B,swp)
%\   Backslash or left matrix divide.
%   A\B is the matrix division of A into B, which is roughly the
%   same as INV(A)*B , except it is computed in a different way.
%   If A is an N-by-N matrix and B is a column vector with N
%   components, or a matrix with several such columns, then
%   X = A\B is the solution to the equation A*X = B. A warning
%   message is printed if A is badly scaled or nearly singular.
%   A\EYE(SIZE(A)) produces the inverse of A.
%
%   If A is an M-by-N matrix with M < or > N and B is a column
%   vector with M components, or a matrix with several such columns,
%   then X = A\B is the solution in the least squares sense to the
%   under- or overdetermined system of equations A*X = B. The
%   effective rank, K, of A is determined from the QR decomposition
%   with pivoting. A solution X is computed which has at most K
%   nonzero components per column. If K < N this will usually not
%   be the same solution as PINV(A)*B.  A\EYE(SIZE(A)) produces a
%   generalized inverse of A.
%
%   See also LDIVIDE, RDIVIDE, MRDIVIDE.

% unswap
if nargin == 3 && strcmp(swp,'swap')
    tmp = B;
    B   = A;
    A   = tmp;
    clear('tmp');
end

if isscalar(A) || isscalar(B)
    y = A .\ B;
    
elseif ~isa(A,'iCon')
    y = double( A \ double(B) );
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(B,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size(2) = B.header.size(B.exsize(1,2):B.exsize(2,2));
    y.exsize(:,2)    = B.exsize(:,2) - B.exsize(2,1) + 1;
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size(1) = A.ns;
        y.exsize(:,1)    = [1 length(A.ns)]';
    end
    
elseif ~isa(B,'iCon')
    y = double( double(A) \ B );
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size(1) = A.header.size(A.exsize(1,2):A.exsize(2,2));
    y.exsize(:,1)    = A.exsize(:,2) - A.exsize(2,1);
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size(2) = B.ns;
        y.exsize(:,2)    = [1 length(B.ns)]' + y.exsize(2,1) + 1;
    end
    
else % Both data containers
    y = double(A) \ double(B);
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
    % Extract collapsed dimensions
    y.header.size(2) = B.header.size(B.exsize(1,2):B.exsize(2,2));
    y.header.size(1) = A.header.size(A.exsize(1,2):A.exsize(2,2));
    y.exsize(:,1)    = A.exsize(:,2) - A.exsize(2,1);
    y.exsize(:,2)    = B.exsize(:,2) - B.exsize(2,1) + A.exsize(2,1);
end