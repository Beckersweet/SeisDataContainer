function y = applyMultiply(x, op)
%APPLYMULTIPLY Function to strip data from datacontainer for op to apply
%   y = applyMultiply(x,op) returns what op*x is supposed to return

% Import last dimension indexing function
ldind = @SDCpckg.utils.ldind;

% Unwrap data and multiply
y_data   = mtimes(op,double(x));

% Rewrap data
y             = y_data;
if isa(y, 'distributed')
    y = piCon(y);
else
    y = iCon(y);
end
header        = x.header;
header.exsize = x.exsize; % Inject exsize
y.header      = headerMod(op,header,1);
y.exsize      = y.header.exsize; % Extract exsize

% Remove field
y.header = rmfield(y.header,'exsize');

% Post calculation reshape
x_n = size(x,2);
y = reshape(y,[prod(size(y))/x_n x_n]);