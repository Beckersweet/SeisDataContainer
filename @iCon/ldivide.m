function y = ldivide(A,B,swp)
%.\  Left array divide.
%   A.\B denotes element-by-element division.  A and B
%   must have the same dimensions unless one is a scalar.
%   A scalar can be divided with anything.
%
%   Note:
%   - The returned data container will contain the metadata of the left
%     operator.
%   - If strict flag is enforced in just one of the operators, then
%     both operators must have the same implicit dimensions.
%
%   See also RDIVIDE

if nargin == 3 && strcmp(swp,'swap')
   temp = A;
   A = B;
   B = temp;
   clear temp;
end

% Case for both scalars
if isscalar(A) && isscalar(B)
    y = double(A) .\ double(B);
    return;
end

if ~isa(A,'iCon') % Right divide
    y = double(A .\ double(B));
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(B,y);
            
elseif ~isa(B,'iCon') % Left divide
    y = double(double(A) .\ B);
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
    
else % Both data containers
    y = double(A) .\ double(B);
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
end