function y = applyOp(x, op)
%APPLYOP Function to strip data from datacontainer for op to apply
%   y = applyOp(x,op) returns what op*x is supposed to return

% Unwrap data and multiply
y_data   = mtimes(op,double(x));

% Rewrap data
if isa(y_data,'distributed')
    y = piCon(y_data);
else
    y = iCon(y_data);
end
header        = x.header;
header.exsize = x.exsize; % Inject exsize
y.header      = headerMod(op,header,1);
y.exsize      = y.header.exsize; % Extract exsize

% Remove field
y.header = rmfield(y.header,'exsize');

% Post calculation reshape
x_n = size(x,2);
if ~all(size(y) == [prod(size(y))/x_n x_n])
    y = reshape(y,[prod(size(y))/x_n x_n]);
end