function y = applyOp(x, op)
%APPLYOP Function to strip data from datacontainer for op to apply
%   y = applyOp(x,op) returns what op*x is supposed to return

% Needs to implement this in the future
y = mtimes(op,double(x));