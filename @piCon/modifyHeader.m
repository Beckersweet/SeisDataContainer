function y = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched

y      = obj;
header = y.header;
dims   = y.header.dims;
p      = inputParser;
p.addParamValue('varName',header.varName,@ischar);
p.addParamValue('varUnits',header.varUnits,@ischar);
p.addParamValue('origin',header.origin,@(x)isrow(x)&&length(x)==dims);
p.addParamValue('delta',header.delta,@(x)isrow(x)&&length(x)==dims);
p.addParamValue('unit',header.unit,@(x)iscell(x)&&length(x)==dims);
p.addParamValue('label',header.label,@(x)iscell(x)&&length(x)==dims);
p.parse(varargin{:}{:});

header.varName  = p.Results.varName;
header.varUnits = p.Results.varUnits;
header.origin   = p.Results.origin;
header.delta    = p.Results.delta;
header.unit     = p.Results.unit;
header.label    = p.Results.label;
y.header        = header;
y               = {y};
end
