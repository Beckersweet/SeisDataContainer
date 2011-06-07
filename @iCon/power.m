function y = power(A,B)
%.^  Array power.
%   Z = X.^Y denotes element-by-element powers.  X and Y
%   must have the same dimensions unless one is a scalar. 
%   A scalar can operate into anything.

y = dataCon(power(double(A),double(B)));

if isa(A,'iCon')
    y = metacopy(A,y);
else
    y = metacopy(B,y);
end