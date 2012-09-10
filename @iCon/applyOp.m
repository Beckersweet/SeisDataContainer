function y = applyOp(x, op)
%APPLYOP Function to strip data from datacontainer for op to apply
%   y = applyOp(x,op) returns what op*x is supposed to return

% Unwrap data and multiply
y_data   = mtimes(op,double(x));

% Rewrap data
y            = dataCon(y_data);
xmeta.exsize = x.exsize;
y.header     = headerMod(op,xmeta,x.header,1);