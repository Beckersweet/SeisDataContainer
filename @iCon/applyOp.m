function y = applyOp(op, x)
%APPLYOP Function to strip data from datacontainer for op to apply
%   y = applyOp(op,x);

% Unwrap data and multiply
y_data   = mtimes(op,double(x));

% Rewrap data
y        = dataCon(y_data);
y.header = headerMod(op,y.header);