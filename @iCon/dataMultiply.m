function y = dataMultiply(x, op)
%DATAMULTIPLY Function to strip data from datacontainer for op to apply
%   y = dataMultiply(x,op) returns what op*x is supposed to return

% Unwrap data and multiply
if op.activated
    y_data   = mtimes(op,double(x));
else % if not activated
    h = x.header;
    h.exsize = x.exsize;
    h.IDHistory = x.IDHistory;
    op = activateOp(op,h,1);
    
    y_data   = mtimes(op,double(x));
end
% Rewrap data
if isa(y_data,'distributed')
    y = piCon(y_data);
else
    y = iCon(y_data);
end
header        = x.header;
header.exsize = x.exsize; % Inject exsize
header.IDHistory = x.IDHistory; % Inject IDHistory
y.header      = headerMod(op, header, 1);
y.exsize      = y.header.exsize; % Extract exsize
y.IDHistory   = y.header.IDHistory; % Extract a list of history of operators

% Remove field
y.header = rmfield(y.header,'exsize');
y.header = rmfield(y.header,'IDHistory');

% Post calculation reshape
x_n = size(x,2);
if ~(length(size(y)) == 2 && size(y,2) == size(x,2))
    y = reshape(y,[prod(size(y))/x_n x_n]);
end