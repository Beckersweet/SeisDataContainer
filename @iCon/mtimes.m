function y = mtimes(A,B,swp)
%*   Matrix multiply.
%   X*Y is the matrix product of X and Y.  Any scalar (a 1-by-1 matrix)
%   may multiply anything.  Otherwise, the number of columns of X must
%   equal the number of rows of Y.

% unswap
if nargin == 3 && strcmp(swp,'swap')
    tmp = B;
    B   = A;
    A   = tmp;
    clear('tmp');
end

% Multiply
if ~isa(A,'SeisDataContainer') % Right multiply
    y = double( A*double(B) );
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(B,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size(2) = B.header.size(B.exsize(1,2):B.exsize(2,2));
    y.exsize(:,2)    = B.exsize(:,2) - B.exsize(1,2) + 2;
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size(1) = A.ms;
        y.exsize(:,1)    = [1 length(A.ms)]';
    else
        y.header.size(1) = size(A,1);
        y.exsize(:,1)    = [1 length(size(A,1))]';
    end
    
elseif ~isa(B,'SeisDataContainer') % Left multiply
    y = double( double(A)*B );
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size(1) = A.header.size(A.exsize(1,1):A.exsize(2,1));
    y.exsize(:,1)    = A.exsize(:,1);
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size(2) = B.ns;
        y.exsize(:,2)    = [1 length(B.ns)]' + y.exsize(2,1) + 1;
    end
    
else % Both data containers
    y = double(A)*double(B);
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
    % Extract collapsed dimensions
    y.header.size(2) = B.header.size(B.exsize(1,2):B.exsize(2,2));
    y.header.size(1) = A.header.size(A.exsize(1,1):A.exsize(2,1));
    y.exsize(:,1)    = A.exsize(:,1);
    y.exsize(:,2)    = B.exsize(:,2) - B.exsize(1,2) + A.exsize(2,1);
end