function y = plus(A,B,swp)
%+   Sum of two operators.
%
%   Note:
%   - The returned data container will contain the metadata of the left
%     operator.
%   - If strict flag is enforced in just one of the operators, then
%     both operators must have the same implicit dimensions.

if nargin == 3 && strcmp(swp,'swap')
   temp = A;
   A  = B;
   B  = temp;
   clear temp;
end

% Case for both scalars
if isscalar(A) && isscalar(B)
    y = double(A) + double(B);
    return;
end

if ~isa(A,'iCon') % Right plus
    y = double(A + double(B));
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(B,y);
    y.IDHistory = B.IDHistory;
            
elseif ~isa(B,'iCon') % Left plus
    y = double(double(A) + B);
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    y.IDHistory = A.IDHistory;
else % Both data containers
    y = double(A) + double(B);
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
    % Check for strict flag
    if A.strict || B.strict
       assert(all(A.header.size == B.header.size),...
           'Strict flag enforced. Implicit dimensions much match.')
    end
    
    % Complex propagation
    y.header.complex = A.header.complex || B.header.complex;
    
    % operation history
    y.IDHistory = A.IDHistory;
end