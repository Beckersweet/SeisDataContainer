function y = applyDivide(x,op)
%APPLYDIVIDE Summary of this function goes here
%   Detailed explanation goes here

% Preallocate y
x = double(x);
y = zeros(size(op,2),size(x,2));
for u = 1:size(x,2)
    y(:,u) = mldivide(op, x(:,u));
end