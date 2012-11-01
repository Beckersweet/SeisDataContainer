function y = distributed(data)
%PICON.DISTRIBUTED  Distributes data and stores it as piCon
%
%   x = piCon.distributed(DATA) distributes DATA along the last dimension
%   and stores it as piCon x.

if isa(data,'iCon')
    y = piCon(distributed(double(data)));
    y.header.size = data.header.size;
    y.exsize      = data.exsize;
else
    y = piCon(distributed(data));
end