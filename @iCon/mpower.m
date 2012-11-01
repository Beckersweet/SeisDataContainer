function y = mpower(A,B,swp)
%^   Matrix power.
%
%   A^y is A to the y power.
%
%   Note: A must be square, and y must be scalar

% unswap
if nargin == 3 && strcmp(swp,'swap')
    tmp = B;
    B = A;
    A = tmp;
    clear('tmp');
end

if size(A,1) ~= size(A,2)
    error('Operator must be square.');
end
if ~isscalar(B)
    error('Exponent must be a scalar.');
else
    B = double(B);
end

if isa(A,'iCon')
    y = double(A) ^ B;
    if isa(y, 'distributed')
        y = piCon(y);
    else
        y = iCon(y);
    end
    y = metacopy(A,y);
else
    y = A ^ B;
end