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
if ~isa(A,'dataContainer') % Right multiply
    y = dataCon(double( A*double(B) ));
    y = metacopy(B,y);
    
    % Extract collapsed dimensions & permutation
    y.imdims = { size(A,1) B.imdims{2} };
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.imdims{1} = A.ms;
    end
    
elseif ~isa(B,'dataContainer') % Left multiply
    y = dataCon(double( double(A)*B ));
    y = metacopy(A,y);
    
    % Extract collapsed dimensions & permutation
    y.imdims = { A.imdims{1} size(B,2) };
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.imdims{2} = A.ns;
    end
    
else % Both data containers
    y = dataCon(double(A)*double(B));
    y = metacopy(A,y);
    
    % Extract collapsed dimensions
    y.imdims = { A.imdims{1} B.imdims{2} };
    y.perm   = 1:ndims(y); % Old perm is void
end

end % mtimes