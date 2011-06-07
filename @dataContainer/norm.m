function y = norm(x,p)
%NORM   Matrix or vector norm.
%
%   The behavior of NORM(Y) where Y contains NaNs will change in 
%   a future release. See DOC NORM.  
%
%   For matrices...
%       NORM(X) is the 2-norm of X.
%       NORM(X,2) is the same as NORM(X).
%       NORM(X,1) is the 1-norm of X.
%       NORM(X,inf) is the infinity norm of X.
%       NORM(X,'fro') is the Frobenius norm of X.
%       NORM(X,P) is available for matrix X only if P is 1, 2, inf or 'fro'
%
%   For vectors...
%       NORM(V,P)    = sum(abs(V).^P)^(1/P).
%       NORM(V)      = norm(V,2).
%       NORM(V,inf)  = max(abs(V)).
%       NORM(V,-inf) = min(abs(V)).
%
%   For tensors >= 3D... (A friendly reminder will be given)
%       NORM(X,P)    = sum(abs(vec(X)).^P)^(1/P).
%       NORM(X)      = norm(vec(X),2).
%       NORM(X,inf)  = max(abs(vec(X))).
%       NORM(X,-inf) = min(abs(vec(X))).

% Process and extract arguments
if nargin == 1, p = 2; end

% Process N-D data container
if length(size(x)) <= 2
    y = norm(x.data,p);
else
    switch(p)
        case inf
            y = nDimsInfNorm(x,@max);
            
        case -inf
            y = nDimsInfNorm(x,@min);
                        
        case {1,2}
            warning(['You are implicitly doing norm '...
                'on a vectorized N-D array, '...
                'Please use norm(x,"fro")' ]);
            y = nDimsPNorm(x,p).^(1/p);
            
        case 'fro'
            y = nDimsPNorm(x,2).^(1/2);
            
        otherwise
        error('Unsupported norm type');
    end
end

end % norm

% Helper functions

% sum(abs(X).^P)
function y = nDimsPNorm(x,p)
y = 0;
    if length(size(x)) == 2
        y = sum(sum(abs(x).^p));
    else
        SIZE = size(x);
        for i = 1:SIZE(end)
            y = y + nDimsPNorm(pSPOT.utils.ldind(x,i),p);
        end
    end
end

function y = nDimsInfNorm(x,p)
    if length(size(x)) == 2
        y = p(p(abs(x)));
    else
        SIZE = size(x);
        y = nDimsInfNorm(pSPOT.utils.ldind(x,1),p);
        for i = 2:SIZE(end)
            y = [ y nDimsInfNorm(pSPOT.utils.ldind(x,i),p)];
        end
        y = p(y);
    end
end