function y = power(A,B)
%.^  Array power.
%   Z = X.^Y denotes element-by-element powers.  X and Y
%   must have the same dimensions unless one is a scalar. 
%   A scalar can operate into anything.

y = power(double(A),double(B));
if isa(y, 'distributed')
    y = piCon(y);
else
    y = iCon(y);
end

if isa(A,'iCon')
    y = metacopy(A,y);
else
    y = metacopy(B,y);
end