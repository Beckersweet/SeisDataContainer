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
    y = dataCon(double( A*double(B) ));
    y = metacopy(B,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size = { size(A,1) B.header.size{2} };
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size{1} = A.ms;
    end
    
elseif ~isa(B,'SeisDataContainer') % Left multiply
    y = dataCon(double( double(A)*B ));
    y = metacopy(A,y);
    
    % Extract collapsed dimensions & permutation
    y.header.size = { A.header.size{1} size(B,2) };
    
    % Check for spot ms and ns
    if isa(A,'opSpot')
        y.header.size{2} = A.ns;
    end
    
else % Both data containers
    y = dataCon(double(A)*double(B));
    y = metacopy(A,y);
    
    % Extract collapsed dimensions
    y.header.size = { A.header.size{1} B.header.size{2} };
    y.perm   = 1:ndims(y); % Old perm is void
end

end % mtimes