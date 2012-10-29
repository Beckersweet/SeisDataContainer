function y = dataDivide(x,op)
%DATADIVIDE Summary of this function goes here
%   Detailed explanation goes here

% Preallocate y
x = double(x);
if isdistributed(x)
    y = distributed.zeros(size(op,2),size(x,2));
else
    y = zeros(size(op,2),size(x,2));
end

for u = 1:size(x,2)
    y(:,u) = mldivide(op, x(:,u));
end